package com.yanma408.exam.infrastructure.persistence;

import com.yanma408.exam.application.query.ExamPaperQueryRepository;
import com.yanma408.exam.application.query.ExamPaperDetail;
import com.yanma408.exam.application.query.ExamPaperSummary;
import com.yanma408.question.domain.repository.QuestionQueryRepository;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Repository
public class JdbcExamPaperQueryRepository implements ExamPaperQueryRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;
    private final QuestionQueryRepository questionQueryRepository;

    public JdbcExamPaperQueryRepository(NamedParameterJdbcTemplate jdbcTemplate, QuestionQueryRepository questionQueryRepository) {
        this.jdbcTemplate = jdbcTemplate;
        this.questionQueryRepository = questionQueryRepository;
    }

    @Override
    public List<ExamPaperSummary> findPublished() {
        var sql = """
                SELECT id, title, paper_type, source_year, duration_minutes,
                       total_score, question_count
                FROM exam_papers
                WHERE status = 'PUBLISHED'
                ORDER BY created_at DESC
                """;
        return jdbcTemplate.query(sql, Map.of(), (rs, rowNum) -> new ExamPaperSummary(
                rs.getObject("id", UUID.class),
                rs.getString("title"),
                rs.getString("paper_type"),
                rs.getObject("source_year", Integer.class),
                rs.getInt("duration_minutes"),
                rs.getBigDecimal("total_score").intValue(),
                rs.getInt("question_count")
        ));
    }

    @Override
    public Optional<ExamPaperDetail> findPublishedDetail(UUID id) {
        var sql = """
                SELECT id, title, paper_type, source_year, duration_minutes,
                       total_score, question_count
                FROM exam_papers
                WHERE id = :id
                  AND status = 'PUBLISHED'
                """;
        var params = new MapSqlParameterSource("id", id);
        var papers = jdbcTemplate.query(sql, params, (rs, rowNum) -> new ExamPaperDetail(
                rs.getObject("id", UUID.class),
                rs.getString("title"),
                rs.getString("paper_type"),
                rs.getObject("source_year", Integer.class),
                rs.getInt("duration_minutes"),
                rs.getBigDecimal("total_score").intValue(),
                rs.getInt("question_count"),
                findQuestions(id)
        ));
        return papers.stream().findFirst();
    }

    private List<com.yanma408.question.application.query.QuestionDetail> findQuestions(UUID paperId) {
        var sql = """
                SELECT question_id
                FROM exam_paper_questions
                WHERE exam_paper_id = :paperId
                ORDER BY sort_order
                """;
        var params = new MapSqlParameterSource("paperId", paperId);
        var questionIds = jdbcTemplate.query(sql, params, (rs, rowNum) -> rs.getObject("question_id", UUID.class));
        return questionIds.stream()
                .map(questionQueryRepository::findPublishedDetail)
                .flatMap(Optional::stream)
                .toList();
    }
}
