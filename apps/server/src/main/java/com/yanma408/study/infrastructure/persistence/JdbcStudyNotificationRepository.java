package com.yanma408.study.infrastructure.persistence;

import com.yanma408.shared.exception.ResourceNotFoundException;
import com.yanma408.study.application.notification.StudyNotificationPreference;
import com.yanma408.study.application.notification.StudyNotificationRepository;
import com.yanma408.study.application.notification.StudyNotificationView;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.UUID;

@Repository
public class JdbcStudyNotificationRepository implements StudyNotificationRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;

    public JdbcStudyNotificationRepository(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public int createDueNotifications(LocalDate date, LocalTime now) {
        var tasks = jdbcTemplate.query("""
                SELECT t.id, t.user_id, t.title, t.task_date, t.recurrence_rule,
                       t.reminder_time, COALESCE(sto.status, t.status) AS effective_status
                FROM study_plan_tasks t
                LEFT JOIN study_task_occurrences sto
                  ON sto.task_id = t.id
                 AND sto.occurrence_date = :date
                WHERE t.status <> 'DELETED'
                  AND t.reminder_time IS NOT NULL
                  AND t.reminder_time <= :now
                  AND t.task_date <= :date
                """, new MapSqlParameterSource()
                .addValue("date", date)
                .addValue("now", now), (rs, rowNum) -> new DueTask(
                rs.getObject("id", UUID.class),
                rs.getObject("user_id", UUID.class),
                rs.getString("title"),
                rs.getObject("task_date", LocalDate.class),
                rs.getString("recurrence_rule"),
                rs.getString("effective_status")
        )).stream()
                .filter(task -> !"DONE".equals(task.status()))
                .filter(task -> !"SKIPPED".equals(task.status()))
                .filter(task -> occursOn(task, date))
                .toList();
        var created = 0;
        for (DueTask task : tasks) {
            var channels = enabledChannels(task.userId());
            for (String channel : channels) {
                created += jdbcTemplate.update("""
                    INSERT INTO study_notifications (
                        id, user_id, task_id, notification_date, channel, title,
                        content, read_at, created_at
                    )
                    VALUES (
                        :id, :userId, :taskId, :date, :channel, :title,
                        :content, null, :createdAt
                    )
                    ON CONFLICT DO NOTHING
                    """, new MapSqlParameterSource()
                    .addValue("id", UUID.randomUUID())
                    .addValue("userId", task.userId())
                    .addValue("taskId", task.id())
                    .addValue("date", date)
                    .addValue("channel", channel)
                    .addValue("title", "学习提醒")
                    .addValue("content", task.title())
                    .addValue("createdAt", Timestamp.from(Instant.now())));
            }
        }
        return created;
    }

    @Override
    public List<StudyNotificationView> findByUser(UUID userId, boolean unreadOnly) {
        var sql = new StringBuilder("""
                SELECT id, task_id, notification_date, channel, title, content,
                       read_at, created_at
                FROM study_notifications
                WHERE user_id = :userId
                """);
        if (unreadOnly) {
            sql.append(" AND read_at IS NULL\n");
        }
        sql.append("ORDER BY created_at DESC LIMIT 30");
        return jdbcTemplate.query(sql.toString(), new MapSqlParameterSource("userId", userId), (rs, rowNum) -> toView(rs));
    }

    @Override
    public void markRead(UUID userId, UUID notificationId) {
        var affectedRows = jdbcTemplate.update("""
                UPDATE study_notifications
                SET read_at = CURRENT_TIMESTAMP
                WHERE id = :id
                  AND user_id = :userId
                """, new MapSqlParameterSource()
                .addValue("id", notificationId)
                .addValue("userId", userId));
        if (affectedRows == 0) {
            throw new ResourceNotFoundException("Notification not found: " + notificationId);
        }
    }

    @Override
    public List<StudyNotificationPreference> findPreferences(UUID userId) {
        ensureDefaultPreferences(userId);
        return jdbcTemplate.query("""
                SELECT channel, enabled, target, updated_at
                FROM study_notification_preferences
                WHERE user_id = :userId
                ORDER BY CASE channel
                    WHEN 'IN_APP' THEN 1
                    WHEN 'BROWSER' THEN 2
                    WHEN 'EMAIL' THEN 3
                    ELSE 4
                END
                """, new MapSqlParameterSource("userId", userId), (rs, rowNum) -> new StudyNotificationPreference(
                rs.getString("channel"),
                rs.getBoolean("enabled"),
                rs.getString("target"),
                rs.getTimestamp("updated_at").toInstant()
        ));
    }

    @Override
    public void savePreference(UUID userId, String channel, boolean enabled, String target) {
        var params = new MapSqlParameterSource()
                .addValue("userId", userId)
                .addValue("channel", channel)
                .addValue("enabled", enabled)
                .addValue("target", target == null || target.isBlank() ? null : target.trim());
        var affectedRows = jdbcTemplate.update("""
                UPDATE study_notification_preferences
                SET enabled = :enabled,
                    target = :target,
                    updated_at = CURRENT_TIMESTAMP
                WHERE user_id = :userId
                  AND channel = :channel
                """, params);
        if (affectedRows == 0) {
            jdbcTemplate.update("""
                    INSERT INTO study_notification_preferences (user_id, channel, enabled, target, updated_at)
                    VALUES (:userId, :channel, :enabled, :target, CURRENT_TIMESTAMP)
                    """, params);
        }
    }

    private StudyNotificationView toView(ResultSet rs) throws SQLException {
        return new StudyNotificationView(
                rs.getObject("id", UUID.class),
                rs.getObject("task_id", UUID.class),
                rs.getObject("notification_date", LocalDate.class),
                rs.getString("channel"),
                rs.getString("title"),
                rs.getString("content"),
                rs.getTimestamp("read_at") != null,
                rs.getTimestamp("created_at").toInstant()
        );
    }

    private boolean occursOn(DueTask task, LocalDate date) {
        return switch (task.recurrenceRule()) {
            case "DAILY" -> true;
            case "WEEKLY" -> ChronoUnit.DAYS.between(task.taskDate(), date) % 7 == 0;
            case "MONTHLY" -> date.getDayOfMonth() == Math.min(task.taskDate().getDayOfMonth(), date.lengthOfMonth());
            default -> task.taskDate().isEqual(date);
        };
    }

    private List<String> enabledChannels(UUID userId) {
        ensureDefaultPreferences(userId);
        var channels = jdbcTemplate.query("""
                SELECT channel
                FROM study_notification_preferences
                WHERE user_id = :userId
                  AND enabled = TRUE
                """, new MapSqlParameterSource("userId", userId), (rs, rowNum) -> rs.getString("channel"));
        return channels.isEmpty() ? List.of("IN_APP") : channels;
    }

    private void ensureDefaultPreferences(UUID userId) {
        for (String channel : List.of("IN_APP", "BROWSER", "EMAIL")) {
            var params = new MapSqlParameterSource()
                    .addValue("userId", userId)
                    .addValue("channel", channel)
                    .addValue("enabled", "IN_APP".equals(channel));
            var existingCount = jdbcTemplate.queryForObject("""
                    SELECT COUNT(*)
                    FROM study_notification_preferences
                    WHERE user_id = :userId
                      AND channel = :channel
                    """, params, Integer.class);
            if (existingCount == null || existingCount == 0) {
                jdbcTemplate.update("""
                        INSERT INTO study_notification_preferences (user_id, channel, enabled, target, updated_at)
                        VALUES (:userId, :channel, :enabled, null, CURRENT_TIMESTAMP)
                        """, params);
            }
        }
    }

    private record DueTask(UUID id, UUID userId, String title, LocalDate taskDate, String recurrenceRule, String status) {
    }
}
