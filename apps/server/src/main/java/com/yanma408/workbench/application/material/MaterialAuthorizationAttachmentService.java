package com.yanma408.workbench.application.material;

import com.yanma408.shared.exception.ResourceNotFoundException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.DigestInputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.HexFormat;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

@Service
public class MaterialAuthorizationAttachmentService {
    private final NamedParameterJdbcTemplate jdbcTemplate;
    private final MaterialAssetRepository materialAssetRepository;
    private final ObjectStorageService objectStorageService;

    public MaterialAuthorizationAttachmentService(
            NamedParameterJdbcTemplate jdbcTemplate,
            MaterialAssetRepository materialAssetRepository,
            ObjectStorageService objectStorageService
    ) {
        this.jdbcTemplate = jdbcTemplate;
        this.materialAssetRepository = materialAssetRepository;
        this.objectStorageService = objectStorageService;
    }

    public List<MaterialAuthorizationAttachment> list(UUID materialAssetId) {
        ensureAssetExists(materialAssetId);
        return jdbcTemplate.query("""
                SELECT id, material_asset_id, audit_id, bucket, object_key, original_file_name,
                       content_type, size_bytes, sha256, uploaded_by, notes, created_at
                FROM material_authorization_attachments
                WHERE material_asset_id = :materialAssetId
                ORDER BY created_at DESC
                """, new MapSqlParameterSource("materialAssetId", materialAssetId), this::mapRow);
    }

    @Transactional
    public MaterialAuthorizationAttachment upload(
            UUID materialAssetId,
            UUID auditId,
            String notes,
            MultipartFile file,
            UUID uploadedBy
    ) {
        ensureAssetExists(materialAssetId);
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("file is required");
        }
        var tempFile = createTempFile();
        try {
            var sha256 = copyAndHash(file, tempFile);
            var sizeBytes = Files.size(tempFile);
            var originalFileName = safeFileName(file.getOriginalFilename());
            var contentType = file.getContentType() == null || file.getContentType().isBlank()
                    ? "application/octet-stream"
                    : file.getContentType();
            var objectKey = "authorization/%s/%s-%s%s".formatted(
                    materialAssetId,
                    slug(originalFileName),
                    sha256.substring(0, 16),
                    extension(originalFileName)
            );
            objectStorageService.putObject(objectKey, tempFile, contentType, sizeBytes);
            var id = UUID.randomUUID();
            var now = Instant.now();
            jdbcTemplate.update("""
                    INSERT INTO material_authorization_attachments (
                        id, material_asset_id, audit_id, bucket, object_key, original_file_name,
                        content_type, size_bytes, sha256, uploaded_by, notes, created_at
                    ) VALUES (
                        :id, :materialAssetId, :auditId, :bucket, :objectKey, :originalFileName,
                        :contentType, :sizeBytes, :sha256, :uploadedBy, :notes, :createdAt
                    )
                    """, new MapSqlParameterSource()
                    .addValue("id", id)
                    .addValue("materialAssetId", materialAssetId)
                    .addValue("auditId", auditId)
                    .addValue("bucket", objectStorageService.bucket())
                    .addValue("objectKey", objectKey)
                    .addValue("originalFileName", originalFileName)
                    .addValue("contentType", contentType)
                    .addValue("sizeBytes", sizeBytes)
                    .addValue("sha256", sha256)
                    .addValue("uploadedBy", uploadedBy)
                    .addValue("notes", blankToNull(notes))
                    .addValue("createdAt", Timestamp.from(now)));
            return list(materialAssetId).stream()
                    .filter(attachment -> attachment.id().equals(id))
                    .findFirst()
                    .orElseThrow(() -> new ResourceNotFoundException("Authorization attachment not found: " + id));
        } catch (IOException exception) {
            throw new IllegalStateException("Failed to archive authorization attachment", exception);
        } finally {
            deleteQuietly(tempFile);
        }
    }

    private MaterialAsset ensureAssetExists(UUID id) {
        return materialAssetRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Material asset not found: " + id));
    }

    private MaterialAuthorizationAttachment mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new MaterialAuthorizationAttachment(
                rs.getObject("id", UUID.class),
                rs.getObject("material_asset_id", UUID.class),
                rs.getObject("audit_id", UUID.class),
                rs.getString("bucket"),
                rs.getString("object_key"),
                rs.getString("original_file_name"),
                rs.getString("content_type"),
                rs.getLong("size_bytes"),
                rs.getString("sha256"),
                rs.getObject("uploaded_by", UUID.class),
                rs.getString("notes"),
                rs.getTimestamp("created_at").toInstant()
        );
    }

    private String copyAndHash(MultipartFile file, Path target) throws IOException {
        try {
            var digest = MessageDigest.getInstance("SHA-256");
            try (var input = new DigestInputStream(file.getInputStream(), digest);
                 var output = Files.newOutputStream(target)) {
                input.transferTo(output);
            }
            return HexFormat.of().formatHex(digest.digest());
        } catch (NoSuchAlgorithmException exception) {
            throw new IllegalStateException("SHA-256 is not available", exception);
        }
    }

    private Path createTempFile() {
        try {
            return Files.createTempFile("yanma408-auth-", ".attachment");
        } catch (IOException exception) {
            throw new IllegalStateException("Failed to create temporary attachment file", exception);
        }
    }

    private String safeFileName(String value) {
        return value == null || value.isBlank() ? "authorization.bin" : value.replaceAll("[\\\\/]+", "_").trim();
    }

    private String extension(String fileName) {
        var index = fileName.lastIndexOf('.');
        return index < 0 ? "" : fileName.substring(index).toLowerCase(Locale.ROOT).replaceAll("[^a-z0-9.]", "");
    }

    private String slug(String value) {
        return value.toLowerCase(Locale.ROOT)
                .replaceAll("\\.[^.]+$", "")
                .replaceAll("[^a-z0-9\\u4e00-\\u9fa5]+", "-")
                .replaceAll("^-|-$", "");
    }

    private String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }

    private void deleteQuietly(Path path) {
        try {
            Files.deleteIfExists(path);
        } catch (IOException ignored) {
            // Attachment archival should not fail because temporary cleanup failed.
        }
    }
}
