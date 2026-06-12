package com.yanma408.workbench.infrastructure.persistence;

import com.yanma408.workbench.application.material.MaterialAsset;
import com.yanma408.workbench.application.material.MaterialAssetRepository;
import com.yanma408.workbench.application.material.MaterialAssetSearchFilter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public class JdbcMaterialAssetRepository implements MaterialAssetRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;

    public JdbcMaterialAssetRepository(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public MaterialAsset save(MaterialAsset asset) {
        jdbcTemplate.update("""
                INSERT INTO material_assets (
                    id, title, subject_code, source_type, source_year, bucket, object_key,
                    original_file_name, content_type, size_bytes, sha256, status, notes,
                    created_at, updated_at
                ) VALUES (
                    :id, :title, :subjectCode, :sourceType, :sourceYear, :bucket, :objectKey,
                    :originalFileName, :contentType, :sizeBytes, :sha256, :status, :notes,
                    :createdAt, :updatedAt
                )
                """, params(asset));
        return asset;
    }

    @Override
    public MaterialAsset saveIfAbsent(MaterialAsset asset) {
        return findByBucketAndObjectKey(asset.bucket(), asset.objectKey())
                .orElseGet(() -> save(asset));
    }

    @Override
    public List<MaterialAsset> search(MaterialAssetSearchFilter filter) {
        var sql = new StringBuilder("""
                SELECT id, title, subject_code, source_type, source_year, bucket, object_key,
                       original_file_name, content_type, size_bytes, sha256, status, notes,
                       created_at, updated_at
                FROM material_assets
                WHERE 1 = 1
                """);
        var params = new MapSqlParameterSource();
        if (filter.keyword() != null && !filter.keyword().isBlank()) {
            sql.append(" AND (title LIKE :keyword OR original_file_name LIKE :keyword OR notes LIKE :keyword)\n");
            params.addValue("keyword", "%" + filter.keyword().trim() + "%");
        }
        if (filter.subjectCode() != null && !filter.subjectCode().isBlank()) {
            sql.append(" AND subject_code = :subjectCode\n");
            params.addValue("subjectCode", filter.subjectCode());
        }
        if (filter.sourceType() != null && !filter.sourceType().isBlank()) {
            sql.append(" AND source_type = :sourceType\n");
            params.addValue("sourceType", filter.sourceType());
        }
        if (filter.status() != null && !filter.status().isBlank()) {
            sql.append(" AND status = :status\n");
            params.addValue("status", filter.status());
        }
        sql.append(" ORDER BY created_at DESC LIMIT 200");
        return jdbcTemplate.query(sql.toString(), params, this::mapRow);
    }

    @Override
    public Optional<MaterialAsset> findById(UUID id) {
        var sql = """
                SELECT id, title, subject_code, source_type, source_year, bucket, object_key,
                       original_file_name, content_type, size_bytes, sha256, status, notes,
                       created_at, updated_at
                FROM material_assets
                WHERE id = :id
                """;
        var result = jdbcTemplate.query(sql, new MapSqlParameterSource("id", id), this::mapRow);
        return result.stream().findFirst();
    }

    @Override
    public Optional<MaterialAsset> findByBucketAndObjectKey(String bucket, String objectKey) {
        var sql = """
                SELECT id, title, subject_code, source_type, source_year, bucket, object_key,
                       original_file_name, content_type, size_bytes, sha256, status, notes,
                       created_at, updated_at
                FROM material_assets
                WHERE bucket = :bucket
                  AND object_key = :objectKey
                """;
        var params = new MapSqlParameterSource()
                .addValue("bucket", bucket)
                .addValue("objectKey", objectKey);
        var result = jdbcTemplate.query(sql, params, this::mapRow);
        return result.stream().findFirst();
    }

    private MapSqlParameterSource params(MaterialAsset asset) {
        return new MapSqlParameterSource()
                .addValue("id", asset.id())
                .addValue("title", asset.title())
                .addValue("subjectCode", asset.subjectCode())
                .addValue("sourceType", asset.sourceType())
                .addValue("sourceYear", asset.sourceYear())
                .addValue("bucket", asset.bucket())
                .addValue("objectKey", asset.objectKey())
                .addValue("originalFileName", asset.originalFileName())
                .addValue("contentType", asset.contentType())
                .addValue("sizeBytes", asset.sizeBytes())
                .addValue("sha256", asset.sha256())
                .addValue("status", asset.status())
                .addValue("notes", asset.notes())
                .addValue("createdAt", Timestamp.from(asset.createdAt()))
                .addValue("updatedAt", Timestamp.from(asset.updatedAt()));
    }

    private MaterialAsset mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new MaterialAsset(
                rs.getObject("id", UUID.class),
                rs.getString("title"),
                rs.getString("subject_code"),
                rs.getString("source_type"),
                getNullableInteger(rs, "source_year"),
                rs.getString("bucket"),
                rs.getString("object_key"),
                rs.getString("original_file_name"),
                rs.getString("content_type"),
                rs.getLong("size_bytes"),
                rs.getString("sha256"),
                rs.getString("status"),
                rs.getString("notes"),
                rs.getTimestamp("created_at").toInstant(),
                rs.getTimestamp("updated_at").toInstant()
        );
    }

    private Integer getNullableInteger(ResultSet rs, String column) throws SQLException {
        var value = rs.getInt(column);
        return rs.wasNull() ? null : value;
    }
}
