package com.yanma408.question.application.importrecord;

import com.yanma408.shared.exception.ResourceNotFoundException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.UUID;

@Service
public class QuestionImportRecordService {
    private static final Set<String> IMPORT_MODES = Set.of("JSON", "FILE");
    private static final int DEFAULT_PAGE_SIZE = 20;
    private static final int MAX_PAGE_SIZE = 100;

    private final NamedParameterJdbcTemplate jdbcTemplate;

    public QuestionImportRecordService(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public void record(UUID operatorId, String importMode, List<UUID> questionIds) {
        if (questionIds == null || questionIds.isEmpty()) {
            throw new IllegalArgumentException("导入题目不能为空");
        }
        var batchId = UUID.randomUUID();
        var now = Timestamp.from(Instant.now());
        jdbcTemplate.update("""
                INSERT INTO question_import_batches (id, operator_id, import_mode, question_count, created_at)
                VALUES (:id, :operatorId, :importMode, :questionCount, :createdAt)
                """, new MapSqlParameterSource()
                .addValue("id", batchId)
                .addValue("operatorId", operatorId)
                .addValue("importMode", normalizeMode(importMode))
                .addValue("questionCount", questionIds.size())
                .addValue("createdAt", now));
        for (var questionId : questionIds) {
            jdbcTemplate.update("""
                    INSERT INTO question_import_batch_items (batch_id, question_id)
                    VALUES (:batchId, :questionId)
                    """, new MapSqlParameterSource()
                    .addValue("batchId", batchId)
                    .addValue("questionId", questionId));
        }
    }

    public QuestionImportBatchPage list(int page, int size) {
        var normalizedPage = Math.max(0, page);
        var normalizedSize = normalizeSize(size);
        var total = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM question_import_batches",
                new MapSqlParameterSource(),
                Integer.class
        );
        var items = jdbcTemplate.query("""
                SELECT b.id, b.import_mode, b.question_count, b.created_at,
                       u.username AS operator_username, u.display_name AS operator_display_name
                FROM question_import_batches b
                JOIN app_users u ON u.id = b.operator_id
                ORDER BY b.created_at DESC
                LIMIT :limit OFFSET :offset
                """, new MapSqlParameterSource()
                .addValue("limit", normalizedSize)
                .addValue("offset", normalizedPage * normalizedSize),
                (rs, rowNum) -> toSummary(rs));
        var totalValue = total == null ? 0 : total;
        return new QuestionImportBatchPage(
                items,
                normalizedPage,
                normalizedSize,
                totalValue,
                totalValue == 0 ? 0 : (int) Math.ceil((double) totalValue / normalizedSize)
        );
    }

    public QuestionImportBatchDetail find(UUID batchId) {
        var summary = jdbcTemplate.query("""
                SELECT b.id, b.import_mode, b.question_count, b.created_at,
                       u.username AS operator_username, u.display_name AS operator_display_name
                FROM question_import_batches b
                JOIN app_users u ON u.id = b.operator_id
                WHERE b.id = :batchId
                """, new MapSqlParameterSource("batchId", batchId), (rs, rowNum) -> toSummary(rs))
                .stream()
                .findFirst()
                .orElseThrow(() -> new ResourceNotFoundException("Question import batch not found: " + batchId));
        var items = jdbcTemplate.query("""
                SELECT q.id AS question_id, s.code AS subject_code, s.name AS subject_name,
                       c.name AS chapter_name, q.type, q.difficulty, q.source, q.stem
                FROM question_import_batch_items i
                JOIN questions q ON q.id = i.question_id
                JOIN subjects s ON s.id = q.subject_id
                JOIN chapters c ON c.id = q.chapter_id
                WHERE i.batch_id = :batchId
                ORDER BY q.created_at ASC
                """, new MapSqlParameterSource("batchId", batchId), (rs, rowNum) -> new QuestionImportBatchItem(
                rs.getObject("question_id", UUID.class),
                rs.getString("subject_code"),
                rs.getString("subject_name"),
                rs.getString("chapter_name"),
                rs.getString("type"),
                rs.getString("difficulty"),
                rs.getString("source"),
                rs.getString("stem")
        ));
        return new QuestionImportBatchDetail(
                summary.id(), summary.importMode(), summary.questionCount(), summary.operatorUsername(),
                summary.operatorDisplayName(), summary.createdAt(), items
        );
    }

    private QuestionImportBatchSummary toSummary(ResultSet rs) throws SQLException {
        return new QuestionImportBatchSummary(
                rs.getObject("id", UUID.class),
                rs.getString("import_mode"),
                rs.getInt("question_count"),
                rs.getString("operator_username"),
                rs.getString("operator_display_name"),
                rs.getTimestamp("created_at").toInstant()
        );
    }

    private String normalizeMode(String mode) {
        var normalized = mode == null ? "" : mode.trim().toUpperCase(Locale.ROOT);
        if (!IMPORT_MODES.contains(normalized)) {
            throw new IllegalArgumentException("不支持的导入方式: " + mode);
        }
        return normalized;
    }

    private int normalizeSize(int size) {
        if (size <= 0) {
            return DEFAULT_PAGE_SIZE;
        }
        return Math.min(size, MAX_PAGE_SIZE);
    }
}
