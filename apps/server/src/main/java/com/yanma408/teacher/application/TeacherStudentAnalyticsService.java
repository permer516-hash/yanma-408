package com.yanma408.teacher.application;

import com.yanma408.mistake.application.query.MistakeFilter;
import com.yanma408.mistake.application.query.MistakeQueryService;
import com.yanma408.shared.exception.ResourceNotFoundException;
import com.yanma408.study.application.query.StudyDashboardQueryService;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Service
public class TeacherStudentAnalyticsService {
    private static final int DRILLDOWN_LIMIT = 20;

    private final NamedParameterJdbcTemplate jdbcTemplate;
    private final StudyDashboardQueryService studyDashboardQueryService;
    private final MistakeQueryService mistakeQueryService;

    public TeacherStudentAnalyticsService(
            NamedParameterJdbcTemplate jdbcTemplate,
            StudyDashboardQueryService studyDashboardQueryService,
            MistakeQueryService mistakeQueryService
    ) {
        this.jdbcTemplate = jdbcTemplate;
        this.studyDashboardQueryService = studyDashboardQueryService;
        this.mistakeQueryService = mistakeQueryService;
    }

    public List<StudentLearningSummary> findStudents(UUID teacherId, boolean admin, UUID classId, String keyword) {
        var sql = new StringBuilder("""
                SELECT u.id,
                       u.username,
                       u.display_name,
                       u.created_at,
                       COUNT(DISTINCT pa.id) AS attempt_count,
                       COUNT(DISTINCT CASE WHEN pa.correct = true THEN pa.id END) AS correct_count,
                       COUNT(DISTINCT m.id) AS mistake_count,
                       COUNT(DISTINCT CASE WHEN m.mastered = false THEN m.id END) AS pending_mistake_count,
                       COUNT(DISTINCT CASE WHEN m.mastered = true THEN m.id END) AS mastered_mistake_count,
                       COUNT(DISTINCT ea.id) AS exam_attempt_count,
                       COALESCE(latest_exam.accuracy_percent, 0) AS latest_exam_accuracy_percent,
                       GREATEST(
                           COALESCE(MAX(pa.submitted_at), TIMESTAMP '1970-01-01 00:00:00'),
                           COALESCE(MAX(m.updated_at), TIMESTAMP '1970-01-01 00:00:00'),
                           COALESCE(MAX(ea.submitted_at), TIMESTAMP '1970-01-01 00:00:00'),
                           u.created_at
                       ) AS latest_activity_at
                FROM app_users u
                JOIN app_user_roles ur ON ur.user_id = u.id AND ur.role = 'STUDENT'
                LEFT JOIN practice_attempts pa ON pa.user_id = u.id
                LEFT JOIN mistakes m ON m.user_id = u.id
                LEFT JOIN exam_attempts ea ON ea.user_id = u.id AND ea.status = 'SUBMITTED'
                LEFT JOIN (
                    SELECT ranked.user_id,
                           ranked.accuracy_percent
                    FROM (
                        SELECT user_id,
                               CASE WHEN question_count = 0
                                   THEN 0
                                   ELSE CAST(ROUND(correct_count * 100.0 / question_count) AS INTEGER)
                               END AS accuracy_percent,
                               ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY submitted_at DESC) AS rn
                        FROM exam_attempts
                        WHERE status = 'SUBMITTED'
                    ) ranked
                    WHERE ranked.rn = 1
                ) latest_exam ON latest_exam.user_id = u.id
                WHERE 1 = 1
                """);
        var params = new MapSqlParameterSource();
        if (classId != null) {
            assertClassAccess(teacherId, admin, classId);
            sql.append("""
                     AND EXISTS (
                         SELECT 1
                         FROM teacher_class_students scoped
                         WHERE scoped.class_id = :classId
                           AND scoped.student_id = u.id
                     )
                    """);
            params.addValue("classId", classId);
        } else if (!admin) {
            sql.append("""
                     AND EXISTS (
                         SELECT 1
                         FROM teacher_class_students scoped
                         JOIN teacher_classes tc ON tc.id = scoped.class_id
                         WHERE scoped.student_id = u.id
                           AND tc.teacher_id = :teacherId
                           AND tc.status <> 'ARCHIVED'
                     )
                    """);
            params.addValue("teacherId", teacherId);
        }
        if (keyword != null && !keyword.isBlank()) {
            sql.append(" AND (LOWER(u.username) LIKE :keyword OR LOWER(u.display_name) LIKE :keyword)\n");
            params.addValue("keyword", "%" + keyword.trim().toLowerCase() + "%");
        }
        sql.append("""
                GROUP BY u.id, u.username, u.display_name, u.created_at, latest_exam.accuracy_percent
                ORDER BY latest_activity_at DESC, u.created_at DESC
                """);
        return jdbcTemplate.query(sql.toString(), params, (rs, rowNum) -> toSummary(rs));
    }

    public StudentLearningDetail findStudentDetail(UUID teacherId, boolean admin, UUID classId, UUID studentId) {
        assertStudentAccess(teacherId, admin, classId, studentId);
        var summary = findStudentSummary(studentId);
        var mistakes = mistakeQueryService.findMine(studentId, new MistakeFilter(null, null, "PRIORITY"));
        var dashboard = studyDashboardQueryService.findDashboard(studentId);
        return new StudentLearningDetail(
                summary,
                dashboard,
                mistakes.stream().limit(DRILLDOWN_LIMIT).toList(),
                findPracticeAttempts(studentId),
                findExamAttempts(studentId),
                dashboard.weakKnowledgePoints()
        );
    }

    public String exportStudentsCsv(UUID teacherId, boolean admin, UUID classId, String keyword) {
        var students = findStudents(teacherId, admin, classId, keyword);
        var builder = new StringBuilder();
        builder.append("学生ID,用户名,昵称,练习提交数,正确数,练习正确率,错题数,待掌握错题,已掌握错题,套卷次数,最近套卷正确率,最近活跃时间\n");
        for (StudentLearningSummary student : students) {
            appendCsvRow(builder,
                    student.id().toString(),
                    student.username(),
                    student.displayName(),
                    String.valueOf(student.attemptCount()),
                    String.valueOf(student.correctCount()),
                    student.accuracyPercent() + "%",
                    String.valueOf(student.mistakeCount()),
                    String.valueOf(student.pendingMistakeCount()),
                    String.valueOf(student.masteredMistakeCount()),
                    String.valueOf(student.examAttemptCount()),
                    student.latestExamAccuracyPercent() + "%",
                    student.latestActivityAt() == null ? "" : student.latestActivityAt().toString()
            );
        }
        return builder.toString();
    }

    private List<StudentLearningDetail.PracticeAttemptItem> findPracticeAttempts(UUID studentId) {
        var sql = """
                SELECT pa.id,
                       pa.question_id,
                       s.code AS subject_code,
                       s.name AS subject_name,
                       c.name AS chapter_name,
                       q.stem,
                       pa.submitted_answer,
                       pa.correct_answer,
                       pa.correct,
                       pa.elapsed_seconds,
                       pa.submitted_at
                FROM practice_attempts pa
                JOIN questions q ON q.id = pa.question_id
                JOIN subjects s ON s.id = q.subject_id
                JOIN chapters c ON c.id = q.chapter_id
                WHERE pa.user_id = :studentId
                ORDER BY pa.submitted_at DESC
                LIMIT :limit
                """;
        var params = new MapSqlParameterSource()
                .addValue("studentId", studentId)
                .addValue("limit", DRILLDOWN_LIMIT);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> new StudentLearningDetail.PracticeAttemptItem(
                rs.getObject("id", UUID.class),
                rs.getObject("question_id", UUID.class),
                rs.getString("subject_code"),
                rs.getString("subject_name"),
                rs.getString("chapter_name"),
                rs.getString("stem"),
                rs.getString("submitted_answer"),
                rs.getString("correct_answer"),
                rs.getBoolean("correct"),
                rs.getInt("elapsed_seconds"),
                getInstant(rs, "submitted_at")
        ));
    }

    private List<StudentLearningDetail.ExamAttemptItem> findExamAttempts(UUID studentId) {
        var sql = """
                SELECT ea.id,
                       ea.exam_paper_id,
                       ep.title AS paper_title,
                       ep.paper_type,
                       ep.source_year,
                       ea.submitted_at,
                       ea.duration_seconds,
                       ea.total_score,
                       ea.scored_points,
                       ea.correct_count,
                       ea.question_count,
                       CASE WHEN ea.question_count = 0
                           THEN 0
                           ELSE CAST(ROUND(ea.correct_count * 100.0 / ea.question_count) AS INTEGER)
                       END AS accuracy_percent
                FROM exam_attempts ea
                JOIN exam_papers ep ON ep.id = ea.exam_paper_id
                WHERE ea.user_id = :studentId
                  AND ea.status = 'SUBMITTED'
                ORDER BY ea.submitted_at DESC
                LIMIT :limit
                """;
        var params = new MapSqlParameterSource()
                .addValue("studentId", studentId)
                .addValue("limit", DRILLDOWN_LIMIT);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> new StudentLearningDetail.ExamAttemptItem(
                rs.getObject("id", UUID.class),
                rs.getObject("exam_paper_id", UUID.class),
                rs.getString("paper_title"),
                rs.getString("paper_type"),
                getNullableInteger(rs, "source_year"),
                getInstant(rs, "submitted_at"),
                rs.getInt("duration_seconds"),
                rs.getBigDecimal("total_score"),
                rs.getBigDecimal("scored_points"),
                rs.getInt("correct_count"),
                rs.getInt("question_count"),
                rs.getInt("accuracy_percent")
        ));
    }

    private StudentLearningSummary findStudentSummary(UUID studentId) {
        var summaries = jdbcTemplate.query("""
                SELECT u.id,
                       u.username,
                       u.display_name,
                       u.created_at,
                       COUNT(DISTINCT pa.id) AS attempt_count,
                       COUNT(DISTINCT CASE WHEN pa.correct = true THEN pa.id END) AS correct_count,
                       COUNT(DISTINCT m.id) AS mistake_count,
                       COUNT(DISTINCT CASE WHEN m.mastered = false THEN m.id END) AS pending_mistake_count,
                       COUNT(DISTINCT CASE WHEN m.mastered = true THEN m.id END) AS mastered_mistake_count,
                       COUNT(DISTINCT ea.id) AS exam_attempt_count,
                       COALESCE(latest_exam.accuracy_percent, 0) AS latest_exam_accuracy_percent,
                       GREATEST(
                           COALESCE(MAX(pa.submitted_at), TIMESTAMP '1970-01-01 00:00:00'),
                           COALESCE(MAX(m.updated_at), TIMESTAMP '1970-01-01 00:00:00'),
                           COALESCE(MAX(ea.submitted_at), TIMESTAMP '1970-01-01 00:00:00'),
                           u.created_at
                       ) AS latest_activity_at
                FROM app_users u
                JOIN app_user_roles ur ON ur.user_id = u.id AND ur.role = 'STUDENT'
                LEFT JOIN practice_attempts pa ON pa.user_id = u.id
                LEFT JOIN mistakes m ON m.user_id = u.id
                LEFT JOIN exam_attempts ea ON ea.user_id = u.id AND ea.status = 'SUBMITTED'
                LEFT JOIN (
                    SELECT ranked.user_id,
                           ranked.accuracy_percent
                    FROM (
                        SELECT user_id,
                               CASE WHEN question_count = 0
                                   THEN 0
                                   ELSE CAST(ROUND(correct_count * 100.0 / question_count) AS INTEGER)
                               END AS accuracy_percent,
                               ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY submitted_at DESC) AS rn
                        FROM exam_attempts
                        WHERE status = 'SUBMITTED'
                    ) ranked
                    WHERE ranked.rn = 1
                ) latest_exam ON latest_exam.user_id = u.id
                WHERE u.id = :studentId
                GROUP BY u.id, u.username, u.display_name, u.created_at, latest_exam.accuracy_percent
                """, new MapSqlParameterSource("studentId", studentId), (rs, rowNum) -> toSummary(rs));
        return summaries.stream()
                .findFirst()
                .orElseThrow(() -> new ResourceNotFoundException("Student not found: " + studentId));
    }

    private void assertClassAccess(UUID teacherId, boolean admin, UUID classId) {
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

    private void assertStudentAccess(UUID teacherId, boolean admin, UUID classId, UUID studentId) {
        if (classId != null) {
            assertClassAccess(teacherId, admin, classId);
            var count = jdbcTemplate.queryForObject("""
                    SELECT COUNT(*)
                    FROM teacher_class_students
                    WHERE class_id = :classId
                      AND student_id = :studentId
                    """, new MapSqlParameterSource()
                    .addValue("classId", classId)
                    .addValue("studentId", studentId), Integer.class);
            if (count == null || count == 0) {
                throw new ResourceNotFoundException("Student not found in class: " + studentId);
            }
            return;
        }
        if (admin) {
            return;
        }
        var count = jdbcTemplate.queryForObject("""
                SELECT COUNT(*)
                FROM teacher_class_students scoped
                JOIN teacher_classes tc ON tc.id = scoped.class_id
                WHERE scoped.student_id = :studentId
                  AND tc.teacher_id = :teacherId
                  AND tc.status <> 'ARCHIVED'
                """, new MapSqlParameterSource()
                .addValue("studentId", studentId)
                .addValue("teacherId", teacherId), Integer.class);
        if (count == null || count == 0) {
            throw new ResourceNotFoundException("Student not found in teacher scope: " + studentId);
        }
    }

    private void appendCsvRow(StringBuilder builder, String... values) {
        for (int i = 0; i < values.length; i++) {
            if (i > 0) {
                builder.append(',');
            }
            builder.append(csv(values[i]));
        }
        builder.append('\n');
    }

    private String csv(String value) {
        var normalized = value == null ? "" : value;
        return "\"" + normalized.replace("\"", "\"\"") + "\"";
    }

    private StudentLearningSummary toSummary(ResultSet rs) throws SQLException {
        int attemptCount = rs.getInt("attempt_count");
        int correctCount = rs.getInt("correct_count");
        return new StudentLearningSummary(
                rs.getObject("id", UUID.class),
                rs.getString("username"),
                rs.getString("display_name"),
                getInstant(rs, "created_at"),
                attemptCount,
                correctCount,
                percentage(correctCount, attemptCount),
                rs.getInt("mistake_count"),
                rs.getInt("pending_mistake_count"),
                rs.getInt("mastered_mistake_count"),
                rs.getInt("exam_attempt_count"),
                rs.getInt("latest_exam_accuracy_percent"),
                getInstant(rs, "latest_activity_at")
        );
    }

    private Instant getInstant(ResultSet rs, String column) throws SQLException {
        Timestamp timestamp = rs.getTimestamp(column);
        return timestamp == null ? null : timestamp.toInstant();
    }

    private Integer getNullableInteger(ResultSet rs, String column) throws SQLException {
        var value = rs.getInt(column);
        return rs.wasNull() ? null : value;
    }

    private int percentage(int numerator, int denominator) {
        if (denominator == 0) {
            return 0;
        }
        return Math.round((numerator * 100.0f) / denominator);
    }
}
