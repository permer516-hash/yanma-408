package com.yanma408.question.infrastructure.persistence;

import com.yanma408.question.application.query.KnowledgePointView;
import com.yanma408.question.application.query.QuestionDetail;
import com.yanma408.question.application.query.QuestionOptionView;
import com.yanma408.question.application.query.QuestionPage;
import com.yanma408.question.application.query.QuestionSearchFilter;
import com.yanma408.question.application.query.QuestionSummary;
import com.yanma408.question.domain.repository.QuestionQueryRepository;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public class JdbcQuestionQueryRepository implements QuestionQueryRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;

    public JdbcQuestionQueryRepository(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<QuestionSummary> findPublished(String subjectCode) {
        return findQuestions(subjectCode, true);
    }

    @Override
    public QuestionPage searchPublished(QuestionSearchFilter filter) {
        var page = filter.normalizedPage();
        var size = filter.normalizedSize();
        var where = new StringBuilder(" WHERE q.status = 'PUBLISHED' AND q.review_status = 'APPROVED'\n");
        var params = new MapSqlParameterSource();
        appendSearchFilters(where, params, filter);
        var countSql = """
                SELECT COUNT(DISTINCT q.id)
                FROM questions q
                JOIN subjects s ON s.id = q.subject_id
                JOIN chapters c ON c.id = q.chapter_id
                LEFT JOIN question_knowledge_points qkp ON qkp.question_id = q.id
                LEFT JOIN knowledge_points kp ON kp.id = qkp.knowledge_point_id
                """ + where;
        var total = jdbcTemplate.queryForObject(countSql, params, Integer.class);
        var sql = """
                SELECT DISTINCT q.id,
                       s.code AS subject_code,
                       s.name AS subject_name,
                       c.name AS chapter_name,
                       q.type,
                       q.difficulty,
                       q.stem,
                       q.source,
                       q.source_year,
                       q.score,
                       q.status,
                       q.review_status,
                       q.review_note,
                       q.stem_format,
                       q.stem_image_url,
                       s.sort_order,
                       c.sort_order,
                       q.created_at
                FROM questions q
                JOIN subjects s ON s.id = q.subject_id
                JOIN chapters c ON c.id = q.chapter_id
                LEFT JOIN question_knowledge_points qkp ON qkp.question_id = q.id
                LEFT JOIN knowledge_points kp ON kp.id = qkp.knowledge_point_id
                """ + where + """
                ORDER BY s.sort_order, c.sort_order, q.created_at DESC
                LIMIT :limit OFFSET :offset
                """;
        params.addValue("limit", size);
        params.addValue("offset", page * size);
        var items = jdbcTemplate.query(sql, params, (rs, rowNum) -> toSummary(rs));
        var totalValue = total == null ? 0 : total;
        var totalPages = totalValue == 0 ? 0 : (int) Math.ceil((double) totalValue / size);
        return new QuestionPage(items, page, size, totalValue, totalPages);
    }

    @Override
    public List<QuestionSummary> findAll(String subjectCode) {
        return findQuestions(subjectCode, false);
    }

    private List<QuestionSummary> findQuestions(String subjectCode, boolean publishedOnly) {
        var sql = new StringBuilder("""
                SELECT q.id,
                       s.code AS subject_code,
                       s.name AS subject_name,
                       c.name AS chapter_name,
                       q.type,
                       q.difficulty,
                       q.stem,
                       q.source,
                       q.source_year,
                       q.score,
                       q.status,
                       q.review_status,
                       q.review_note,
                       q.stem_format,
                       q.stem_image_url
                FROM questions q
                JOIN subjects s ON s.id = q.subject_id
                JOIN chapters c ON c.id = q.chapter_id
                WHERE 1 = 1
                """);
        var params = new MapSqlParameterSource();
        if (publishedOnly) {
            sql.append(" AND q.status = 'PUBLISHED' AND q.review_status = 'APPROVED'\n");
        }
        if (subjectCode != null && !subjectCode.isBlank()) {
            sql.append(" AND s.code = :subjectCode\n");
            params.addValue("subjectCode", subjectCode);
        }
        sql.append("ORDER BY s.sort_order, c.sort_order, q.created_at DESC");
        return jdbcTemplate.query(sql.toString(), params, (rs, rowNum) -> toSummary(rs));
    }

    private void appendSearchFilters(StringBuilder where, MapSqlParameterSource params, QuestionSearchFilter filter) {
        if (filter.subjectCode() != null && !filter.subjectCode().isBlank()) {
            where.append(" AND s.code = :subjectCode\n");
            params.addValue("subjectCode", filter.subjectCode());
        }
        if (filter.keyword() != null && !filter.keyword().isBlank()) {
            where.append(" AND (LOWER(q.stem) LIKE :keyword OR LOWER(q.explanation) LIKE :keyword)\n");
            params.addValue("keyword", "%" + filter.keyword().trim().toLowerCase() + "%");
        }
        if (filter.difficulty() != null && !filter.difficulty().isBlank()) {
            where.append(" AND q.difficulty = :difficulty\n");
            params.addValue("difficulty", filter.difficulty().trim().toUpperCase());
        }
        if (filter.knowledgePoint() != null && !filter.knowledgePoint().isBlank()) {
            where.append(" AND (kp.code = :knowledgePoint OR kp.name LIKE :knowledgePointName)\n");
            params.addValue("knowledgePoint", filter.knowledgePoint().trim().toUpperCase());
            params.addValue("knowledgePointName", "%" + filter.knowledgePoint().trim() + "%");
        }
    }

    @Override
    public Optional<QuestionDetail> findPublishedDetail(UUID id) {
        var sql = """
                SELECT q.id,
                       s.code AS subject_code,
                       s.name AS subject_name,
                       c.code AS chapter_code,
                       c.name AS chapter_name,
                       q.type,
                       q.difficulty,
                       q.stem,
                       q.answer,
                       q.explanation,
                       q.source,
                       q.source_year,
                       q.score,
                       q.status,
                       q.review_status,
                       q.review_note,
                       q.stem_format,
                       q.stem_image_url
                FROM questions q
                JOIN subjects s ON s.id = q.subject_id
                JOIN chapters c ON c.id = q.chapter_id
                WHERE q.id = :id
                  AND q.status = 'PUBLISHED'
                  AND q.review_status = 'APPROVED'
                """;
        var params = new MapSqlParameterSource("id", id);
        var results = jdbcTemplate.query(sql, params, (rs, rowNum) -> toDetail(rs));
        return results.stream().findFirst();
    }

    @Override
    public Optional<QuestionDetail> findDetail(UUID id) {
        var sql = """
                SELECT q.id,
                       s.code AS subject_code,
                       s.name AS subject_name,
                       c.code AS chapter_code,
                       c.name AS chapter_name,
                       q.type,
                       q.difficulty,
                       q.stem,
                       q.answer,
                       q.explanation,
                       q.source,
                       q.source_year,
                       q.score,
                       q.status,
                       q.review_status,
                       q.review_note,
                       q.stem_format,
                       q.stem_image_url
                FROM questions q
                JOIN subjects s ON s.id = q.subject_id
                JOIN chapters c ON c.id = q.chapter_id
                WHERE q.id = :id
                """;
        var params = new MapSqlParameterSource("id", id);
        var results = jdbcTemplate.query(sql, params, (rs, rowNum) -> toDetail(rs));
        return results.stream().findFirst();
    }

    private QuestionSummary toSummary(ResultSet rs) throws SQLException {
        var id = rs.getObject("id", UUID.class);
        return new QuestionSummary(
                id,
                rs.getString("subject_code"),
                rs.getString("subject_name"),
                rs.getString("chapter_name"),
                rs.getString("type"),
                rs.getString("difficulty"),
                rs.getString("stem"),
                rs.getString("source"),
                getNullableInteger(rs, "source_year"),
                rs.getBigDecimal("score"),
                rs.getString("status"),
                rs.getString("review_status"),
                rs.getString("review_note"),
                rs.getString("stem_format"),
                rs.getString("stem_image_url"),
                findTags(id),
                findKnowledgePointNames(id)
        );
    }

    private QuestionDetail toDetail(ResultSet rs) throws SQLException {
        var id = rs.getObject("id", UUID.class);
        return new QuestionDetail(
                id,
                rs.getString("subject_code"),
                rs.getString("subject_name"),
                rs.getString("chapter_code"),
                rs.getString("chapter_name"),
                rs.getString("type"),
                rs.getString("difficulty"),
                rs.getString("stem"),
                rs.getString("answer"),
                rs.getString("explanation"),
                rs.getString("source"),
                getNullableInteger(rs, "source_year"),
                rs.getBigDecimal("score"),
                rs.getString("status"),
                rs.getString("review_status"),
                rs.getString("review_note"),
                rs.getString("stem_format"),
                rs.getString("stem_image_url"),
                findTags(id),
                findOptions(id),
                findKnowledgePoints(id)
        );
    }

    private List<QuestionOptionView> findOptions(UUID questionId) {
        var sql = """
                SELECT id, label, content
                FROM question_options
                WHERE question_id = :questionId
                ORDER BY sort_order
                """;
        var params = new MapSqlParameterSource("questionId", questionId);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> new QuestionOptionView(
                rs.getObject("id", UUID.class),
                rs.getString("label"),
                rs.getString("content")
        ));
    }

    private List<KnowledgePointView> findKnowledgePoints(UUID questionId) {
        var sql = """
                SELECT kp.id, kp.code, kp.name
                FROM question_knowledge_points qkp
                JOIN knowledge_points kp ON kp.id = qkp.knowledge_point_id
                WHERE qkp.question_id = :questionId
                ORDER BY kp.sort_order
                """;
        var params = new MapSqlParameterSource("questionId", questionId);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> new KnowledgePointView(
                rs.getObject("id", UUID.class),
                rs.getString("code"),
                rs.getString("name")
        ));
    }

    private List<String> findKnowledgePointNames(UUID questionId) {
        return findKnowledgePoints(questionId).stream().map(KnowledgePointView::name).toList();
    }

    private List<String> findTags(UUID questionId) {
        var sql = """
                SELECT qt.name
                FROM question_tag_relations qtr
                JOIN question_tags qt ON qt.id = qtr.tag_id
                WHERE qtr.question_id = :questionId
                ORDER BY qt.name
                """;
        var params = new MapSqlParameterSource("questionId", questionId);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> rs.getString("name"));
    }

    private Integer getNullableInteger(ResultSet rs, String column) throws SQLException {
        var value = rs.getInt(column);
        return rs.wasNull() ? null : value;
    }
}
