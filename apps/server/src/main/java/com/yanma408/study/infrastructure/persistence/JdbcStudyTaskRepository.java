package com.yanma408.study.infrastructure.persistence;

import com.yanma408.shared.exception.ResourceNotFoundException;
import com.yanma408.study.application.query.StudyDashboardView;
import com.yanma408.study.application.task.CreateStudyTaskCommand;
import com.yanma408.study.application.task.StudyTaskRepository;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Repository
public class JdbcStudyTaskRepository implements StudyTaskRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;

    public JdbcStudyTaskRepository(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<StudyDashboardView.StudyTaskView> findByDate(UUID userId, LocalDate taskDate) {
        return findCandidateTasks(userId, taskDate).stream()
                .filter(task -> occursOn(task, taskDate))
                .map(task -> withOccurrenceDate(task, taskDate))
                .toList();
    }

    @Override
    public List<StudyDashboardView.StudyTaskView> findByRange(UUID userId, LocalDate startDate, LocalDate endDate) {
        var tasks = new ArrayList<StudyDashboardView.StudyTaskView>();
        var date = startDate;
        while (!date.isAfter(endDate)) {
            tasks.addAll(findByDate(userId, date));
            date = date.plusDays(1);
        }
        return tasks;
    }

    private List<StudyDashboardView.StudyTaskView> findCandidateTasks(UUID userId, LocalDate taskDate) {
        var sql = """
                SELECT id, title, subject_code, task_type, target_count,
                       estimated_minutes, status, priority, task_date,
                       recurrence_rule, reminder_time, occurrence_status
                FROM (
                    SELECT t.id, t.title, t.subject_code, t.task_type, t.target_count,
                           t.estimated_minutes, t.status, t.priority, t.task_date,
                           t.recurrence_rule, t.reminder_time, sto.status AS occurrence_status,
                           t.created_at
                    FROM study_plan_tasks t
                    LEFT JOIN study_task_occurrences sto
                      ON sto.task_id = t.id
                     AND sto.occurrence_date = :taskDate
                    WHERE t.user_id = :userId
                      AND t.task_date <= :taskDate
                      AND t.status <> 'DELETED'
                ) tasks
                ORDER BY
                    task_date,
                    CASE priority
                        WHEN 'IMPORTANT' THEN 1
                        WHEN 'REVIEW' THEN 2
                        ELSE 3
                    END,
                    created_at
                """;
        var params = new MapSqlParameterSource()
                .addValue("userId", userId)
                .addValue("taskDate", taskDate);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> toTaskView(rs.getObject("task_date", LocalDate.class), rs));
    }

    @Override
    public StudyDashboardView.StudyTaskView create(UUID userId, CreateStudyTaskCommand command) {
        var taskId = UUID.randomUUID();
        var now = Instant.now();
        var sql = """
                INSERT INTO study_plan_tasks (
                    id, user_id, title, subject_code, task_type, target_count,
                    estimated_minutes, status, priority, task_date, recurrence_rule,
                    reminder_time, created_at, updated_at
                )
                VALUES (
                    :id, :userId, :title, :subjectCode, :taskType, :targetCount,
                    :estimatedMinutes, 'PENDING', :priority, :taskDate, :recurrenceRule,
                    :reminderTime, :createdAt, :updatedAt
                )
                """;
        var params = new MapSqlParameterSource()
                .addValue("id", taskId)
                .addValue("userId", userId)
                .addValue("title", command.title())
                .addValue("subjectCode", command.subjectCode())
                .addValue("taskType", command.taskType())
                .addValue("targetCount", command.targetCount())
                .addValue("estimatedMinutes", command.estimatedMinutes())
                .addValue("priority", command.priority())
                .addValue("taskDate", command.taskDate())
                .addValue("recurrenceRule", command.recurrenceRule())
                .addValue("reminderTime", command.reminderTime())
                .addValue("createdAt", Timestamp.from(now))
                .addValue("updatedAt", Timestamp.from(now));
        jdbcTemplate.update(sql, params);
        return new StudyDashboardView.StudyTaskView(
                taskId,
                command.title(),
                command.subjectCode(),
                command.taskType(),
                command.targetCount(),
                command.estimatedMinutes(),
                "PENDING",
                command.priority(),
                command.taskDate(),
                command.recurrenceRule(),
                command.reminderTime()
        );
    }

    @Override
    public StudyDashboardView.StudyTaskView update(UUID userId, UUID taskId, CreateStudyTaskCommand command) {
        var sql = """
                UPDATE study_plan_tasks
                SET title = :title,
                    subject_code = :subjectCode,
                    task_type = :taskType,
                    target_count = :targetCount,
                    estimated_minutes = :estimatedMinutes,
                    priority = :priority,
                    task_date = :taskDate,
                    recurrence_rule = :recurrenceRule,
                    reminder_time = :reminderTime,
                    updated_at = :updatedAt
                WHERE id = :taskId
                  AND user_id = :userId
                  AND status <> 'DELETED'
                """;
        var params = new MapSqlParameterSource()
                .addValue("title", command.title())
                .addValue("subjectCode", command.subjectCode())
                .addValue("taskType", command.taskType())
                .addValue("targetCount", command.targetCount())
                .addValue("estimatedMinutes", command.estimatedMinutes())
                .addValue("priority", command.priority())
                .addValue("taskDate", command.taskDate())
                .addValue("recurrenceRule", command.recurrenceRule())
                .addValue("reminderTime", command.reminderTime())
                .addValue("updatedAt", Timestamp.from(Instant.now()))
                .addValue("taskId", taskId)
                .addValue("userId", userId);
        int affectedRows = jdbcTemplate.update(sql, params);
        if (affectedRows == 0) {
            throw new ResourceNotFoundException("Study task not found: " + taskId);
        }
        var status = findStatus(userId, taskId);
        return new StudyDashboardView.StudyTaskView(
                taskId,
                command.title(),
                command.subjectCode(),
                command.taskType(),
                command.targetCount(),
                command.estimatedMinutes(),
                status,
                command.priority(),
                command.taskDate(),
                command.recurrenceRule(),
                command.reminderTime()
        );
    }

    @Override
    public void updateStatus(UUID userId, UUID taskId, String status) {
        var sql = """
                UPDATE study_plan_tasks
                SET status = :status,
                    updated_at = :updatedAt
                WHERE id = :taskId
                  AND user_id = :userId
                  AND status <> 'DELETED'
                """;
        var params = new MapSqlParameterSource()
                .addValue("status", status)
                .addValue("updatedAt", Timestamp.from(Instant.now()))
                .addValue("taskId", taskId)
                .addValue("userId", userId);
        int affectedRows = jdbcTemplate.update(sql, params);
        if (affectedRows == 0) {
            throw new ResourceNotFoundException("Study task not found: " + taskId);
        }
    }

    @Override
    public void updateOccurrenceStatus(UUID userId, UUID taskId, LocalDate occurrenceDate, String status) {
        assertTaskOwnedByUser(userId, taskId);
        jdbcTemplate.update("""
                DELETE FROM study_task_occurrences
                WHERE task_id = :taskId
                  AND occurrence_date = :occurrenceDate
                """, new MapSqlParameterSource()
                .addValue("taskId", taskId)
                .addValue("occurrenceDate", occurrenceDate));
        if ("PENDING".equals(status)) {
            return;
        }
        var sql = """
                INSERT INTO study_task_occurrences (
                    id, user_id, task_id, occurrence_date, status, updated_at
                )
                VALUES (
                    :id, :userId, :taskId, :occurrenceDate, :status, :updatedAt
                )
                """;
        var params = new MapSqlParameterSource()
                .addValue("id", UUID.randomUUID())
                .addValue("userId", userId)
                .addValue("taskId", taskId)
                .addValue("occurrenceDate", occurrenceDate)
                .addValue("status", status)
                .addValue("updatedAt", Timestamp.from(Instant.now()));
        jdbcTemplate.update(sql, params);
    }

    @Override
    public List<StudyDashboardView.StudyTaskView> findReminders(UUID userId, LocalDate date) {
        return findByDate(userId, date).stream()
                .filter(task -> task.reminderTime() != null)
                .filter(task -> !"DONE".equals(task.status()))
                .filter(task -> !"SKIPPED".equals(task.status()))
                .toList();
    }

    @Override
    public void delete(UUID userId, UUID taskId) {
        var sql = """
                UPDATE study_plan_tasks
                SET status = 'DELETED',
                    updated_at = :updatedAt
                WHERE id = :taskId
                  AND user_id = :userId
                  AND status <> 'DELETED'
                """;
        var params = new MapSqlParameterSource()
                .addValue("updatedAt", Timestamp.from(Instant.now()))
                .addValue("taskId", taskId)
                .addValue("userId", userId);
        int affectedRows = jdbcTemplate.update(sql, params);
        if (affectedRows == 0) {
            throw new ResourceNotFoundException("Study task not found: " + taskId);
        }
    }

    private String findStatus(UUID userId, UUID taskId) {
        var sql = """
                SELECT status
                FROM study_plan_tasks
                WHERE id = :taskId
                  AND user_id = :userId
                """;
        var params = new MapSqlParameterSource()
                .addValue("taskId", taskId)
                .addValue("userId", userId);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> rs.getString("status"))
                .stream()
                .findFirst()
                .orElseThrow(() -> new ResourceNotFoundException("Study task not found: " + taskId));
    }

    private void assertTaskOwnedByUser(UUID userId, UUID taskId) {
        var sql = """
                SELECT id
                FROM study_plan_tasks
                WHERE id = :taskId
                  AND user_id = :userId
                  AND status <> 'DELETED'
                """;
        var params = new MapSqlParameterSource()
                .addValue("taskId", taskId)
                .addValue("userId", userId);
        var exists = jdbcTemplate.query(sql, params, (rs, rowNum) -> rs.getObject("id", UUID.class))
                .stream()
                .findFirst();
        if (exists.isEmpty()) {
            throw new ResourceNotFoundException("Study task not found: " + taskId);
        }
    }

    private StudyDashboardView.StudyTaskView toTaskView(LocalDate occurrenceDate, java.sql.ResultSet rs) throws java.sql.SQLException {
        var reminderTime = rs.getObject("reminder_time", LocalTime.class);
        return new StudyDashboardView.StudyTaskView(
                rs.getObject("id", UUID.class),
                rs.getString("title"),
                rs.getString("subject_code"),
                rs.getString("task_type"),
                rs.getInt("target_count"),
                rs.getInt("estimated_minutes"),
                rs.getString("occurrence_status") == null ? rs.getString("status") : rs.getString("occurrence_status"),
                rs.getString("priority"),
                occurrenceDate,
                rs.getString("recurrence_rule"),
                reminderTime
        );
    }

    private boolean occursOn(StudyDashboardView.StudyTaskView task, LocalDate date) {
        if (date.isBefore(task.taskDate())) {
            return false;
        }
        return switch (task.recurrenceRule()) {
            case "DAILY" -> true;
            case "WEEKLY" -> ChronoUnit.DAYS.between(task.taskDate(), date) % 7 == 0;
            case "MONTHLY" -> date.getDayOfMonth() == Math.min(task.taskDate().getDayOfMonth(), date.lengthOfMonth());
            default -> task.taskDate().isEqual(date);
        };
    }

    private StudyDashboardView.StudyTaskView withOccurrenceDate(StudyDashboardView.StudyTaskView task, LocalDate occurrenceDate) {
        return new StudyDashboardView.StudyTaskView(
                task.id(),
                task.title(),
                task.subjectCode(),
                task.taskType(),
                task.targetCount(),
                task.estimatedMinutes(),
                task.status(),
                task.priority(),
                occurrenceDate,
                task.recurrenceRule(),
                task.reminderTime()
        );
    }
}
