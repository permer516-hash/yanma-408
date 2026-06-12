package com.yanma408.teacher.application;

import com.yanma408.shared.exception.ResourceNotFoundException;
import com.yanma408.study.application.task.CreateStudyTaskCommand;
import com.yanma408.study.application.task.StudyTaskCommandService;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Service
public class TeacherClassCommandService {
    private static final Set<String> ALLOWED_SUBJECTS = Set.of(
            "DATA_STRUCTURE",
            "COMPUTER_ORGANIZATION",
            "OPERATING_SYSTEM",
            "COMPUTER_NETWORK"
    );
    private static final Set<String> ALLOWED_TASK_TYPES = Set.of("QUESTION_SET", "WEAK_POINT", "MISTAKE_REVIEW", "CUSTOM");
    private static final Set<String> ALLOWED_PRIORITIES = Set.of("NORMAL", "IMPORTANT", "REVIEW");
    private static final Set<String> ALLOWED_RECURRENCE_RULES = Set.of("NONE", "DAILY", "WEEKLY", "MONTHLY");

    private final NamedParameterJdbcTemplate jdbcTemplate;
    private final StudyTaskCommandService studyTaskCommandService;

    public TeacherClassCommandService(
            NamedParameterJdbcTemplate jdbcTemplate,
            StudyTaskCommandService studyTaskCommandService
    ) {
        this.jdbcTemplate = jdbcTemplate;
        this.studyTaskCommandService = studyTaskCommandService;
    }

    public List<TeacherClassView> findClasses(UUID teacherId, boolean admin) {
        var sql = new StringBuilder("""
                SELECT c.id,
                       c.teacher_id,
                       teacher.username AS teacher_username,
                       teacher.display_name AS teacher_display_name,
                       c.name,
                       c.course_name,
                       c.description,
                       c.status,
                       COUNT(cs.student_id) AS student_count,
                       c.created_at,
                       c.updated_at
                FROM teacher_classes c
                JOIN app_users teacher ON teacher.id = c.teacher_id
                LEFT JOIN teacher_class_students cs ON cs.class_id = c.id
                WHERE c.status <> 'ARCHIVED'
                """);
        var params = new MapSqlParameterSource();
        if (!admin) {
            sql.append(" AND c.teacher_id = :teacherId\n");
            params.addValue("teacherId", teacherId);
        }
        sql.append("""
                GROUP BY c.id, c.teacher_id, teacher.username, teacher.display_name,
                         c.name, c.course_name, c.description, c.status, c.created_at, c.updated_at
                ORDER BY c.created_at DESC
                """);
        return jdbcTemplate.query(sql.toString(), params, (rs, rowNum) -> toClassView(rs));
    }

    public List<TeacherUserView> findTeachers() {
        return jdbcTemplate.query("""
                SELECT u.id, u.username, u.display_name
                FROM app_users u
                JOIN app_user_roles ur ON ur.user_id = u.id AND ur.role = 'TEACHER'
                ORDER BY u.display_name, u.username
                """, (rs, rowNum) -> new TeacherUserView(
                rs.getObject("id", UUID.class),
                rs.getString("username"),
                rs.getString("display_name")
        ));
    }

    @Transactional
    public TeacherClassView createClass(UUID teacherId, String name, String courseName, String description) {
        assertTeacher(teacherId);
        var id = UUID.randomUUID();
        var now = Instant.now();
        jdbcTemplate.update("""
                INSERT INTO teacher_classes (
                    id, teacher_id, name, course_name, description, status, created_at, updated_at
                )
                VALUES (
                    :id, :teacherId, :name, :courseName, :description, 'ACTIVE', :createdAt, :updatedAt
                )
                """, new MapSqlParameterSource()
                .addValue("id", id)
                .addValue("teacherId", teacherId)
                .addValue("name", normalizeText(name, "name", 80))
                .addValue("courseName", normalizeText(courseName, "courseName", 80))
                .addValue("description", normalizeOptionalText(description, 500))
                .addValue("createdAt", Timestamp.from(now))
                .addValue("updatedAt", Timestamp.from(now)));
        return findClass(id);
    }

    @Transactional
    public TeacherClassView updateClass(
            UUID teacherId,
            boolean admin,
            UUID classId,
            String name,
            String courseName,
            String description
    ) {
        requireClassAccess(teacherId, admin, classId);
        var affectedRows = jdbcTemplate.update("""
                UPDATE teacher_classes
                SET name = :name,
                    course_name = :courseName,
                    description = :description,
                    updated_at = CURRENT_TIMESTAMP
                WHERE id = :classId
                  AND status <> 'ARCHIVED'
                """, new MapSqlParameterSource()
                .addValue("classId", classId)
                .addValue("name", normalizeText(name, "name", 80))
                .addValue("courseName", normalizeText(courseName, "courseName", 80))
                .addValue("description", normalizeOptionalText(description, 500)));
        if (affectedRows == 0) {
            throw new ResourceNotFoundException("Teacher class not found: " + classId);
        }
        return findClass(classId);
    }

    @Transactional
    public void archiveClass(UUID teacherId, boolean admin, UUID classId) {
        requireClassAccess(teacherId, admin, classId);
        jdbcTemplate.update("""
                UPDATE teacher_classes
                SET status = 'ARCHIVED',
                    updated_at = CURRENT_TIMESTAMP
                WHERE id = :classId
                """, new MapSqlParameterSource("classId", classId));
    }

    @Transactional
    public TeacherClassView addStudents(UUID teacherId, boolean admin, UUID classId, List<UUID> studentIds) {
        requireClassAccess(teacherId, admin, classId);
        if (studentIds == null || studentIds.isEmpty()) {
            throw new IllegalArgumentException("studentIds must not be empty");
        }
        var normalized = studentIds.stream().distinct().toList();
        assertStudents(normalized);
        for (UUID studentId : normalized) {
            var params = new MapSqlParameterSource()
                    .addValue("classId", classId)
                    .addValue("studentId", studentId);
            var existing = jdbcTemplate.queryForObject("""
                    SELECT COUNT(*)
                    FROM teacher_class_students
                    WHERE class_id = :classId
                      AND student_id = :studentId
                    """, params, Integer.class);
            if (existing == null || existing == 0) {
                jdbcTemplate.update("""
                        INSERT INTO teacher_class_students (class_id, student_id, created_at)
                        VALUES (:classId, :studentId, CURRENT_TIMESTAMP)
                        """, params);
            }
        }
        return findClass(classId);
    }

    @Transactional
    public TeacherClassView removeStudent(UUID teacherId, boolean admin, UUID classId, UUID studentId) {
        requireClassAccess(teacherId, admin, classId);
        jdbcTemplate.update("""
                DELETE FROM teacher_class_students
                WHERE class_id = :classId
                  AND student_id = :studentId
                """, new MapSqlParameterSource()
                .addValue("classId", classId)
                .addValue("studentId", studentId));
        return findClass(classId);
    }

    @Transactional
    public TeacherTaskAssignmentView assignTask(UUID teacherId, boolean admin, UUID classId, AssignTaskCommand command) {
        requireClassAccess(teacherId, admin, classId);
        var studentIds = findStudentIds(classId);
        if (studentIds.isEmpty()) {
            throw new IllegalArgumentException("Class has no students");
        }
        var normalized = normalizeAssignTask(command);
        var assignmentId = UUID.randomUUID();
        var now = Instant.now();
        jdbcTemplate.update("""
                INSERT INTO teacher_task_assignments (
                    id, class_id, teacher_id, title, subject_code, task_type, target_count,
                    estimated_minutes, priority, task_date, recurrence_rule, reminder_time,
                    assigned_count, created_at
                )
                VALUES (
                    :id, :classId, :teacherId, :title, :subjectCode, :taskType, :targetCount,
                    :estimatedMinutes, :priority, :taskDate, :recurrenceRule, :reminderTime,
                    :assignedCount, :createdAt
                )
                """, new MapSqlParameterSource()
                .addValue("id", assignmentId)
                .addValue("classId", classId)
                .addValue("teacherId", teacherId)
                .addValue("title", normalized.title())
                .addValue("subjectCode", normalized.subjectCode())
                .addValue("taskType", normalized.taskType())
                .addValue("targetCount", normalized.targetCount())
                .addValue("estimatedMinutes", normalized.estimatedMinutes())
                .addValue("priority", normalized.priority())
                .addValue("taskDate", normalized.taskDate())
                .addValue("recurrenceRule", normalized.recurrenceRule())
                .addValue("reminderTime", normalized.reminderTime())
                .addValue("assignedCount", studentIds.size())
                .addValue("createdAt", Timestamp.from(now)));

        for (UUID studentId : studentIds) {
            var task = studyTaskCommandService.create(studentId, new CreateStudyTaskCommand(
                    normalized.title(),
                    normalized.subjectCode(),
                    normalized.taskType(),
                    normalized.targetCount(),
                    normalized.estimatedMinutes(),
                    normalized.priority(),
                    normalized.taskDate(),
                    normalized.recurrenceRule(),
                    normalized.reminderTime()
            ));
            jdbcTemplate.update("""
                    UPDATE study_plan_tasks
                    SET teacher_assignment_id = :assignmentId
                    WHERE id = :taskId
                    """, new MapSqlParameterSource()
                    .addValue("assignmentId", assignmentId)
                    .addValue("taskId", task.id()));
        }
        return findAssignment(assignmentId);
    }

    public List<TeacherTaskAssignmentView> findAssignments(UUID teacherId, boolean admin, UUID classId) {
        requireClassAccess(teacherId, admin, classId);
        return jdbcTemplate.query("""
                SELECT id, class_id, teacher_id, title, subject_code, task_type,
                       target_count, estimated_minutes, priority, task_date,
                       recurrence_rule, reminder_time, assigned_count, created_at
                FROM teacher_task_assignments
                WHERE class_id = :classId
                ORDER BY created_at DESC
                """, new MapSqlParameterSource("classId", classId), (rs, rowNum) -> toAssignmentView(rs));
    }

    public List<StudentLearningSummary> findStudentCandidates(String keyword) {
        var sql = new StringBuilder("""
                SELECT u.id,
                       u.username,
                       u.display_name,
                       u.created_at,
                       0 AS attempt_count,
                       0 AS correct_count,
                       0 AS mistake_count,
                       0 AS pending_mistake_count,
                       0 AS mastered_mistake_count,
                       0 AS exam_attempt_count,
                       0 AS latest_exam_accuracy_percent,
                       u.created_at AS latest_activity_at
                FROM app_users u
                JOIN app_user_roles ur ON ur.user_id = u.id AND ur.role = 'STUDENT'
                WHERE 1 = 1
                """);
        var params = new MapSqlParameterSource();
        if (keyword != null && !keyword.isBlank()) {
            sql.append(" AND (LOWER(u.username) LIKE :keyword OR LOWER(u.display_name) LIKE :keyword)\n");
            params.addValue("keyword", "%" + keyword.trim().toLowerCase() + "%");
        }
        sql.append("ORDER BY u.created_at DESC LIMIT 50");
        return jdbcTemplate.query(sql.toString(), params, (rs, rowNum) -> new StudentLearningSummary(
                rs.getObject("id", UUID.class),
                rs.getString("username"),
                rs.getString("display_name"),
                getInstant(rs, "created_at"),
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                getInstant(rs, "latest_activity_at")
        ));
    }

    private TeacherClassView findClass(UUID classId) {
        return jdbcTemplate.query("""
                SELECT c.id,
                       c.teacher_id,
                       teacher.username AS teacher_username,
                       teacher.display_name AS teacher_display_name,
                       c.name,
                       c.course_name,
                       c.description,
                       c.status,
                       COUNT(cs.student_id) AS student_count,
                       c.created_at,
                       c.updated_at
                FROM teacher_classes c
                JOIN app_users teacher ON teacher.id = c.teacher_id
                LEFT JOIN teacher_class_students cs ON cs.class_id = c.id
                WHERE c.id = :classId
                GROUP BY c.id, c.teacher_id, teacher.username, teacher.display_name,
                         c.name, c.course_name, c.description, c.status, c.created_at, c.updated_at
                """, new MapSqlParameterSource("classId", classId), (rs, rowNum) -> toClassView(rs))
                .stream()
                .findFirst()
                .orElseThrow(() -> new ResourceNotFoundException("Teacher class not found: " + classId));
    }

    private TeacherTaskAssignmentView findAssignment(UUID assignmentId) {
        return jdbcTemplate.query("""
                SELECT id, class_id, teacher_id, title, subject_code, task_type,
                       target_count, estimated_minutes, priority, task_date,
                       recurrence_rule, reminder_time, assigned_count, created_at
                FROM teacher_task_assignments
                WHERE id = :assignmentId
                """, new MapSqlParameterSource("assignmentId", assignmentId), (rs, rowNum) -> toAssignmentView(rs))
                .stream()
                .findFirst()
                .orElseThrow(() -> new ResourceNotFoundException("Teacher assignment not found: " + assignmentId));
    }

    private void requireClassAccess(UUID teacherId, boolean admin, UUID classId) {
        var count = jdbcTemplate.queryForObject("""
                SELECT COUNT(*)
                FROM teacher_classes
                WHERE id = :classId
                  AND status <> 'ARCHIVED'
                  AND (:admin = true OR teacher_id = :teacherId)
                """, new MapSqlParameterSource()
                .addValue("classId", classId)
                .addValue("admin", admin)
                .addValue("teacherId", teacherId), Integer.class);
        if (count == null || count == 0) {
            throw new ResourceNotFoundException("Teacher class not found: " + classId);
        }
    }

    private void assertStudents(List<UUID> studentIds) {
        var count = jdbcTemplate.queryForObject("""
                SELECT COUNT(DISTINCT u.id)
                FROM app_users u
                JOIN app_user_roles ur ON ur.user_id = u.id AND ur.role = 'STUDENT'
                WHERE u.id IN (:studentIds)
                """, new MapSqlParameterSource("studentIds", studentIds), Integer.class);
        if (count == null || count != studentIds.size()) {
            throw new IllegalArgumentException("All studentIds must be STUDENT users");
        }
    }

    private void assertTeacher(UUID teacherId) {
        var count = jdbcTemplate.queryForObject("""
                SELECT COUNT(DISTINCT u.id)
                FROM app_users u
                JOIN app_user_roles ur ON ur.user_id = u.id AND ur.role = 'TEACHER'
                WHERE u.id = :teacherId
                """, new MapSqlParameterSource("teacherId", teacherId), Integer.class);
        if (count == null || count == 0) {
            throw new IllegalArgumentException("teacherId must reference a TEACHER user");
        }
    }

    private List<UUID> findStudentIds(UUID classId) {
        return jdbcTemplate.query("""
                SELECT student_id
                FROM teacher_class_students
                WHERE class_id = :classId
                ORDER BY created_at
                """, new MapSqlParameterSource("classId", classId), (rs, rowNum) -> rs.getObject("student_id", UUID.class));
    }

    private AssignTaskCommand normalizeAssignTask(AssignTaskCommand command) {
        if (command.targetCount() < 1) {
            throw new IllegalArgumentException("targetCount must be positive");
        }
        if (command.estimatedMinutes() < 1) {
            throw new IllegalArgumentException("estimatedMinutes must be positive");
        }
        return new AssignTaskCommand(
                normalizeText(command.title(), "title", 128),
                normalizeAllowed(command.subjectCode(), ALLOWED_SUBJECTS, "subjectCode"),
                normalizeAllowed(command.taskType(), ALLOWED_TASK_TYPES, "taskType"),
                command.targetCount(),
                command.estimatedMinutes(),
                normalizeAllowed(command.priority(), ALLOWED_PRIORITIES, "priority"),
                command.taskDate() == null ? LocalDate.now() : command.taskDate(),
                command.recurrenceRule() == null || command.recurrenceRule().isBlank()
                        ? "NONE"
                        : normalizeAllowed(command.recurrenceRule(), ALLOWED_RECURRENCE_RULES, "recurrenceRule"),
                command.reminderTime()
        );
    }

    private String normalizeAllowed(String value, Set<String> allowedValues, String fieldName) {
        var normalized = normalizeText(value, fieldName, 80).toUpperCase();
        if (!allowedValues.contains(normalized)) {
            throw new IllegalArgumentException("Unsupported " + fieldName + ": " + value);
        }
        return normalized;
    }

    private String normalizeText(String value, String fieldName, int maxLength) {
        if (value == null || value.isBlank()) {
            throw new IllegalArgumentException(fieldName + " must not be blank");
        }
        var normalized = value.trim();
        if (normalized.length() > maxLength) {
            throw new IllegalArgumentException(fieldName + " is too long");
        }
        return normalized;
    }

    private String normalizeOptionalText(String value, int maxLength) {
        if (value == null || value.isBlank()) {
            return null;
        }
        var normalized = value.trim();
        return normalized.length() > maxLength ? normalized.substring(0, maxLength) : normalized;
    }

    private TeacherClassView toClassView(ResultSet rs) throws SQLException {
        return new TeacherClassView(
                rs.getObject("id", UUID.class),
                rs.getObject("teacher_id", UUID.class),
                rs.getString("teacher_username"),
                rs.getString("teacher_display_name"),
                rs.getString("name"),
                rs.getString("course_name"),
                rs.getString("description"),
                rs.getString("status"),
                rs.getInt("student_count"),
                getInstant(rs, "created_at"),
                getInstant(rs, "updated_at")
        );
    }

    private TeacherTaskAssignmentView toAssignmentView(ResultSet rs) throws SQLException {
        return new TeacherTaskAssignmentView(
                rs.getObject("id", UUID.class),
                rs.getObject("class_id", UUID.class),
                rs.getObject("teacher_id", UUID.class),
                rs.getString("title"),
                rs.getString("subject_code"),
                rs.getString("task_type"),
                rs.getInt("target_count"),
                rs.getInt("estimated_minutes"),
                rs.getString("priority"),
                rs.getObject("task_date", LocalDate.class),
                rs.getString("recurrence_rule"),
                rs.getObject("reminder_time", LocalTime.class),
                rs.getInt("assigned_count"),
                getInstant(rs, "created_at")
        );
    }

    private Instant getInstant(ResultSet rs, String column) throws SQLException {
        Timestamp timestamp = rs.getTimestamp(column);
        return timestamp == null ? null : timestamp.toInstant();
    }

    public record AssignTaskCommand(
            String title,
            String subjectCode,
            String taskType,
            int targetCount,
            int estimatedMinutes,
            String priority,
            LocalDate taskDate,
            String recurrenceRule,
            LocalTime reminderTime
    ) {
    }
}
