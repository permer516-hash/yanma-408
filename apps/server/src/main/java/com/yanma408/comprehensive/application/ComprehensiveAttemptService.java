package com.yanma408.comprehensive.application;

import com.yanma408.question.application.query.QuestionQueryService;
import com.yanma408.shared.exception.ResourceNotFoundException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class ComprehensiveAttemptService {
    private final NamedParameterJdbcTemplate jdbcTemplate;
    private final QuestionQueryService questionQueryService;
    private final ComprehensiveQuestionService comprehensiveQuestionService;

    public ComprehensiveAttemptService(
            NamedParameterJdbcTemplate jdbcTemplate,
            QuestionQueryService questionQueryService,
            ComprehensiveQuestionService comprehensiveQuestionService
    ) {
        this.jdbcTemplate = jdbcTemplate;
        this.questionQueryService = questionQueryService;
        this.comprehensiveQuestionService = comprehensiveQuestionService;
    }

    public ComprehensiveAttemptView findLatest(UUID userId, UUID questionId) {
        return jdbcTemplate.query("""
                SELECT id, question_id, mode, status, elapsed_seconds, submitted_at, finalized_at
                FROM comprehensive_attempts
                WHERE user_id = :userId AND question_id = :questionId
                ORDER BY updated_at DESC
                LIMIT 1
                """, new MapSqlParameterSource().addValue("userId", userId).addValue("questionId", questionId),
                (rs, rowNum) -> toView(rs.getObject("id", UUID.class), rs.getObject("question_id", UUID.class), rs.getString("mode"),
                        rs.getString("status"), rs.getInt("elapsed_seconds"), timestamp(rs, "submitted_at"), timestamp(rs, "finalized_at")))
                .stream().findFirst().orElse(null);
    }

    public List<ComprehensiveGradingQueueItemView> findPendingForReviewer(UUID reviewerId, boolean admin) {
        var queue = jdbcTemplate.query("""
                SELECT a.id, a.user_id, u.username, u.display_name, a.question_id, a.mode, a.status,
                       a.elapsed_seconds, a.submitted_at, a.finalized_at
                FROM comprehensive_attempts a
                JOIN app_users u ON u.id = a.user_id
                WHERE a.status IN ('PENDING_MANUAL', 'REVIEW_REQUESTED')
                  AND (:admin = true OR EXISTS (
                      SELECT 1
                      FROM teacher_class_students scoped
                      JOIN teacher_classes tc ON tc.id = scoped.class_id
                      WHERE scoped.student_id = a.user_id
                        AND tc.teacher_id = :reviewerId
                        AND tc.status <> 'ARCHIVED'
                  ))
                ORDER BY a.submitted_at ASC NULLS LAST, a.updated_at ASC
                """, new MapSqlParameterSource().addValue("admin", admin).addValue("reviewerId", reviewerId), (rs, rowNum) -> {
            var attemptId = rs.getObject("id", UUID.class);
            var questionId = rs.getObject("question_id", UUID.class);
            var question = questionQueryService.findDetail(questionId)
                    .orElseThrow(() -> new ResourceNotFoundException("Question not found: " + questionId));
            return new ComprehensiveGradingQueueItemView(
                    attemptId,
                    rs.getObject("user_id", UUID.class),
                    rs.getString("username"),
                    rs.getString("display_name"),
                    timestamp(rs, "submitted_at"),
                    toView(attemptId, questionId, rs.getString("mode"), rs.getString("status"), rs.getInt("elapsed_seconds"), timestamp(rs, "submitted_at"), timestamp(rs, "finalized_at")),
                    question
            );
        });
        return queue;
    }

    @Transactional
    public ComprehensiveAttemptView saveDraft(UUID userId, UUID questionId, String mode, int elapsedSeconds, List<ResponseCommand> responses) {
        validateQuestion(questionId);
        var normalizedMode = normalizeMode(mode);
        var allowedPartIds = comprehensiveQuestionService.findParts(questionId).stream()
                .collect(Collectors.toMap(part -> part.id(), part -> part));
        validateResponses(responses, allowedPartIds);
        var attemptId = findOpenAttempt(userId, questionId).orElseGet(() -> createAttempt(userId, questionId, normalizedMode));
        var now = Timestamp.from(Instant.now());
        jdbcTemplate.update("""
                UPDATE comprehensive_attempts
                SET mode = :mode, elapsed_seconds = :elapsedSeconds, updated_at = :updatedAt
                WHERE id = :id
                """, new MapSqlParameterSource().addValue("id", attemptId).addValue("mode", normalizedMode)
                .addValue("elapsedSeconds", Math.max(0, elapsedSeconds)).addValue("updatedAt", now));
        for (var response : responses) {
            var responseParams = new MapSqlParameterSource()
                    .addValue("attemptId", attemptId).addValue("partId", response.partId())
                    .addValue("content", response.content() == null ? "" : response.content().trim())
                    .addValue("attachmentUrls", String.join("\n", response.attachmentUrls()))
                    .addValue("updatedAt", now);
            var updated = jdbcTemplate.update("""
                    UPDATE comprehensive_part_responses
                    SET content = :content, attachment_urls = :attachmentUrls, updated_at = :updatedAt
                    WHERE attempt_id = :attemptId AND part_id = :partId
                    """, responseParams);
            if (updated == 0) {
                responseParams.addValue("id", UUID.randomUUID());
                jdbcTemplate.update("""
                        INSERT INTO comprehensive_part_responses (id, attempt_id, part_id, content, attachment_urls, updated_at)
                        VALUES (:id, :attemptId, :partId, :content, :attachmentUrls, :updatedAt)
                        """, responseParams);
            }
        }
        return requireAttempt(userId, attemptId);
    }

    @Transactional
    public ComprehensiveAttemptView submit(UUID userId, UUID questionId, String mode, int elapsedSeconds, List<ResponseCommand> responses) {
        var draft = saveDraft(userId, questionId, mode, elapsedSeconds, responses);
        var now = Timestamp.from(Instant.now());
        jdbcTemplate.update("""
                UPDATE comprehensive_attempts
                SET status = 'PENDING_MANUAL', submitted_at = :submittedAt, updated_at = :updatedAt
                WHERE id = :id
                """, new MapSqlParameterSource().addValue("id", draft.id()).addValue("submittedAt", now).addValue("updatedAt", now));
        return requireAttempt(userId, draft.id());
    }

    @Transactional
    public void requestReview(UUID userId, UUID attemptId, String message) {
        var attempt = requireAttempt(userId, attemptId);
        if (!"AI_SCORED".equals(attempt.status()) && !"PENDING_MANUAL".equals(attempt.status())) {
            throw new IllegalArgumentException("当前作答不能申请复核");
        }
        if (message == null || message.isBlank()) {
            throw new IllegalArgumentException("请说明需要复核的原因");
        }
        var now = Timestamp.from(Instant.now());
        jdbcTemplate.update("""
                INSERT INTO comprehensive_review_requests (id, attempt_id, student_message, status, created_at)
                VALUES (:id, :attemptId, :message, 'PENDING', :createdAt)
                """, new MapSqlParameterSource().addValue("id", UUID.randomUUID()).addValue("attemptId", attemptId)
                .addValue("message", message.trim()).addValue("createdAt", now));
        jdbcTemplate.update("UPDATE comprehensive_attempts SET status = 'REVIEW_REQUESTED', updated_at = :updatedAt WHERE id = :id",
                new MapSqlParameterSource().addValue("id", attemptId).addValue("updatedAt", now));
    }

    @Transactional
    public ComprehensiveAttemptView gradeManually(UUID reviewerId, boolean admin, UUID attemptId, List<ManualGradeCommand> grades, String note) {
        var attempt = findAttempt(attemptId);
        assertReviewerScope(reviewerId, admin, attempt.userId());
        var parts = comprehensiveQuestionService.findParts(attempt.questionId()).stream()
                .collect(Collectors.toMap(part -> part.id(), part -> part));
        if (grades == null || grades.isEmpty()) {
            throw new IllegalArgumentException("至少需要一项人工评分");
        }
        var now = Timestamp.from(Instant.now());
        for (var grade : grades) {
            var part = parts.get(grade.partId());
            if (part == null) {
                throw new IllegalArgumentException("评分小问不属于该综合题");
            }
            if (grade.score() == null || grade.score().compareTo(BigDecimal.ZERO) < 0 || grade.score().compareTo(part.score()) > 0) {
                throw new IllegalArgumentException("人工评分必须在 0 到小问分值之间");
            }
            jdbcTemplate.update("""
                    INSERT INTO comprehensive_part_grades (id, attempt_id, part_id, grader_type, score, feedback, created_at)
                    VALUES (:id, :attemptId, :partId, 'MANUAL', :score, :feedback, :createdAt)
                    """, new MapSqlParameterSource().addValue("id", UUID.randomUUID()).addValue("attemptId", attemptId)
                    .addValue("partId", grade.partId()).addValue("score", grade.score())
                    .addValue("feedback", grade.feedback() == null ? "" : grade.feedback().trim()).addValue("createdAt", now));
        }
        jdbcTemplate.update("""
                UPDATE comprehensive_attempts
                SET status = 'FINALIZED', finalized_at = :finalizedAt, updated_at = :updatedAt
                WHERE id = :id
                """, new MapSqlParameterSource().addValue("id", attemptId).addValue("finalizedAt", now).addValue("updatedAt", now));
        if (note != null && !note.isBlank()) {
            jdbcTemplate.update("""
                    UPDATE comprehensive_review_requests
                    SET status = 'RESOLVED', reviewer_id = :reviewerId, reviewer_note = :note, resolved_at = :resolvedAt
                    WHERE attempt_id = :attemptId AND status = 'PENDING'
                    """, new MapSqlParameterSource().addValue("reviewerId", reviewerId).addValue("note", note.trim())
                    .addValue("resolvedAt", now).addValue("attemptId", attemptId));
        }
        return requireAttempt(attempt.userId(), attemptId);
    }

    private void validateQuestion(UUID questionId) {
        var detail = questionQueryService.findPublishedDetail(questionId)
                .orElseThrow(() -> new ResourceNotFoundException("Question not found: " + questionId));
        if (!"COMPREHENSIVE".equals(detail.type())) {
            throw new IllegalArgumentException("该题不是综合题");
        }
    }

    private void validateResponses(List<ResponseCommand> responses, Map<UUID, ?> allowedPartIds) {
        if (responses == null || responses.isEmpty()) {
            throw new IllegalArgumentException("至少需要填写一个小问答案");
        }
        for (var response : responses) {
            if (response.partId() == null || !allowedPartIds.containsKey(response.partId())) {
                throw new IllegalArgumentException("作答小问不属于该综合题");
            }
            if ((response.content() == null || response.content().isBlank()) && (response.attachmentUrls() == null || response.attachmentUrls().isEmpty())) {
                throw new IllegalArgumentException("小问答案不能为空");
            }
        }
    }

    private UUID createAttempt(UUID userId, UUID questionId, String mode) {
        var id = UUID.randomUUID();
        var now = Timestamp.from(Instant.now());
        jdbcTemplate.update("""
                INSERT INTO comprehensive_attempts (id, user_id, question_id, mode, status, created_at, updated_at)
                VALUES (:id, :userId, :questionId, :mode, 'DRAFT', :createdAt, :updatedAt)
                """, new MapSqlParameterSource().addValue("id", id).addValue("userId", userId).addValue("questionId", questionId)
                .addValue("mode", mode).addValue("createdAt", now).addValue("updatedAt", now));
        return id;
    }

    private java.util.Optional<UUID> findOpenAttempt(UUID userId, UUID questionId) {
        return jdbcTemplate.query("""
                SELECT id FROM comprehensive_attempts
                WHERE user_id = :userId AND question_id = :questionId AND status = 'DRAFT'
                ORDER BY updated_at DESC LIMIT 1
                """, new MapSqlParameterSource().addValue("userId", userId).addValue("questionId", questionId),
                (rs, rowNum) -> rs.getObject("id", UUID.class)).stream().findFirst();
    }

    private ComprehensiveAttemptView requireAttempt(UUID userId, UUID attemptId) {
        var found = jdbcTemplate.query("""
                SELECT id, question_id, mode, status, elapsed_seconds, submitted_at, finalized_at
                FROM comprehensive_attempts
                WHERE id = :id AND user_id = :userId
                """, new MapSqlParameterSource().addValue("id", attemptId).addValue("userId", userId),
                (rs, rowNum) -> toView(rs.getObject("id", UUID.class), rs.getObject("question_id", UUID.class), rs.getString("mode"),
                        rs.getString("status"), rs.getInt("elapsed_seconds"), timestamp(rs, "submitted_at"), timestamp(rs, "finalized_at")));
        return found.stream().findFirst().orElseThrow(() -> new ResourceNotFoundException("Comprehensive attempt not found: " + attemptId));
    }

    private AttemptOwner findAttempt(UUID attemptId) {
        return jdbcTemplate.query("SELECT user_id, question_id FROM comprehensive_attempts WHERE id = :id", new MapSqlParameterSource("id", attemptId),
                (rs, rowNum) -> new AttemptOwner(rs.getObject("user_id", UUID.class), rs.getObject("question_id", UUID.class)))
                .stream().findFirst().orElseThrow(() -> new ResourceNotFoundException("Comprehensive attempt not found: " + attemptId));
    }

    private ComprehensiveAttemptView toView(UUID id, UUID questionId, String mode, String status, int elapsedSeconds, Instant submittedAt, Instant finalizedAt) {
        var responses = jdbcTemplate.query("""
                SELECT r.part_id, r.content, r.attachment_urls,
                       (
                           SELECT g.score
                           FROM comprehensive_part_grades g
                           WHERE g.attempt_id = r.attempt_id AND g.part_id = r.part_id
                           ORDER BY g.created_at DESC
                           LIMIT 1
                       ) AS latest_score,
                       (
                           SELECT g.feedback
                           FROM comprehensive_part_grades g
                           WHERE g.attempt_id = r.attempt_id AND g.part_id = r.part_id
                           ORDER BY g.created_at DESC
                           LIMIT 1
                       ) AS latest_feedback,
                       (
                           SELECT g.grader_type
                           FROM comprehensive_part_grades g
                           WHERE g.attempt_id = r.attempt_id AND g.part_id = r.part_id
                           ORDER BY g.created_at DESC
                           LIMIT 1
                       ) AS latest_grader_type
                FROM comprehensive_part_responses r
                WHERE r.attempt_id = :attemptId
                ORDER BY r.updated_at
                """, new MapSqlParameterSource("attemptId", id), (rs, rowNum) -> new ComprehensiveAttemptView.PartResponseView(
                rs.getObject("part_id", UUID.class),
                rs.getString("content"),
                splitUrls(rs.getString("attachment_urls")),
                rs.getBigDecimal("latest_score"),
                rs.getString("latest_feedback"),
                rs.getString("latest_grader_type")
        ));
        return new ComprehensiveAttemptView(id, questionId, mode, status, elapsedSeconds, submittedAt, finalizedAt, responses);
    }

    private void assertReviewerScope(UUID reviewerId, boolean admin, UUID studentId) {
        if (admin) {
            return;
        }
        var count = jdbcTemplate.queryForObject("""
                SELECT COUNT(*)
                FROM teacher_class_students scoped
                JOIN teacher_classes tc ON tc.id = scoped.class_id
                WHERE scoped.student_id = :studentId AND tc.teacher_id = :teacherId AND tc.status <> 'ARCHIVED'
                """, new MapSqlParameterSource().addValue("studentId", studentId).addValue("teacherId", reviewerId), Integer.class);
        if (count == null || count == 0) {
            throw new ResourceNotFoundException("Student not found in teacher scope: " + studentId);
        }
    }

    private String normalizeMode(String mode) {
        if (mode == null || mode.isBlank() || "DAILY_PRACTICE".equals(mode)) {
            return "DAILY_PRACTICE";
        }
        if ("MOCK_EXAM".equals(mode)) {
            return mode;
        }
        throw new IllegalArgumentException("不支持的作答场景");
    }

    private Instant timestamp(java.sql.ResultSet rs, String field) throws java.sql.SQLException {
        var timestamp = rs.getTimestamp(field);
        return timestamp == null ? null : timestamp.toInstant();
    }

    private List<String> splitUrls(String value) {
        if (value == null || value.isBlank()) {
            return List.of();
        }
        return List.of(value.split("\\n")).stream().filter(item -> !item.isBlank()).toList();
    }

    public record ResponseCommand(UUID partId, String content, List<String> attachmentUrls) {
    }

    public record ManualGradeCommand(UUID partId, BigDecimal score, String feedback) {
    }

    private record AttemptOwner(UUID userId, UUID questionId) {
    }
}
