package com.yanma408.question.infrastructure.persistence;

import com.yanma408.question.domain.repository.QuestionAnswerRepository;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public class JdbcQuestionAnswerRepository implements QuestionAnswerRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;

    public JdbcQuestionAnswerRepository(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Optional<QuestionAnswerSnapshot> findPublishedAnswer(UUID questionId) {
        var sql = """
                SELECT id, answer, explanation
                FROM questions
                WHERE id = :questionId
                  AND status = 'PUBLISHED'
                """;
        var params = new MapSqlParameterSource("questionId", questionId);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> new QuestionAnswerSnapshot(
                rs.getObject("id", UUID.class),
                rs.getString("answer"),
                rs.getString("explanation")
        )).stream().findFirst();
    }
}
