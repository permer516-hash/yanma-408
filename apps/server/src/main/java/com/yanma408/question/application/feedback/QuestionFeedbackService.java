package com.yanma408.question.application.feedback;

import com.yanma408.shared.exception.ResourceNotFoundException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.Locale;
import java.util.Set;
import java.util.UUID;

@Service
public class QuestionFeedbackService {
    private static final Set<String> ISSUE_TYPES = Set.of(
            "ANSWER_INCORRECT",
            "EXPLANATION_UNCLEAR",
            "STEM_ERROR",
            "OPTION_ERROR",
            "IMAGE_DISPLAY_ERROR",
            "OTHER"
    );
    private static final Set<String> STATUSES = Set.of("PENDING", "RESOLVED", "IGNORED");
    private static final int DEFAULT_PAGE_SIZE = 30;
    private static final int MAX_PAGE_SIZE = 100;

    private final NamedParameterJdbcTemplate jdbcTemplate;

    public QuestionFeedbackService(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Transactional
    public QuestionFeedbackView submit(UUID questionId, UUID reporterUserId, String issueType, String description) {
        if (!publishedQuestionExists(questionId)) {
            throw new ResourceNotFoundException("Question not found: " + questionId);
        }
        var id = UUID.randomUUID();
        var now = LocalDateTime.now();
        jdbcTemplate.update("""
                INSERT INTO question_feedbacks (
                    id, question_id, reporter_user_id, issue_type, description,
                    status, created_at, updated_at
                )
                VALUES (
                    :id, :questionId, :reporterUserId, :issueType, :description,
                    'PENDING', :now, :now
                )
                """, new MapSqlParameterSource()
                .addValue("id", id)
                .addValue("questionId", questionId)
                .addValue("reporterUserId", reporterUserId)
                .addValue("issueType", normalizeIssueType(issueType))
                .addValue("description", requireText(description, "description"))
                .addValue("now", now));
        return find(id);
    }

    public QuestionFeedbackPage list(String status, String issueType, int page, int size) {
        var normalizedPage = Math.max(0, page);
        var normalizedSize = normalizeSize(size);
        var where = new StringBuilder(" WHERE 1 = 1\n");
        var params = new MapSqlParameterSource();
        if (status != null && !status.isBlank()) {
            where.append(" AND qf.status = :status\n");
            params.addValue("status", normalizeStatus(status));
        }
        if (issueType != null && !issueType.isBlank()) {
            where.append(" AND qf.issue_type = :issueType\n");
            params.addValue("issueType", normalizeIssueType(issueType));
        }
        var from = """
                FROM question_feedbacks qf
                JOIN questions q ON q.id = qf.question_id
                JOIN subjects s ON s.id = q.subject_id
                JOIN chapters c ON c.id = q.chapter_id
                JOIN app_users reporter ON reporter.id = qf.reporter_user_id
                LEFT JOIN app_users handler ON handler.id = qf.handled_by_user_id
                """;
        var total = jdbcTemplate.queryForObject("SELECT COUNT(*) " + from + where, params, Integer.class);
        params.addValue("limit", normalizedSize);
        params.addValue("offset", normalizedPage * normalizedSize);
        var items = jdbcTemplate.query("""
                SELECT qf.id,
                       qf.question_id,
                       q.stem AS question_stem,
                       s.code AS subject_code,
                       s.name AS subject_name,
                       c.name AS chapter_name,
                       qf.reporter_user_id,
                       reporter.display_name AS reporter_display_name,
                       qf.issue_type,
                       qf.description,
                       qf.status,
                       qf.admin_note,
                       qf.handled_by_user_id,
                       handler.display_name AS handled_by_display_name,
                       qf.handled_at,
                       qf.created_at,
                       qf.updated_at
                """ + from + where + """
                ORDER BY qf.created_at DESC
                LIMIT :limit OFFSET :offset
                """, params, (rs, rowNum) -> toView(rs));
        var totalValue = total == null ? 0 : total;
        var totalPages = totalValue == 0 ? 0 : (int) Math.ceil((double) totalValue / normalizedSize);
        return new QuestionFeedbackPage(items, normalizedPage, normalizedSize, totalValue, totalPages);
    }

    @Transactional
    public QuestionFeedbackView updateStatus(UUID feedbackId, UUID handlerUserId, String status, String adminNote) {
        var normalizedStatus = normalizeStatus(status);
        var now = LocalDateTime.now();
        var updated = jdbcTemplate.update("""
                UPDATE question_feedbacks
                SET status = :status,
                    admin_note = :adminNote,
                    handled_by_user_id = :handlerUserId,
                    handled_at = CASE WHEN :status = 'PENDING' THEN null ELSE :now END,
                    updated_at = :now
                WHERE id = :id
                """, new MapSqlParameterSource()
                .addValue("id", feedbackId)
                .addValue("status", normalizedStatus)
                .addValue("adminNote", blankToNull(adminNote))
                .addValue("handlerUserId", handlerUserId)
                .addValue("now", now));
        if (updated == 0) {
            throw new ResourceNotFoundException("Question feedback not found: " + feedbackId);
        }
        return find(feedbackId);
    }

    private QuestionFeedbackView find(UUID id) {
        return listOne(id);
    }

    private QuestionFeedbackView listOne(UUID id) {
        var sql = """
                SELECT qf.id,
                       qf.question_id,
                       q.stem AS question_stem,
                       s.code AS subject_code,
                       s.name AS subject_name,
                       c.name AS chapter_name,
                       qf.reporter_user_id,
                       reporter.display_name AS reporter_display_name,
                       qf.issue_type,
                       qf.description,
                       qf.status,
                       qf.admin_note,
                       qf.handled_by_user_id,
                       handler.display_name AS handled_by_display_name,
                       qf.handled_at,
                       qf.created_at,
                       qf.updated_at
                FROM question_feedbacks qf
                JOIN questions q ON q.id = qf.question_id
                JOIN subjects s ON s.id = q.subject_id
                JOIN chapters c ON c.id = q.chapter_id
                JOIN app_users reporter ON reporter.id = qf.reporter_user_id
                LEFT JOIN app_users handler ON handler.id = qf.handled_by_user_id
                WHERE qf.id = :id
                """;
        return jdbcTemplate.query(sql, new MapSqlParameterSource("id", id), (rs, rowNum) -> toView(rs))
                .stream()
                .findFirst()
                .orElseThrow(() -> new ResourceNotFoundException("Question feedback not found: " + id));
    }

    private boolean publishedQuestionExists(UUID questionId) {
        var count = jdbcTemplate.queryForObject("""
                SELECT COUNT(*)
                FROM questions
                WHERE id = :questionId
                  AND status = 'PUBLISHED'
                  AND review_status = 'APPROVED'
                """, new MapSqlParameterSource("questionId", questionId), Integer.class);
        return count != null && count > 0;
    }

    private QuestionFeedbackView toView(ResultSet rs) throws SQLException {
        return new QuestionFeedbackView(
                rs.getObject("id", UUID.class),
                rs.getObject("question_id", UUID.class),
                rs.getString("question_stem"),
                rs.getString("subject_code"),
                rs.getString("subject_name"),
                rs.getString("chapter_name"),
                rs.getObject("reporter_user_id", UUID.class),
                rs.getString("reporter_display_name"),
                rs.getString("issue_type"),
                rs.getString("description"),
                rs.getString("status"),
                rs.getString("admin_note"),
                rs.getObject("handled_by_user_id", UUID.class),
                rs.getString("handled_by_display_name"),
                timestamp(rs, "handled_at"),
                timestamp(rs, "created_at"),
                timestamp(rs, "updated_at")
        );
    }

    private LocalDateTime timestamp(ResultSet rs, String column) throws SQLException {
        var value = rs.getTimestamp(column);
        return value == null ? null : value.toLocalDateTime();
    }

    private String normalizeIssueType(String value) {
        var normalized = requireText(value, "issueType").toUpperCase(Locale.ROOT);
        if (!ISSUE_TYPES.contains(normalized)) {
            throw new IllegalArgumentException("Unsupported issueType: " + value);
        }
        return normalized;
    }

    private String normalizeStatus(String value) {
        var normalized = requireText(value, "status").toUpperCase(Locale.ROOT);
        if (!STATUSES.contains(normalized)) {
            throw new IllegalArgumentException("Unsupported feedback status: " + value);
        }
        return normalized;
    }

    private int normalizeSize(int size) {
        if (size <= 0) {
            return DEFAULT_PAGE_SIZE;
        }
        return Math.min(size, MAX_PAGE_SIZE);
    }

    private String requireText(String value, String fieldName) {
        if (value == null || value.isBlank()) {
            throw new IllegalArgumentException(fieldName + " is required");
        }
        return value.trim();
    }

    private String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }
}
