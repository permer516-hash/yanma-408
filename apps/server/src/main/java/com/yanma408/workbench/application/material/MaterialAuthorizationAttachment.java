package com.yanma408.workbench.application.material;

import java.time.Instant;
import java.util.UUID;

public record MaterialAuthorizationAttachment(
        UUID id,
        UUID materialAssetId,
        UUID auditId,
        String bucket,
        String objectKey,
        String originalFileName,
        String contentType,
        long sizeBytes,
        String sha256,
        UUID uploadedBy,
        String notes,
        Instant createdAt
) {
}
