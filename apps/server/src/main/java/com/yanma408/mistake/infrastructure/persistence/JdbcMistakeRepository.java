package com.yanma408.mistake.infrastructure.persistence;

import com.yanma408.mistake.application.service.MistakeUpdateResult;
import com.yanma408.mistake.domain.repository.MistakeRepository;
import com.yanma408.practice.domain.model.PracticeAttempt;
import com.yanma408.shared.exception.ResourceNotFoundException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.UUID;

@Repository
public class JdbcMistakeRepository implements MistakeRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;

    public JdbcMistakeRepository(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public MistakeUpdateResult upsertWrongAttempt(PracticeAttempt attempt) {
        var params = new MapSqlParameterSource()
                .addValue("id", UUID.randomUUID())
                .addValue("userId", attempt.userId())
                .addValue("questionId", attempt.questionId())
                .addValue("attemptId", attempt.id())
                .addValue("now", Timestamp.from(attempt.submittedAt()));

        var updatedRows = jdbcTemplate.update("""
                UPDATE mistakes
                SET latest_wrong_attempt_id = :attemptId,
                    wrong_count = wrong_count + 1,
                    mastered = false,
                    updated_at = :now
                WHERE user_id = :userId
                  AND question_id = :questionId
                """, params);
        if (updatedRows == 0) {
            jdbcTemplate.update("""
                    INSERT INTO mistakes (
                        id, user_id, question_id, first_wrong_attempt_id, latest_wrong_attempt_id,
                        wrong_count, mastered, reason, created_at, updated_at
                    ) VALUES (
                        :id, :userId, :questionId, :attemptId, :attemptId,
                        1, false, null, :now, :now
                    )
                    """, params);
        }

        var wrongCount = jdbcTemplate.queryForObject("""
                SELECT wrong_count
                FROM mistakes
                WHERE user_id = :userId
                  AND question_id = :questionId
                """, params, Integer.class);
        return new MistakeUpdateResult(true, wrongCount == null ? 1 : wrongCount);
    }

    @Override
    public void markMastered(UUID userId, UUID questionId) {
        var sql = """
                UPDATE mistakes
                SET mastered = true,
                    updated_at = CURRENT_TIMESTAMP
                WHERE user_id = :userId
                  AND question_id = :questionId
                """;
        var params = new MapSqlParameterSource()
                .addValue("userId", userId)
                .addValue("questionId", questionId);
        jdbcTemplate.update(sql, params);
    }

    @Override
    public void updateMastered(UUID userId, UUID mistakeId, boolean mastered) {
        var sql = """
                UPDATE mistakes
                SET mastered = :mastered,
                    updated_at = CURRENT_TIMESTAMP
                WHERE user_id = :userId
                  AND id = :mistakeId
                """;
        var params = new MapSqlParameterSource()
                .addValue("mastered", mastered)
                .addValue("userId", userId)
                .addValue("mistakeId", mistakeId);
        var affectedRows = jdbcTemplate.update(sql, params);
        if (affectedRows == 0) {
            throw new ResourceNotFoundException("Mistake not found: " + mistakeId);
        }
    }
}
