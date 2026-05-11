package com.yanma408.mistake.infrastructure.persistence;

import com.yanma408.mistake.application.query.MistakeFilter;
import com.yanma408.mistake.application.query.MistakeQueryRepository;
import com.yanma408.mistake.application.query.MistakeSummary;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Repository
public class JdbcMistakeQueryRepository implements MistakeQueryRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;

    public JdbcMistakeQueryRepository(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<MistakeSummary> findByUserId(UUID userId, MistakeFilter filter) {
        var sql = new StringBuilder("""
                SELECT m.id,
                       m.question_id,
                       s.code AS subject_code,
                       s.name AS subject_name,
                       c.name AS chapter_name,
                       q.type,
                       q.difficulty,
                       q.stem,
                       q.source,
                       q.source_year,
                       q.score,
                       m.wrong_count,
                       m.mastered,
                       m.reason,
                       first_attempt.submitted_at AS first_wrong_at,
                       latest_attempt.submitted_at AS latest_wrong_at,
                       m.updated_at
                FROM mistakes m
                JOIN questions q ON q.id = m.question_id
                JOIN subjects s ON s.id = q.subject_id
                JOIN chapters c ON c.id = q.chapter_id
                JOIN practice_attempts first_attempt ON first_attempt.id = m.first_wrong_attempt_id
                JOIN practice_attempts latest_attempt ON latest_attempt.id = m.latest_wrong_attempt_id
                WHERE m.user_id = :userId
                """);
        var params = new MapSqlParameterSource("userId", userId);
        if (filter.subjectCode() != null && !filter.subjectCode().isBlank()) {
            sql.append(" AND s.code = :subjectCode\n");
            params.addValue("subjectCode", filter.subjectCode());
        }
        if (filter.mastered() != null) {
            sql.append(" AND m.mastered = :mastered\n");
            params.addValue("mastered", filter.mastered());
        }
        if ("PRIORITY".equalsIgnoreCase(filter.sort())) {
            sql.append("ORDER BY m.mastered ASC, m.wrong_count DESC, latest_attempt.submitted_at ASC");
        } else {
            sql.append("ORDER BY m.updated_at DESC");
        }
        return jdbcTemplate.query(sql.toString(), params, (rs, rowNum) -> toSummary(rs));
    }

    private MistakeSummary toSummary(ResultSet rs) throws SQLException {
        var questionId = rs.getObject("question_id", UUID.class);
        return new MistakeSummary(
                rs.getObject("id", UUID.class),
                questionId,
                rs.getString("subject_code"),
                rs.getString("subject_name"),
                rs.getString("chapter_name"),
                rs.getString("type"),
                rs.getString("difficulty"),
                rs.getString("stem"),
                rs.getString("source"),
                getNullableInteger(rs, "source_year"),
                rs.getBigDecimal("score"),
                rs.getInt("wrong_count"),
                rs.getBoolean("mastered"),
                rs.getString("reason"),
                getInstant(rs, "first_wrong_at"),
                getInstant(rs, "latest_wrong_at"),
                getInstant(rs, "updated_at"),
                findKnowledgePointNames(questionId)
        );
    }

    private List<String> findKnowledgePointNames(UUID questionId) {
        var sql = """
                SELECT kp.name
                FROM question_knowledge_points qkp
                JOIN knowledge_points kp ON kp.id = qkp.knowledge_point_id
                WHERE qkp.question_id = :questionId
                ORDER BY kp.sort_order
                """;
        var params = new MapSqlParameterSource("questionId", questionId);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> rs.getString("name"));
    }

    private Instant getInstant(ResultSet rs, String column) throws SQLException {
        Timestamp timestamp = rs.getTimestamp(column);
        return timestamp == null ? null : timestamp.toInstant();
    }

    private Integer getNullableInteger(ResultSet rs, String column) throws SQLException {
        var value = rs.getInt(column);
        return rs.wasNull() ? null : value;
    }
}
