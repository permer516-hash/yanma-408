package com.yanma408.exam.infrastructure.persistence;

import com.yanma408.exam.application.attempt.ExamAttemptComparison;
import com.yanma408.exam.application.attempt.ExamAttemptReport;
import com.yanma408.exam.application.attempt.ExamAttemptRepository;
import com.yanma408.exam.application.attempt.ExamAttemptSummary;
import com.yanma408.exam.application.attempt.ExamAttemptView;
import com.yanma408.exam.application.attempt.ExamReportOverview;
import com.yanma408.exam.application.attempt.SubmitExamAttemptCommand;
import com.yanma408.exam.application.query.ExamPaperQueryRepository;
import com.yanma408.shared.exception.ResourceNotFoundException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public class JdbcExamAttemptRepository implements ExamAttemptRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;
    private final ExamPaperQueryRepository examPaperQueryRepository;

    public JdbcExamAttemptRepository(
            NamedParameterJdbcTemplate jdbcTemplate,
            ExamPaperQueryRepository examPaperQueryRepository
    ) {
        this.jdbcTemplate = jdbcTemplate;
        this.examPaperQueryRepository = examPaperQueryRepository;
    }

    @Override
    public ExamAttemptView start(UUID userId, UUID examPaperId) {
        var paper = examPaperQueryRepository.findPublishedDetail(examPaperId)
                .orElseThrow(() -> new ResourceNotFoundException("Exam paper not found: " + examPaperId));
        var attemptId = UUID.randomUUID();
        var now = Instant.now();
        var sql = """
                INSERT INTO exam_attempts (
                    id, user_id, exam_paper_id, status, started_at, submitted_at,
                    duration_seconds, total_score, scored_points, correct_count,
                    question_count, created_at, updated_at
                )
                VALUES (
                    :id, :userId, :examPaperId, 'STARTED', :startedAt, null,
                    null, :totalScore, 0, 0, :questionCount, :createdAt, :updatedAt
                )
                """;
        var params = new MapSqlParameterSource()
                .addValue("id", attemptId)
                .addValue("userId", userId)
                .addValue("examPaperId", examPaperId)
                .addValue("startedAt", Timestamp.from(now))
                .addValue("totalScore", BigDecimal.valueOf(paper.totalScore()))
                .addValue("questionCount", paper.questionCount())
                .addValue("createdAt", Timestamp.from(now))
                .addValue("updatedAt", Timestamp.from(now));
        jdbcTemplate.update(sql, params);
        return new ExamAttemptView(
                attemptId,
                examPaperId,
                "STARTED",
                now,
                now.plusSeconds((long) paper.durationMinutes() * 60),
                paper
        );
    }

    @Override
    public ExamAttemptReport submit(SubmitExamAttemptCommand command) {
        var attempt = findStartedAttempt(command.userId(), command.attemptId())
                .orElseThrow(() -> new ResourceNotFoundException("Exam attempt not found: " + command.attemptId()));
        var questions = findPaperQuestions(attempt.examPaperId());
        if (questions.isEmpty()) {
            throw new ResourceNotFoundException("Exam attempt has no questions: " + command.attemptId());
        }

        BigDecimal scoredPoints = BigDecimal.ZERO;
        int correctCount = 0;
        var now = Instant.now();
        for (PaperQuestion question : questions) {
            var submittedAnswer = command.answers()
                    .getOrDefault(question.questionId(), "")
                    .trim()
                    .toUpperCase();
            var correct = !submittedAnswer.isBlank() && submittedAnswer.equals(question.correctAnswer().trim().toUpperCase());
            var earnedScore = correct ? question.score() : BigDecimal.ZERO;
            if (correct) {
                correctCount++;
            }
            scoredPoints = scoredPoints.add(earnedScore);
            insertAnswer(command.attemptId(), question, submittedAnswer, correct, earnedScore, now);
        }

        var updateSql = """
                UPDATE exam_attempts
                SET status = 'SUBMITTED',
                    submitted_at = :submittedAt,
                    duration_seconds = :durationSeconds,
                    scored_points = :scoredPoints,
                    correct_count = :correctCount,
                    question_count = :questionCount,
                    updated_at = :updatedAt
                WHERE id = :attemptId
                  AND user_id = :userId
                  AND status = 'STARTED'
                """;
        var updateParams = new MapSqlParameterSource()
                .addValue("submittedAt", Timestamp.from(now))
                .addValue("durationSeconds", command.durationSeconds())
                .addValue("scoredPoints", scoredPoints)
                .addValue("correctCount", correctCount)
                .addValue("questionCount", questions.size())
                .addValue("updatedAt", Timestamp.from(now))
                .addValue("attemptId", command.attemptId())
                .addValue("userId", command.userId());
        int affectedRows = jdbcTemplate.update(updateSql, updateParams);
        if (affectedRows == 0) {
            throw new ResourceNotFoundException("Exam attempt not found: " + command.attemptId());
        }
        return findReport(command.userId(), command.attemptId())
                .orElseThrow(() -> new ResourceNotFoundException("Exam attempt report not found: " + command.attemptId()));
    }

    @Override
    public Optional<ExamAttemptReport> findReport(UUID userId, UUID attemptId) {
        var sql = """
                SELECT ea.id, ea.exam_paper_id, ep.title, ea.status, ea.started_at,
                       ea.submitted_at, ea.duration_seconds, ea.total_score,
                       ea.scored_points, ea.correct_count, ea.question_count
                FROM exam_attempts ea
                JOIN exam_papers ep ON ep.id = ea.exam_paper_id
                WHERE ea.id = :attemptId
                  AND ea.user_id = :userId
                  AND ea.status = 'SUBMITTED'
                """;
        var params = new MapSqlParameterSource()
                .addValue("attemptId", attemptId)
                .addValue("userId", userId);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> toReport(rs))
                .stream()
                .findFirst();
    }

    @Override
    public List<ExamAttemptSummary> findSubmittedAttempts(UUID userId, UUID examPaperId) {
        var sql = new StringBuilder("""
                SELECT ea.id, ea.exam_paper_id, ep.title, ea.submitted_at,
                       ea.duration_seconds, ea.total_score, ea.scored_points,
                       ea.correct_count, ea.question_count
                FROM exam_attempts ea
                JOIN exam_papers ep ON ep.id = ea.exam_paper_id
                WHERE ea.user_id = :userId
                  AND ea.status = 'SUBMITTED'
                """);
        var params = new MapSqlParameterSource("userId", userId);
        if (examPaperId != null) {
            sql.append(" AND ea.exam_paper_id = :examPaperId\n");
            params.addValue("examPaperId", examPaperId);
        }
        sql.append("ORDER BY ea.submitted_at DESC");
        return jdbcTemplate.query(sql.toString(), params, (rs, rowNum) -> toSummary(rs));
    }

    @Override
    public Optional<ExamAttemptComparison> compareLatest(UUID userId, UUID examPaperId) {
        var attempts = findSubmittedAttempts(userId, examPaperId).stream().limit(2).toList();
        if (attempts.size() < 2) {
            return Optional.empty();
        }
        var latest = attempts.get(0);
        var previous = attempts.get(1);
        return Optional.of(new ExamAttemptComparison(
                latest,
                previous,
                latest.scoredPoints().subtract(previous.scoredPoints()).intValue(),
                latest.accuracyPercent() - previous.accuracyPercent(),
                compareQuestions(latest.id(), previous.id())
        ));
    }

    @Override
    public ExamReportOverview overview(UUID userId) {
        var attempts = findSubmittedAttempts(userId, null);
        var attemptCount = attempts.size();
        var averageAccuracy = attemptCount == 0
                ? 0
                : (int) Math.round(attempts.stream().mapToInt(ExamAttemptSummary::accuracyPercent).average().orElse(0));
        var bestScore = attempts.stream()
                .map(ExamAttemptSummary::scoredPoints)
                .max(BigDecimal::compareTo)
                .orElse(BigDecimal.ZERO);
        var latestAccuracy = attempts.isEmpty() ? 0 : attempts.get(0).accuracyPercent();
        var totalDuration = attempts.stream().mapToInt(ExamAttemptSummary::durationSeconds).sum();
        return new ExamReportOverview(
                attemptCount,
                averageAccuracy,
                bestScore,
                latestAccuracy,
                totalDuration,
                attempts.stream()
                        .limit(12)
                        .map(attempt -> new ExamReportOverview.TrendPoint(
                                attempt.id(),
                                attempt.examPaperId(),
                                attempt.paperTitle(),
                                attempt.submittedAt().toString(),
                                attempt.scoredPoints(),
                                attempt.accuracyPercent()
                        ))
                        .toList(),
                findWeakQuestions(userId)
        );
    }

    @Override
    public int backfillMistakes(UUID userId, UUID attemptId) {
        var report = findReport(userId, attemptId)
                .orElseThrow(() -> new ResourceNotFoundException("Exam attempt report not found: " + attemptId));
        var created = 0;
        for (ExamAttemptReport.QuestionResult result : report.results()) {
            if (result.correct()) {
                continue;
            }
            var existingAttemptId = findBackfilledPracticeAttempt(
                    userId,
                    result.questionId(),
                    result.submittedAnswer(),
                    result.correctAnswer(),
                    report.submittedAt()
            );
            if (existingAttemptId.isPresent()) {
                continue;
            }
            var practiceAttemptId = UUID.randomUUID();
            jdbcTemplate.update("""
                    INSERT INTO practice_attempts (
                        id, user_id, question_id, submitted_answer, correct_answer,
                        correct, elapsed_seconds, submitted_at
                    )
                    VALUES (
                        :id, :userId, :questionId, :submittedAnswer, :correctAnswer,
                        false, :elapsedSeconds, :submittedAt
                    )
                    """, new MapSqlParameterSource()
                    .addValue("id", practiceAttemptId)
                    .addValue("userId", userId)
                    .addValue("questionId", result.questionId())
                    .addValue("submittedAnswer", result.submittedAnswer())
                    .addValue("correctAnswer", result.correctAnswer())
                    .addValue("elapsedSeconds", report.durationSeconds())
                    .addValue("submittedAt", Timestamp.from(report.submittedAt())));
            upsertMistake(userId, result.questionId(), practiceAttemptId, report.submittedAt());
            created++;
        }
        return created;
    }

    private void insertAnswer(
            UUID attemptId,
            PaperQuestion question,
            String submittedAnswer,
            boolean correct,
            BigDecimal earnedScore,
            Instant now
    ) {
        var sql = """
                INSERT INTO exam_attempt_answers (
                    id, exam_attempt_id, question_id, submitted_answer, correct_answer,
                    correct, score, earned_score, created_at
                )
                VALUES (
                    :id, :attemptId, :questionId, :submittedAnswer, :correctAnswer,
                    :correct, :score, :earnedScore, :createdAt
                )
                """;
        var params = new MapSqlParameterSource()
                .addValue("id", UUID.randomUUID())
                .addValue("attemptId", attemptId)
                .addValue("questionId", question.questionId())
                .addValue("submittedAnswer", submittedAnswer)
                .addValue("correctAnswer", question.correctAnswer())
                .addValue("correct", correct)
                .addValue("score", question.score())
                .addValue("earnedScore", earnedScore)
                .addValue("createdAt", Timestamp.from(now));
        jdbcTemplate.update(sql, params);
    }

    private Optional<AttemptRow> findStartedAttempt(UUID userId, UUID attemptId) {
        var sql = """
                SELECT id, exam_paper_id
                FROM exam_attempts
                WHERE id = :attemptId
                  AND user_id = :userId
                  AND status = 'STARTED'
                """;
        var params = new MapSqlParameterSource()
                .addValue("attemptId", attemptId)
                .addValue("userId", userId);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> new AttemptRow(
                rs.getObject("id", UUID.class),
                rs.getObject("exam_paper_id", UUID.class)
        )).stream().findFirst();
    }

    private List<PaperQuestion> findPaperQuestions(UUID examPaperId) {
        var sql = """
                SELECT epq.question_id, epq.sort_order, epq.score, q.answer, q.stem, q.explanation
                FROM exam_paper_questions epq
                JOIN questions q ON q.id = epq.question_id
                WHERE epq.exam_paper_id = :examPaperId
                ORDER BY epq.sort_order
                """;
        var params = new MapSqlParameterSource("examPaperId", examPaperId);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> new PaperQuestion(
                rs.getObject("question_id", UUID.class),
                rs.getInt("sort_order"),
                rs.getBigDecimal("score"),
                rs.getString("answer"),
                rs.getString("stem"),
                rs.getString("explanation")
        ));
    }

    private ExamAttemptReport toReport(ResultSet rs) throws SQLException {
        var attemptId = rs.getObject("id", UUID.class);
        var questionCount = rs.getInt("question_count");
        var correctCount = rs.getInt("correct_count");
        var accuracyPercent = questionCount == 0
                ? 0
                : BigDecimal.valueOf(correctCount)
                .multiply(BigDecimal.valueOf(100))
                .divide(BigDecimal.valueOf(questionCount), 0, RoundingMode.HALF_UP)
                .intValue();
        return new ExamAttemptReport(
                attemptId,
                rs.getObject("exam_paper_id", UUID.class),
                rs.getString("title"),
                rs.getString("status"),
                rs.getTimestamp("started_at").toInstant(),
                rs.getTimestamp("submitted_at").toInstant(),
                rs.getInt("duration_seconds"),
                rs.getBigDecimal("total_score"),
                rs.getBigDecimal("scored_points"),
                correctCount,
                questionCount,
                accuracyPercent,
                findResults(attemptId)
        );
    }

    private ExamAttemptSummary toSummary(ResultSet rs) throws SQLException {
        var questionCount = rs.getInt("question_count");
        var correctCount = rs.getInt("correct_count");
        var accuracyPercent = questionCount == 0
                ? 0
                : BigDecimal.valueOf(correctCount)
                .multiply(BigDecimal.valueOf(100))
                .divide(BigDecimal.valueOf(questionCount), 0, RoundingMode.HALF_UP)
                .intValue();
        return new ExamAttemptSummary(
                rs.getObject("id", UUID.class),
                rs.getObject("exam_paper_id", UUID.class),
                rs.getString("title"),
                rs.getTimestamp("submitted_at").toInstant(),
                rs.getInt("duration_seconds"),
                rs.getBigDecimal("total_score"),
                rs.getBigDecimal("scored_points"),
                correctCount,
                questionCount,
                accuracyPercent
        );
    }

    private List<ExamAttemptComparison.QuestionComparison> compareQuestions(UUID latestAttemptId, UUID previousAttemptId) {
        var sql = """
                SELECT latest.question_id,
                       epq.sort_order,
                       q.stem,
                       latest.correct AS latest_correct,
                       previous.correct AS previous_correct,
                       latest.submitted_answer AS latest_answer,
                       previous.submitted_answer AS previous_answer,
                       latest.correct_answer
                FROM exam_attempt_answers latest
                JOIN exam_attempts latest_attempt ON latest_attempt.id = latest.exam_attempt_id
                JOIN exam_attempt_answers previous
                  ON previous.question_id = latest.question_id
                 AND previous.exam_attempt_id = :previousAttemptId
                JOIN questions q ON q.id = latest.question_id
                JOIN exam_paper_questions epq
                  ON epq.exam_paper_id = latest_attempt.exam_paper_id
                 AND epq.question_id = latest.question_id
                WHERE latest.exam_attempt_id = :latestAttemptId
                ORDER BY epq.sort_order
                """;
        var params = new MapSqlParameterSource()
                .addValue("latestAttemptId", latestAttemptId)
                .addValue("previousAttemptId", previousAttemptId);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> new ExamAttemptComparison.QuestionComparison(
                rs.getObject("question_id", UUID.class),
                rs.getInt("sort_order"),
                rs.getString("stem"),
                rs.getBoolean("latest_correct"),
                rs.getBoolean("previous_correct"),
                rs.getString("latest_answer"),
                rs.getString("previous_answer"),
                rs.getString("correct_answer")
        ));
    }

    private List<ExamAttemptReport.QuestionResult> findResults(UUID attemptId) {
        var sql = """
                SELECT eaa.question_id, epq.sort_order, q.stem, eaa.submitted_answer,
                       eaa.correct_answer, eaa.correct, eaa.score, eaa.earned_score,
                       q.explanation
                FROM exam_attempt_answers eaa
                JOIN questions q ON q.id = eaa.question_id
                JOIN exam_attempts ea ON ea.id = eaa.exam_attempt_id
                JOIN exam_paper_questions epq
                  ON epq.exam_paper_id = ea.exam_paper_id
                 AND epq.question_id = eaa.question_id
                WHERE eaa.exam_attempt_id = :attemptId
                ORDER BY epq.sort_order
                """;
        var params = new MapSqlParameterSource("attemptId", attemptId);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> new ExamAttemptReport.QuestionResult(
                rs.getObject("question_id", UUID.class),
                rs.getInt("sort_order"),
                rs.getString("stem"),
                rs.getString("submitted_answer"),
                rs.getString("correct_answer"),
                rs.getBoolean("correct"),
                rs.getBigDecimal("score"),
                rs.getBigDecimal("earned_score"),
                rs.getString("explanation")
        ));
    }

    private Optional<UUID> findBackfilledPracticeAttempt(
            UUID userId,
            UUID questionId,
            String submittedAnswer,
            String correctAnswer,
            Instant submittedAt
    ) {
        return jdbcTemplate.query("""
                SELECT id
                FROM practice_attempts
                WHERE user_id = :userId
                  AND question_id = :questionId
                  AND submitted_answer = :submittedAnswer
                  AND correct_answer = :correctAnswer
                  AND submitted_at = :submittedAt
                """, new MapSqlParameterSource()
                .addValue("userId", userId)
                .addValue("questionId", questionId)
                .addValue("submittedAnswer", submittedAnswer)
                .addValue("correctAnswer", correctAnswer)
                .addValue("submittedAt", Timestamp.from(submittedAt)), (rs, rowNum) -> rs.getObject("id", UUID.class))
                .stream()
                .findFirst();
    }

    private void upsertMistake(UUID userId, UUID questionId, UUID practiceAttemptId, Instant submittedAt) {
        var existingMistakeId = jdbcTemplate.query("""
                SELECT id
                FROM mistakes
                WHERE user_id = :userId
                  AND question_id = :questionId
                """, new MapSqlParameterSource()
                .addValue("userId", userId)
                .addValue("questionId", questionId), (rs, rowNum) -> rs.getObject("id", UUID.class))
                .stream()
                .findFirst();
        if (existingMistakeId.isPresent()) {
            jdbcTemplate.update("""
                    UPDATE mistakes
                    SET latest_wrong_attempt_id = :attemptId,
                        wrong_count = wrong_count + 1,
                        mastered = false,
                        reason = 'EXAM_BACKFILL',
                        updated_at = :now
                    WHERE id = :mistakeId
                    """, new MapSqlParameterSource()
                    .addValue("mistakeId", existingMistakeId.get())
                    .addValue("attemptId", practiceAttemptId)
                    .addValue("now", Timestamp.from(submittedAt)));
            return;
        }
        jdbcTemplate.update("""
                INSERT INTO mistakes (
                    id, user_id, question_id, first_wrong_attempt_id, latest_wrong_attempt_id,
                    wrong_count, mastered, reason, created_at, updated_at
                )
                VALUES (
                    :id, :userId, :questionId, :attemptId, :attemptId,
                    1, false, 'EXAM_BACKFILL', :now, :now
                )
                """, new MapSqlParameterSource()
                .addValue("id", UUID.randomUUID())
                .addValue("userId", userId)
                .addValue("questionId", questionId)
                .addValue("attemptId", practiceAttemptId)
                .addValue("now", Timestamp.from(submittedAt)));
    }

    private List<ExamReportOverview.WeakQuestion> findWeakQuestions(UUID userId) {
        return jdbcTemplate.query("""
                SELECT eaa.question_id, q.stem, COUNT(*) AS wrong_count,
                       MAX(eaa.submitted_answer) AS latest_wrong_answer,
                       MAX(eaa.correct_answer) AS correct_answer
                FROM exam_attempt_answers eaa
                JOIN exam_attempts ea ON ea.id = eaa.exam_attempt_id
                JOIN questions q ON q.id = eaa.question_id
                WHERE ea.user_id = :userId
                  AND ea.status = 'SUBMITTED'
                  AND eaa.correct = false
                GROUP BY eaa.question_id, q.stem
                ORDER BY wrong_count DESC, q.stem
                LIMIT 5
                """, new MapSqlParameterSource("userId", userId), (rs, rowNum) -> new ExamReportOverview.WeakQuestion(
                rs.getObject("question_id", UUID.class),
                rs.getString("stem"),
                rs.getInt("wrong_count"),
                rs.getString("latest_wrong_answer"),
                rs.getString("correct_answer")
        ));
    }

    private record AttemptRow(UUID id, UUID examPaperId) {
    }

    private record PaperQuestion(
            UUID questionId,
            int sortOrder,
            BigDecimal score,
            String correctAnswer,
            String stem,
            String explanation
    ) {
    }
}
