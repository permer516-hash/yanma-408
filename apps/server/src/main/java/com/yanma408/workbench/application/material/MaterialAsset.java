package com.yanma408.workbench.application.material;

import java.time.Instant;
import java.util.UUID;

public record MaterialAsset(
        UUID id,
        String title,
        String subjectCode,
        String sourceType,
        Integer sourceYear,
        String bucket,
        String objectKey,
        String originalFileName,
        String contentType,
        long sizeBytes,
        String sha256,
        String status,
        String notes,
        Instant createdAt,
        Instant updatedAt
) {
}
