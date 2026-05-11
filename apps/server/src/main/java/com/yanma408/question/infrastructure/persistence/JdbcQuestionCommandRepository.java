package com.yanma408.question.infrastructure.persistence;

import com.yanma408.question.application.command.CreateQuestionCommand;
import com.yanma408.question.application.command.QuestionCommandRepository;
import com.yanma408.shared.exception.ResourceNotFoundException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Repository
public class JdbcQuestionCommandRepository implements QuestionCommandRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;

    public JdbcQuestionCommandRepository(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public UUID create(CreateQuestionCommand command) {
        var questionId = UUID.randomUUID();
        var subjectId = findId("subjects", "code", command.subjectCode(), "Subject not found: " + command.subjectCode());
        var chapterId = findId("chapters", "code", command.chapterCode(), "Chapter not found: " + command.chapterCode());
        var now = Instant.now();
        var questionSql = """
                INSERT INTO questions (
                    id, subject_id, chapter_id, type, difficulty, stem, answer,
                    explanation, source, source_year, score, status, review_status,
                    stem_format, stem_image_url, created_at, updated_at
                )
                VALUES (
                    :id, :subjectId, :chapterId, :type, :difficulty, :stem, :answer,
                    :explanation, :source, :sourceYear, :score, 'PUBLISHED', 'APPROVED',
                    :stemFormat, :stemImageUrl, :createdAt, :updatedAt
                )
                """;
        var questionParams = new MapSqlParameterSource()
                .addValue("id", questionId)
                .addValue("subjectId", subjectId)
                .addValue("chapterId", chapterId)
                .addValue("type", command.type())
                .addValue("difficulty", command.difficulty())
                .addValue("stem", command.stem())
                .addValue("answer", command.answer())
                .addValue("explanation", command.explanation())
                .addValue("source", command.source())
                .addValue("sourceYear", command.sourceYear())
                .addValue("score", command.score())
                .addValue("stemFormat", command.stemFormat())
                .addValue("stemImageUrl", command.stemImageUrl())
                .addValue("createdAt", Timestamp.from(now))
                .addValue("updatedAt", Timestamp.from(now));
        jdbcTemplate.update(questionSql, questionParams);

        replaceOptionsAndKnowledgePoints(questionId, command);
        return questionId;
    }

    @Override
    public void validateReferences(CreateQuestionCommand command) {
        findId("subjects", "code", command.subjectCode(), "Subject not found: " + command.subjectCode());
        findId("chapters", "code", command.chapterCode(), "Chapter not found: " + command.chapterCode());
        for (String code : command.knowledgePointCodes()) {
            findId("knowledge_points", "code", code, "Knowledge point not found: " + code);
        }
    }

    @Override
    public void update(UUID questionId, CreateQuestionCommand command) {
        var subjectId = findId("subjects", "code", command.subjectCode(), "Subject not found: " + command.subjectCode());
        var chapterId = findId("chapters", "code", command.chapterCode(), "Chapter not found: " + command.chapterCode());
        var sql = """
                UPDATE questions
                SET subject_id = :subjectId,
                    chapter_id = :chapterId,
                    type = :type,
                    difficulty = :difficulty,
                    stem = :stem,
                    answer = :answer,
                    explanation = :explanation,
                    source = :source,
                    source_year = :sourceYear,
                    score = :score,
                    stem_format = :stemFormat,
                    stem_image_url = :stemImageUrl,
                    updated_at = :updatedAt
                WHERE id = :questionId
                  AND status <> 'DELETED'
                """;
        var params = new MapSqlParameterSource()
                .addValue("questionId", questionId)
                .addValue("subjectId", subjectId)
                .addValue("chapterId", chapterId)
                .addValue("type", command.type())
                .addValue("difficulty", command.difficulty())
                .addValue("stem", command.stem())
                .addValue("answer", command.answer())
                .addValue("explanation", command.explanation())
                .addValue("source", command.source())
                .addValue("sourceYear", command.sourceYear())
                .addValue("score", command.score())
                .addValue("stemFormat", command.stemFormat())
                .addValue("stemImageUrl", command.stemImageUrl())
                .addValue("updatedAt", Timestamp.from(Instant.now()));
        int affectedRows = jdbcTemplate.update(sql, params);
        if (affectedRows == 0) {
            throw new ResourceNotFoundException("Question not found: " + questionId);
        }
        jdbcTemplate.update("DELETE FROM question_options WHERE question_id = :questionId", new MapSqlParameterSource("questionId", questionId));
        jdbcTemplate.update("DELETE FROM question_knowledge_points WHERE question_id = :questionId", new MapSqlParameterSource("questionId", questionId));
        jdbcTemplate.update("DELETE FROM question_tag_relations WHERE question_id = :questionId", new MapSqlParameterSource("questionId", questionId));
        replaceOptionsAndKnowledgePoints(questionId, command);
    }

    @Override
    public void updateStatus(UUID questionId, String status) {
        var sql = """
                UPDATE questions
                SET status = :status,
                    updated_at = :updatedAt
                WHERE id = :questionId
                  AND status <> 'DELETED'
                """;
        var params = new MapSqlParameterSource()
                .addValue("questionId", questionId)
                .addValue("status", status)
                .addValue("updatedAt", Timestamp.from(Instant.now()));
        int affectedRows = jdbcTemplate.update(sql, params);
        if (affectedRows == 0) {
            throw new ResourceNotFoundException("Question not found: " + questionId);
        }
    }

    @Override
    public void updateReviewStatus(UUID questionId, String reviewStatus, String reviewNote) {
        var sql = """
                UPDATE questions
                SET review_status = :reviewStatus,
                    review_note = :reviewNote,
                    reviewed_at = CURRENT_TIMESTAMP,
                    updated_at = :updatedAt
                WHERE id = :questionId
                  AND status <> 'DELETED'
                """;
        var params = new MapSqlParameterSource()
                .addValue("questionId", questionId)
                .addValue("reviewStatus", reviewStatus)
                .addValue("reviewNote", reviewNote)
                .addValue("updatedAt", Timestamp.from(Instant.now()));
        int affectedRows = jdbcTemplate.update(sql, params);
        if (affectedRows == 0) {
            throw new ResourceNotFoundException("Question not found: " + questionId);
        }
    }

    @Override
    public void bulkUpdate(List<UUID> questionIds, String status, String reviewStatus, List<String> tags) {
        if (status != null || reviewStatus != null) {
            var sql = new StringBuilder("UPDATE questions SET updated_at = :updatedAt");
            var params = new MapSqlParameterSource()
                    .addValue("ids", questionIds)
                    .addValue("updatedAt", Timestamp.from(Instant.now()));
            if (status != null) {
                sql.append(", status = :status");
                params.addValue("status", status);
            }
            if (reviewStatus != null) {
                sql.append(", review_status = :reviewStatus");
                params.addValue("reviewStatus", reviewStatus);
            }
            sql.append(" WHERE id IN (:ids) AND status <> 'DELETED'");
            jdbcTemplate.update(sql.toString(), params);
        }
        if (tags != null) {
            for (UUID questionId : questionIds) {
                jdbcTemplate.update(
                        "DELETE FROM question_tag_relations WHERE question_id = :questionId",
                        new MapSqlParameterSource("questionId", questionId)
                );
                replaceTags(questionId, tags);
            }
        }
    }

    @Override
    public void delete(UUID questionId) {
        var sql = """
                UPDATE questions
                SET status = 'DELETED',
                    updated_at = :updatedAt
                WHERE id = :questionId
                  AND status <> 'DELETED'
                """;
        var params = new MapSqlParameterSource()
                .addValue("questionId", questionId)
                .addValue("updatedAt", Timestamp.from(Instant.now()));
        int affectedRows = jdbcTemplate.update(sql, params);
        if (affectedRows == 0) {
            throw new ResourceNotFoundException("Question not found: " + questionId);
        }
    }

    private void replaceOptionsAndKnowledgePoints(UUID questionId, CreateQuestionCommand command) {
        for (int index = 0; index < command.options().size(); index++) {
            var option = command.options().get(index);
            var optionSql = """
                    INSERT INTO question_options (id, question_id, label, content, sort_order)
                    VALUES (:id, :questionId, :label, :content, :sortOrder)
                    """;
            var optionParams = new MapSqlParameterSource()
                    .addValue("id", UUID.randomUUID())
                    .addValue("questionId", questionId)
                    .addValue("label", option.label())
                    .addValue("content", option.content())
                    .addValue("sortOrder", index + 1);
            jdbcTemplate.update(optionSql, optionParams);
        }

        for (String code : command.knowledgePointCodes()) {
            var knowledgePointId = findId(
                    "knowledge_points",
                    "code",
                    code,
                    "Knowledge point not found: " + code
            );
            var relationSql = """
                    INSERT INTO question_knowledge_points (question_id, knowledge_point_id)
                    VALUES (:questionId, :knowledgePointId)
                    """;
            var relationParams = new MapSqlParameterSource()
                    .addValue("questionId", questionId)
                    .addValue("knowledgePointId", knowledgePointId);
            jdbcTemplate.update(relationSql, relationParams);
        }

        replaceTags(questionId, command.tags());
    }

    private void replaceTags(UUID questionId, List<String> tags) {
        for (String tag : tags) {
            var tagId = findOrCreateTag(tag);
            var sql = """
                    INSERT INTO question_tag_relations (question_id, tag_id)
                    VALUES (:questionId, :tagId)
                    ON CONFLICT DO NOTHING
                    """;
            var params = new MapSqlParameterSource()
                    .addValue("questionId", questionId)
                    .addValue("tagId", tagId);
            jdbcTemplate.update(sql, params);
        }
    }

    private UUID findOrCreateTag(String tag) {
        var existing = jdbcTemplate.query(
                        "SELECT id FROM question_tags WHERE name = :name",
                        new MapSqlParameterSource("name", tag),
                        (rs, rowNum) -> rs.getObject("id", UUID.class)
                )
                .stream()
                .findFirst();
        if (existing.isPresent()) {
            return existing.get();
        }
        var id = UUID.randomUUID();
        var sql = """
                INSERT INTO question_tags (id, name, created_at)
                VALUES (:id, :name, :createdAt)
                """;
        var params = new MapSqlParameterSource()
                .addValue("id", id)
                .addValue("name", tag)
                .addValue("createdAt", Timestamp.from(Instant.now()));
        jdbcTemplate.update(sql, params);
        return id;
    }

    private UUID findId(String tableName, String columnName, String value, String notFoundMessage) {
        var sql = "SELECT id FROM " + tableName + " WHERE " + columnName + " = :value";
        var params = new MapSqlParameterSource("value", value);
        return jdbcTemplate.query(sql, params, (rs, rowNum) -> rs.getObject("id", UUID.class))
                .stream()
                .findFirst()
                .orElseThrow(() -> new ResourceNotFoundException(notFoundMessage));
    }
}
