package com.yanma408.study.infrastructure.persistence;

import com.yanma408.study.application.query.StudyDashboardRepository;
import com.yanma408.study.application.query.StudyDashboardView;
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
public class JdbcStudyDashboardRepository implements StudyDashboardRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;

    public JdbcStudyDashboardRepository(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public StudyDashboardView.TodayGoalView findTodayGoal(UUID userId, int targetCount) {
        var sql = """
                SELECT COUNT(*) AS completed_count
                FROM practice_attempts
                WHERE user_id = :userId
                  AND CAST(submitted_at AS DATE) = CURRENT_DATE
                """;
        var params = new MapSqlParameterSource("userId", userId);
        Integer completedCount = jdbcTemplate.queryForObject(sql, params, Integer.class);
        return new StudyDashboardView.TodayGoalView(completedCount == null ? 0 : completedCount, targetCount);
    }

    @Override
    public StudyDashboardView.ContinuousStudyView findContinuousStudy(UUID userId) {
        var sql = """
                SELECT DISTINCT CAST(submitted_at AS DATE) AS study_date
                FROM practice_attempts
                WHERE user_id = :userId
                ORDER BY study_date DESC
                """;
        var params = new MapSqlParameterSource("userId", userId);
        var studyDates = jdbcTemplate.query(sql, params, (rs, rowNum) -> rs.getObject("study_date", LocalDate.class));
        var expectedDate = LocalDate.now();
        var days = 0;
        for (LocalDate studyDate : studyDates) {
            if (studyDate.isEqual(expectedDate)) {
                days++;
                expectedDate = expectedDate.minusDays(1);
            } else if (studyDate.isBefore(expectedDate)) {
                break;
            }
        }
        return new StudyDashboardView.ContinuousStudyView(days);
    }

    @Override
    public StudyDashboardView.WeeklyAccuracyView findWeeklyAccuracy(UUID userId) {
        var sql = """
                SELECT
                    SUM(CASE WHEN submitted_at >= :currentWindowStart THEN 1 ELSE 0 END) AS current_attempts,
                    SUM(CASE WHEN submitted_at >= :currentWindowStart AND correct = true THEN 1 ELSE 0 END) AS current_correct,
                    SUM(CASE WHEN submitted_at < :currentWindowStart
                              AND submitted_at >= :previousWindowStart THEN 1 ELSE 0 END) AS previous_attempts,
                    SUM(CASE WHEN submitted_at < :currentWindowStart
                              AND submitted_at >= :previousWindowStart
                              AND correct = true THEN 1 ELSE 0 END) AS previous_correct
                FROM practice_attempts
                WHERE user_id = :userId
                  AND submitted_at >= :previousWindowStart
                """;
        var now = Instant.now();
        var currentWindowStart = Timestamp.from(now.minus(7, ChronoUnit.DAYS));
        var previousWindowStart = Timestamp.from(now.minus(14, ChronoUnit.DAYS));
        var params = new MapSqlParameterSource()
                .addValue("userId", userId)
                .addValue("currentWindowStart", currentWindowStart)
                .addValue("previousWindowStart", previousWindowStart);
        return jdbcTemplate.queryForObject(sql, params, (rs, rowNum) -> {
            int currentAttempts = rs.getInt("current_attempts");
            int currentCorrect = rs.getInt("current_correct");
            int previousAttempts = rs.getInt("previous_attempts");
            int previousCorrect = rs.getInt("previous_correct");
            int currentPercent = percentage(currentCorrect, currentAttempts);
            int previousPercent = percentage(previousCorrect, previousAttempts);
            return new StudyDashboardView.WeeklyAccuracyView(currentPercent, currentPercent - previousPercent, currentAttempts);
        });
    }

    @Override
    public List<StudyDashboardView.SubjectMasteryView> findSubjectMasteries(UUID userId) {
        var sql = """
                WITH subject_attempts AS (
                    SELECT s.id AS subject_id,
                           COUNT(pa.id) AS practiced_count,
                           SUM(CASE WHEN pa.correct = true THEN 1 ELSE 0 END) AS correct_count
                    FROM subjects s
                    LEFT JOIN questions q ON q.subject_id = s.id
                    LEFT JOIN practice_attempts pa ON pa.question_id = q.id AND pa.user_id = :userId
                    GROUP BY s.id
                ),
                subject_weak_points AS (
                    SELECT ranked.subject_id,
                           ranked.knowledge_point_name
                    FROM (
                        SELECT s.id AS subject_id,
                               kp.name AS knowledge_point_name,
                               SUM(m.wrong_count) AS wrong_count,
                               ROW_NUMBER() OVER (
                                   PARTITION BY s.id
                                   ORDER BY SUM(m.wrong_count) DESC, MAX(m.updated_at) DESC
                               ) AS rn
                        FROM mistakes m
                        JOIN questions q ON q.id = m.question_id
                        JOIN subjects s ON s.id = q.subject_id
                        JOIN question_knowledge_points qkp ON qkp.question_id = q.id
                        JOIN knowledge_points kp ON kp.id = qkp.knowledge_point_id
                        WHERE m.user_id = :userId
                        GROUP BY s.id, kp.name
                    ) ranked
                    WHERE ranked.rn = 1
                )
                SELECT s.code AS subject_code,
                       s.name AS subject_name,
                       COALESCE(sa.practiced_count, 0) AS practiced_count,
                       COALESCE(sa.correct_count, 0) AS correct_count,
                       COALESCE(swp.knowledge_point_name, '暂无错题') AS weakest_knowledge_point
                FROM subjects s
                LEFT JOIN subject_attempts sa ON sa.subject_id = s.id
                LEFT JOIN subject_weak_points swp ON swp.subject_id = s.id
                ORDER BY s.sort_order
                """;
        var params = new MapSqlParameterSource("userId", userId);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> {
            int practicedCount = rs.getInt("practiced_count");
            int correctCount = rs.getInt("correct_count");
            return new StudyDashboardView.SubjectMasteryView(
                    rs.getString("subject_code"),
                    rs.getString("subject_name"),
                    practicedCount,
                    correctCount,
                    percentage(correctCount, practicedCount),
                    rs.getString("weakest_knowledge_point")
            );
        });
    }

    @Override
    public List<StudyDashboardView.StudyTaskView> findTodayTasks(UUID userId) {
        var sql = """
                SELECT id, title, subject_code, task_type, target_count,
                       estimated_minutes, status, priority, task_date,
                       recurrence_rule, reminder_time
                FROM study_plan_tasks
                WHERE user_id = :userId
                  AND task_date = CURRENT_DATE
                  AND status <> 'DELETED'
                ORDER BY
                    CASE priority
                        WHEN 'IMPORTANT' THEN 1
                        WHEN 'REVIEW' THEN 2
                        ELSE 3
                    END,
                    created_at
                """;
        var params = new MapSqlParameterSource("userId", userId);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> new StudyDashboardView.StudyTaskView(
                rs.getObject("id", UUID.class),
                rs.getString("title"),
                rs.getString("subject_code"),
                rs.getString("task_type"),
                rs.getInt("target_count"),
                rs.getInt("estimated_minutes"),
                rs.getString("status"),
                rs.getString("priority"),
                rs.getObject("task_date", LocalDate.class),
                rs.getString("recurrence_rule"),
                rs.getObject("reminder_time", LocalTime.class)
        ));
    }

    @Override
    public List<StudyDashboardView.WeakKnowledgePointView> findWeakKnowledgePoints(UUID userId, int limit) {
        var sql = """
                SELECT kp.id,
                       kp.code,
                       kp.name,
                       s.code AS subject_code,
                       s.name AS subject_name,
                       c.name AS chapter_name,
                       COUNT(DISTINCT m.id) AS mistake_count,
                       COALESCE(SUM(m.wrong_count), 0) AS wrong_count,
                       SUM(CASE WHEN m.mastered = false THEN 1 ELSE 0 END) AS pending_mistake_count,
                       MAX(m.updated_at) AS latest_wrong_at
                FROM mistakes m
                JOIN questions q ON q.id = m.question_id
                JOIN question_knowledge_points qkp ON qkp.question_id = q.id
                JOIN knowledge_points kp ON kp.id = qkp.knowledge_point_id
                JOIN chapters c ON c.id = kp.chapter_id
                JOIN subjects s ON s.id = c.subject_id
                WHERE m.user_id = :userId
                GROUP BY kp.id, kp.code, kp.name, s.code, s.name, c.name
                ORDER BY pending_mistake_count DESC, wrong_count DESC, latest_wrong_at DESC
                LIMIT :limit
                """;
        var params = new MapSqlParameterSource()
                .addValue("userId", userId)
                .addValue("limit", limit);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> toWeakKnowledgePoint(rs));
    }

    private StudyDashboardView.WeakKnowledgePointView toWeakKnowledgePoint(ResultSet rs) throws SQLException {
        return new StudyDashboardView.WeakKnowledgePointView(
                rs.getObject("id", UUID.class),
                rs.getString("code"),
                rs.getString("name"),
                rs.getString("subject_code"),
                rs.getString("subject_name"),
                rs.getString("chapter_name"),
                rs.getInt("mistake_count"),
                rs.getInt("wrong_count"),
                rs.getInt("pending_mistake_count"),
                getInstant(rs, "latest_wrong_at")
        );
    }

    private Instant getInstant(ResultSet rs, String column) throws SQLException {
        Timestamp timestamp = rs.getTimestamp(column);
        return timestamp == null ? null : timestamp.toInstant();
    }

    private int percentage(int numerator, int denominator) {
        if (denominator == 0) {
            return 0;
        }
        return Math.round((numerator * 100.0f) / denominator);
    }
}
