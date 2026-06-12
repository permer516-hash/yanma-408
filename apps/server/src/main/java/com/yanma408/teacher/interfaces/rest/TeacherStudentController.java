package com.yanma408.teacher.interfaces.rest;

import com.yanma408.shared.application.security.CurrentUserProvider;
import com.yanma408.shared.application.security.UserRoleService;
import com.yanma408.teacher.application.StudentLearningDetail;
import com.yanma408.teacher.application.StudentLearningSummary;
import com.yanma408.teacher.application.TeacherClassCommandService;
import com.yanma408.teacher.application.TeacherClassView;
import com.yanma408.teacher.application.TeacherTaskAssignmentView;
import com.yanma408.teacher.application.TeacherStudentAnalyticsService;
import com.yanma408.teacher.application.TeacherUserView;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/teacher")
public class TeacherStudentController {
    private final CurrentUserProvider currentUserProvider;
    private final UserRoleService userRoleService;
    private final TeacherStudentAnalyticsService teacherStudentAnalyticsService;
    private final TeacherClassCommandService teacherClassCommandService;

    public TeacherStudentController(
            CurrentUserProvider currentUserProvider,
            UserRoleService userRoleService,
            TeacherStudentAnalyticsService teacherStudentAnalyticsService,
            TeacherClassCommandService teacherClassCommandService
    ) {
        this.currentUserProvider = currentUserProvider;
        this.userRoleService = userRoleService;
        this.teacherStudentAnalyticsService = teacherStudentAnalyticsService;
        this.teacherClassCommandService = teacherClassCommandService;
    }

    @GetMapping("/students")
    public List<StudentLearningSummary> students(
            @RequestParam(required = false) UUID classId,
            @RequestParam(required = false) String keyword
    ) {
        var userId = requireTeacher();
        return teacherStudentAnalyticsService.findStudents(userId, isAdmin(userId), classId, keyword);
    }

    @GetMapping("/students/candidates")
    public List<StudentLearningSummary> studentCandidates(@RequestParam(required = false) String keyword) {
        requireAdmin();
        return teacherClassCommandService.findStudentCandidates(keyword);
    }

    @GetMapping("/teachers")
    public List<TeacherUserView> teachers() {
        requireAdmin();
        return teacherClassCommandService.findTeachers();
    }

    @GetMapping("/students/export.csv")
    public ResponseEntity<byte[]> exportStudents(
            @RequestParam(required = false) UUID classId,
            @RequestParam(required = false) String keyword
    ) {
        var userId = requireTeacher();
        var csv = teacherStudentAnalyticsService.exportStudentsCsv(userId, isAdmin(userId), classId, keyword);
        return ResponseEntity.ok()
                .contentType(new MediaType("text", "csv", StandardCharsets.UTF_8))
                .header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition.attachment()
                        .filename("yanma408-students.csv", StandardCharsets.UTF_8)
                        .build()
                        .toString())
                .body(csv.getBytes(StandardCharsets.UTF_8));
    }

    @GetMapping("/students/{studentId}")
    public StudentLearningDetail studentDetail(
            @PathVariable UUID studentId,
            @RequestParam(required = false) UUID classId
    ) {
        var userId = requireTeacher();
        return teacherStudentAnalyticsService.findStudentDetail(userId, isAdmin(userId), classId, studentId);
    }

    @GetMapping("/classes")
    public List<TeacherClassView> classes() {
        var userId = requireTeacher();
        return teacherClassCommandService.findClasses(userId, isAdmin(userId));
    }

    @PostMapping("/classes")
    public TeacherClassView createClass(@Valid @RequestBody UpsertClassRequest request) {
        var userId = requireTeacher();
        var ownerTeacherId = isAdmin(userId) && request.teacherId() != null ? request.teacherId() : userId;
        return teacherClassCommandService.createClass(ownerTeacherId, request.name(), request.courseName(), request.description());
    }

    @PatchMapping("/classes/{classId}")
    public TeacherClassView updateClass(
            @PathVariable UUID classId,
            @Valid @RequestBody UpsertClassRequest request
    ) {
        var userId = requireTeacher();
        return teacherClassCommandService.updateClass(userId, isAdmin(userId), classId, request.name(), request.courseName(), request.description());
    }

    @DeleteMapping("/classes/{classId}")
    public void archiveClass(@PathVariable UUID classId) {
        var userId = requireTeacher();
        teacherClassCommandService.archiveClass(userId, isAdmin(userId), classId);
    }

    @PostMapping("/classes/{classId}/students")
    public TeacherClassView addStudents(
            @PathVariable UUID classId,
            @Valid @RequestBody AddStudentsRequest request
    ) {
        var userId = requireAdmin();
        return teacherClassCommandService.addStudents(userId, true, classId, request.studentIds());
    }

    @DeleteMapping("/classes/{classId}/students/{studentId}")
    public TeacherClassView removeStudent(
            @PathVariable UUID classId,
            @PathVariable UUID studentId
    ) {
        var userId = requireAdmin();
        return teacherClassCommandService.removeStudent(userId, true, classId, studentId);
    }

    @GetMapping("/classes/{classId}/assignments")
    public List<TeacherTaskAssignmentView> assignments(@PathVariable UUID classId) {
        var userId = requireTeacher();
        return teacherClassCommandService.findAssignments(userId, isAdmin(userId), classId);
    }

    @PostMapping("/classes/{classId}/assignments")
    public TeacherTaskAssignmentView assignTask(
            @PathVariable UUID classId,
            @Valid @RequestBody AssignTaskRequest request
    ) {
        var userId = requireTeacher();
        return teacherClassCommandService.assignTask(userId, isAdmin(userId), classId, new TeacherClassCommandService.AssignTaskCommand(
                request.title(),
                request.subjectCode(),
                request.taskType(),
                request.targetCount(),
                request.estimatedMinutes(),
                request.priority(),
                request.taskDate(),
                request.recurrenceRule(),
                request.reminderTime()
        ));
    }

    private UUID requireTeacher() {
        var userId = currentUserProvider.currentUserId();
        userRoleService.requireAny(userId, "TEACHER", "ADMIN");
        return userId;
    }

    private UUID requireAdmin() {
        var userId = currentUserProvider.currentUserId();
        userRoleService.requireAny(userId, "ADMIN");
        return userId;
    }

    private boolean isAdmin(UUID userId) {
        return userRoleService.roles(userId).contains("ADMIN");
    }

    public record UpsertClassRequest(
            UUID teacherId,
            @NotBlank @Size(max = 80) String name,
            @NotBlank @Size(max = 80) String courseName,
            @Size(max = 500) String description
    ) {
    }

    public record AddStudentsRequest(
            @NotEmpty List<UUID> studentIds
    ) {
    }

    public record AssignTaskRequest(
            @NotBlank @Size(max = 128) String title,
            @NotBlank String subjectCode,
            @NotBlank String taskType,
            @Min(1) int targetCount,
            @Min(1) int estimatedMinutes,
            @NotBlank String priority,
            LocalDate taskDate,
            String recurrenceRule,
            LocalTime reminderTime
    ) {
    }
}
