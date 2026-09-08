package com.yanma408.comprehensive.application;

import com.yanma408.question.application.query.ComprehensivePartView;
import com.yanma408.shared.exception.ResourceNotFoundException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Service
public class ComprehensiveQuestionService {
    private static final Set<String> RESPONSE_MODES = Set.of("RICH_TEXT", "PSEUDOCODE", "CALCULATION", "IMAGE");
    private final NamedParameterJdbcTemplate jdbcTemplate;

    public ComprehensiveQuestionService(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Transactional
    public void replaceParts(UUID questionId, List<ComprehensivePartCommand> parts) {
        var normalized = normalize(parts);
        var parentScore = findParentScore(questionId);
        var partsScore = normalized.stream().map(ComprehensivePartCommand::score).reduce(BigDecimal.ZERO, BigDecimal::add);
        if (partsScore.compareTo(parentScore) != 0) {
            throw new IllegalArgumentException("综合题小问分值之和必须等于题目总分");
        }
        jdbcTemplate.update("DELETE FROM comprehensive_question_parts WHERE question_id = :questionId", new MapSqlParameterSource("questionId", questionId));
        var now = Timestamp.from(Instant.now());
        for (int index = 0; index < normalized.size(); index++) {
            var part = normalized.get(index);
            var partId = UUID.randomUUID();
            jdbcTemplate.update("""
                    INSERT INTO comprehensive_question_parts (
                        id, question_id, sort_order, prompt, response_mode, reference_answer,
                        explanation, score, image_url, created_at, updated_at
                    ) VALUES (
                        :id, :questionId, :sortOrder, :prompt, :responseMode, :referenceAnswer,
                        :explanation, :score, :imageUrl, :createdAt, :updatedAt
                    )
                    """, new MapSqlParameterSource()
                    .addValue("id", partId)
                    .addValue("questionId", questionId)
                    .addValue("sortOrder", index + 1)
                    .addValue("prompt", part.prompt())
                    .addValue("responseMode", part.responseMode())
                    .addValue("referenceAnswer", part.referenceAnswer())
                    .addValue("explanation", part.explanation())
                    .addValue("score", part.score())
                    .addValue("imageUrl", part.imageUrl())
                    .addValue("createdAt", now)
                    .addValue("updatedAt", now));
            for (int rubricIndex = 0; rubricIndex < part.rubrics().size(); rubricIndex++) {
                var rubric = part.rubrics().get(rubricIndex);
                jdbcTemplate.update("""
                        INSERT INTO comprehensive_part_rubrics (id, part_id, sort_order, criterion, score)
                        VALUES (:id, :partId, :sortOrder, :criterion, :score)
                        """, new MapSqlParameterSource()
                        .addValue("id", UUID.randomUUID())
                        .addValue("partId", partId)
                        .addValue("sortOrder", rubricIndex + 1)
                        .addValue("criterion", rubric.criterion())
                        .addValue("score", rubric.score()));
            }
        }
    }

    public List<ComprehensivePartView> findParts(UUID questionId) {
        return jdbcTemplate.query("""
                SELECT id, sort_order, prompt, response_mode, reference_answer, explanation, score, image_url
                FROM comprehensive_question_parts
                WHERE question_id = :questionId
                ORDER BY sort_order
                """, new MapSqlParameterSource("questionId", questionId), (rs, rowNum) -> {
            var partId = rs.getObject("id", UUID.class);
            var rubrics = jdbcTemplate.query("""
                    SELECT id, sort_order, criterion, score
                    FROM comprehensive_part_rubrics
                    WHERE part_id = :partId
                    ORDER BY sort_order
                    """, new MapSqlParameterSource("partId", partId), (rubricRs, rubricRow) -> new ComprehensivePartView.RubricView(
                    rubricRs.getObject("id", UUID.class),
                    rubricRs.getInt("sort_order"),
                    rubricRs.getString("criterion"),
                    rubricRs.getBigDecimal("score")
            ));
            return new ComprehensivePartView(
                    partId,
                    rs.getInt("sort_order"),
                    rs.getString("prompt"),
                    rs.getString("response_mode"),
                    rs.getString("reference_answer"),
                    rs.getString("explanation"),
                    rs.getBigDecimal("score"),
                    rs.getString("image_url"),
                    rubrics
            );
        });
    }

    private BigDecimal findParentScore(UUID questionId) {
        var parent = jdbcTemplate.query("""
                SELECT type, score
                FROM questions
                WHERE id = :questionId AND status <> 'DELETED'
                """, new MapSqlParameterSource("questionId", questionId), (rs, rowNum) -> new Object[] { rs.getString("type"), rs.getBigDecimal("score") })
                .stream().findFirst().orElseThrow(() -> new ResourceNotFoundException("Question not found: " + questionId));
        if (!"COMPREHENSIVE".equals(parent[0])) {
            throw new IllegalArgumentException("只能为综合题维护小问");
        }
        return (BigDecimal) parent[1];
    }

    private List<ComprehensivePartCommand> normalize(List<ComprehensivePartCommand> parts) {
        if (parts == null || parts.isEmpty()) {
            throw new IllegalArgumentException("综合题至少需要一个小问");
        }
        return parts.stream().map(part -> {
            requireText(part.prompt(), "小问题干");
            requireText(part.referenceAnswer(), "小问标准答案");
            requireText(part.explanation(), "小问解析");
            var responseMode = part.responseMode() == null ? "RICH_TEXT" : part.responseMode().trim().toUpperCase();
            if (!RESPONSE_MODES.contains(responseMode)) {
                throw new IllegalArgumentException("不支持的作答方式: " + part.responseMode());
            }
            if (part.score() == null || part.score().compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("小问分值必须大于 0");
            }
            var rubrics = part.rubrics() == null ? List.<ComprehensivePartCommand.RubricCommand>of() : part.rubrics();
            if (rubrics.isEmpty()) {
                throw new IllegalArgumentException("每个小问至少需要一个评分点");
            }
            var rubricScore = rubrics.stream().map(rubric -> {
                requireText(rubric.criterion(), "评分点");
                if (rubric.score() == null || rubric.score().compareTo(BigDecimal.ZERO) <= 0) {
                    throw new IllegalArgumentException("评分点分值必须大于 0");
                }
                return rubric.score();
            }).reduce(BigDecimal.ZERO, BigDecimal::add);
            if (rubricScore.compareTo(part.score()) != 0) {
                throw new IllegalArgumentException("评分点分值之和必须等于小问分值");
            }
            return new ComprehensivePartCommand(
                    part.prompt().trim(), responseMode, part.referenceAnswer().trim(), part.explanation().trim(), part.score(),
                    part.imageUrl() == null || part.imageUrl().isBlank() ? null : part.imageUrl().trim(), rubrics
            );
        }).toList();
    }

    private void requireText(String value, String label) {
        if (value == null || value.isBlank()) {
            throw new IllegalArgumentException(label + "不能为空");
        }
    }
}
