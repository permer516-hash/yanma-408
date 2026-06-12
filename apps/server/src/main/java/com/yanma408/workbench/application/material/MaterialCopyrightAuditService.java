package com.yanma408.workbench.application.material;

import com.yanma408.shared.exception.ResourceNotFoundException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.UUID;

@Service
public class MaterialCopyrightAuditService {
    private static final Set<String> SCOPES = Set.of("OWNED", "LICENSED", "PUBLIC_DOMAIN", "INTERNAL_REFERENCE", "UNKNOWN");
    private static final Set<String> RISKS = Set.of("LOW", "MEDIUM", "HIGH");
    private static final Set<String> DECISIONS = Set.of("APPROVED_FOR_EXTRACTION", "NEEDS_PERMISSION", "REJECTED");

    private final NamedParameterJdbcTemplate jdbcTemplate;
    private final MaterialAssetRepository materialAssetRepository;

    public MaterialCopyrightAuditService(
            NamedParameterJdbcTemplate jdbcTemplate,
            MaterialAssetRepository materialAssetRepository
    ) {
        this.jdbcTemplate = jdbcTemplate;
        this.materialAssetRepository = materialAssetRepository;
    }

    public List<MaterialCopyrightAudit> list(UUID materialAssetId) {
        ensureAssetExists(materialAssetId);
        return jdbcTemplate.query("""
                SELECT id, material_asset_id, source_name, source_year, authorization_scope,
                       risk_level, decision, notes, audited_by, audited_at
                FROM material_copyright_audits
                WHERE material_asset_id = :materialAssetId
                ORDER BY audited_at DESC
                """, new MapSqlParameterSource("materialAssetId", materialAssetId), this::mapRow);
    }

    @Transactional
    public MaterialCopyrightAudit create(UUID materialAssetId, MaterialCopyrightAuditCommand command) {
        var asset = ensureAssetExists(materialAssetId);
        var sourceName = text(command.sourceName(), "sourceName");
        var scope = normalizeAllowed(command.authorizationScope(), SCOPES, "authorizationScope");
        var risk = normalizeAllowed(command.riskLevel(), RISKS, "riskLevel");
        var decision = normalizeAllowed(command.decision(), DECISIONS, "decision");
        var sourceYear = command.sourceYear() == null ? asset.sourceYear() : command.sourceYear();
        if ("PAST_EXAM".equals(asset.sourceType()) && sourceYear == null) {
            throw new IllegalArgumentException("sourceYear is required for past exam audit");
        }
        if ("APPROVED_FOR_EXTRACTION".equals(decision) && ("UNKNOWN".equals(scope) || "HIGH".equals(risk))) {
            throw new IllegalArgumentException("High risk or unknown authorization cannot be approved for extraction");
        }
        var id = UUID.randomUUID();
        var auditedAt = Instant.now();
        jdbcTemplate.update("""
                INSERT INTO material_copyright_audits (
                    id, material_asset_id, source_name, source_year, authorization_scope,
                    risk_level, decision, notes, audited_by, audited_at
                ) VALUES (
                    :id, :materialAssetId, :sourceName, :sourceYear, :authorizationScope,
                    :riskLevel, :decision, :notes, :auditedBy, :auditedAt
                )
                """, new MapSqlParameterSource()
                .addValue("id", id)
                .addValue("materialAssetId", materialAssetId)
                .addValue("sourceName", sourceName)
                .addValue("sourceYear", sourceYear)
                .addValue("authorizationScope", scope)
                .addValue("riskLevel", risk)
                .addValue("decision", decision)
                .addValue("notes", blankToNull(command.notes()))
                .addValue("auditedBy", blankToNull(command.auditedBy()))
                .addValue("auditedAt", Timestamp.from(auditedAt)));
        return list(materialAssetId).stream()
                .filter(audit -> audit.id().equals(id))
                .findFirst()
                .orElseThrow(() -> new ResourceNotFoundException("Copyright audit not found: " + id));
    }

    private MaterialAsset ensureAssetExists(UUID id) {
        return materialAssetRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Material asset not found: " + id));
    }

    private MaterialCopyrightAudit mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new MaterialCopyrightAudit(
                rs.getObject("id", UUID.class),
                rs.getObject("material_asset_id", UUID.class),
                rs.getString("source_name"),
                nullableInteger(rs, "source_year"),
                rs.getString("authorization_scope"),
                rs.getString("risk_level"),
                rs.getString("decision"),
                rs.getString("notes"),
                rs.getString("audited_by"),
                rs.getTimestamp("audited_at").toInstant()
        );
    }

    private String normalizeAllowed(String value, Set<String> allowed, String fieldName) {
        var normalized = text(value, fieldName).toUpperCase(Locale.ROOT);
        if (!allowed.contains(normalized)) {
            throw new IllegalArgumentException("Unsupported " + fieldName + ": " + value);
        }
        return normalized;
    }

    private String text(String value, String fieldName) {
        if (value == null || value.isBlank()) {
            throw new IllegalArgumentException(fieldName + " is required");
        }
        return value.trim();
    }

    private String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }

    private Integer nullableInteger(ResultSet rs, String column) throws SQLException {
        var value = rs.getInt(column);
        return rs.wasNull() ? null : value;
    }
}
