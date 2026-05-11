package com.yanma408.study.interfaces.rest;

import com.yanma408.shared.application.security.CurrentUserProvider;
import com.yanma408.study.application.notification.StudyNotificationService;
import com.yanma408.study.application.notification.StudyNotificationPreference;
import com.yanma408.study.application.notification.StudyNotificationView;
import com.yanma408.study.application.query.StudyDashboardQueryService;
import com.yanma408.study.application.query.StudyDashboardView;
import com.yanma408.study.application.task.CreateStudyTaskCommand;
import com.yanma408.study.application.task.StudyTaskCommandService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/study")
public class StudyController {
    private final CurrentUserProvider currentUserProvider;
    private final StudyDashboardQueryService studyDashboardQueryService;
    private final StudyTaskCommandService studyTaskCommandService;
    private final StudyNotificationService studyNotificationService;

    public StudyController(
            CurrentUserProvider currentUserProvider,
            StudyDashboardQueryService studyDashboardQueryService,
            StudyTaskCommandService studyTaskCommandService,
            StudyNotificationService studyNotificationService
    ) {
        this.currentUserProvider = currentUserProvider;
        this.studyDashboardQueryService = studyDashboardQueryService;
        this.studyTaskCommandService = studyTaskCommandService;
        this.studyNotificationService = studyNotificationService;
    }

    @GetMapping("/dashboard")
    public StudyDashboardView dashboard() {
        return studyDashboardQueryService.findDashboard(currentUserProvider.currentUserId());
    }

    @GetMapping("/tasks")
    public List<StudyDashboardView.StudyTaskView> tasks(@RequestParam(required = false) LocalDate date) {
        return studyTaskCommandService.findByDate(currentUserProvider.currentUserId(), date);
    }

    @GetMapping("/tasks/range")
    public List<StudyDashboardView.StudyTaskView> tasksByRange(
            @RequestParam(required = false) LocalDate start,
            @RequestParam(required = false) LocalDate end
    ) {
        return studyTaskCommandService.findByRange(currentUserProvider.currentUserId(), start, end);
    }

    @PostMapping("/tasks")
    public StudyDashboardView.StudyTaskView createTask(@Valid @RequestBody CreateStudyTaskRequest request) {
        return studyTaskCommandService.create(
                currentUserProvider.currentUserId(),
                new CreateStudyTaskCommand(
                        request.title(),
                        request.subjectCode(),
                        request.taskType(),
                        request.targetCount(),
                        request.estimatedMinutes(),
                        request.priority(),
                        request.taskDate(),
                        request.recurrenceRule(),
                        request.reminderTime()
                )
        );
    }

    @PutMapping("/tasks/{id}")
    public StudyDashboardView.StudyTaskView updateTask(
            @PathVariable UUID id,
            @Valid @RequestBody CreateStudyTaskRequest request
    ) {
        return studyTaskCommandService.update(
                currentUserProvider.currentUserId(),
                id,
                new CreateStudyTaskCommand(
                        request.title(),
                        request.subjectCode(),
                        request.taskType(),
                        request.targetCount(),
                        request.estimatedMinutes(),
                        request.priority(),
                        request.taskDate(),
                        request.recurrenceRule(),
                        request.reminderTime()
                )
        );
    }

    @PatchMapping("/tasks/{id}/status")
    public void updateTaskStatus(@PathVariable UUID id, @Valid @RequestBody UpdateTaskStatusRequest request) {
        studyTaskCommandService.updateStatus(currentUserProvider.currentUserId(), id, request.status());
    }

    @PatchMapping("/tasks/{id}/occurrences/{date}/status")
    public void updateTaskOccurrenceStatus(
            @PathVariable UUID id,
            @PathVariable LocalDate date,
            @Valid @RequestBody UpdateTaskStatusRequest request
    ) {
        studyTaskCommandService.updateOccurrenceStatus(currentUserProvider.currentUserId(), id, date, request.status());
    }

    @GetMapping("/reminders")
    public List<StudyDashboardView.StudyTaskView> reminders(@RequestParam(required = false) LocalDate date) {
        return studyTaskCommandService.reminders(currentUserProvider.currentUserId(), date);
    }

    @GetMapping("/reminders/stream")
    public SseEmitter reminderStream(@RequestParam(required = false) LocalDate date) throws IOException {
        var emitter = new SseEmitter(30_000L);
        emitter.send(SseEmitter.event()
                .name("reminders")
                .data(studyTaskCommandService.reminders(currentUserProvider.currentUserId(), date)));
        emitter.complete();
        return emitter;
    }

    @PostMapping("/notifications/dispatch")
    public DispatchNotificationsResponse dispatchNotifications() {
        return new DispatchNotificationsResponse(studyNotificationService.createDueNotificationsNow());
    }

    @GetMapping("/notifications")
    public List<StudyNotificationView> notifications(@RequestParam(defaultValue = "false") boolean unreadOnly) {
        return studyNotificationService.findByUser(currentUserProvider.currentUserId(), unreadOnly);
    }

    @PatchMapping("/notifications/{id}/read")
    public void markNotificationRead(@PathVariable UUID id) {
        studyNotificationService.markRead(currentUserProvider.currentUserId(), id);
    }

    @GetMapping("/notifications/preferences")
    public List<StudyNotificationPreference> notificationPreferences() {
        return studyNotificationService.findPreferences(currentUserProvider.currentUserId());
    }

    @PutMapping("/notifications/preferences/{channel}")
    public void updateNotificationPreference(
            @PathVariable String channel,
            @Valid @RequestBody UpdateNotificationPreferenceRequest request
    ) {
        studyNotificationService.savePreference(currentUserProvider.currentUserId(), channel, request.enabled(), request.target());
    }

    @DeleteMapping("/tasks/{id}")
    public void deleteTask(@PathVariable UUID id) {
        studyTaskCommandService.delete(currentUserProvider.currentUserId(), id);
    }

    public record CreateStudyTaskRequest(
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

    public record UpdateTaskStatusRequest(
            @NotBlank String status
    ) {
    }

    public record UpdateNotificationPreferenceRequest(
            boolean enabled,
            String target
    ) {
    }

    public record DispatchNotificationsResponse(int createdCount) {
    }
}
