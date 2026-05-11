package com.yanma408.practice.infrastructure.persistence;

import com.yanma408.practice.domain.model.PracticeAttempt;
import com.yanma408.practice.domain.repository.PracticeAttemptRepository;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;

@Repository
public class JdbcPracticeAttemptRepository implements PracticeAttemptRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;

    public JdbcPracticeAttemptRepository(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void save(PracticeAttempt attempt) {
        var sql = """
                INSERT INTO practice_attempts (
                    id, user_id, question_id, submitted_answer, correct_answer,
                    correct, elapsed_seconds, submitted_at
                ) VALUES (
                    :id, :userId, :questionId, :submittedAnswer, :correctAnswer,
                    :correct, :elapsedSeconds, :submittedAt
                )
                """;
        var params = new MapSqlParameterSource()
                .addValue("id", attempt.id())
                .addValue("userId", attempt.userId())
                .addValue("questionId", attempt.questionId())
                .addValue("submittedAnswer", attempt.submittedAnswer())
                .addValue("correctAnswer", attempt.correctAnswer())
                .addValue("correct", attempt.correct())
                .addValue("elapsedSeconds", Math.toIntExact(attempt.elapsed().toSeconds()))
                .addValue("submittedAt", Timestamp.from(attempt.submittedAt()));
        jdbcTemplate.update(sql, params);
    }
}
