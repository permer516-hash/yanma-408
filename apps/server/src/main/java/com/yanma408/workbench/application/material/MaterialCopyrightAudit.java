package com.yanma408.workbench.application.material;

import java.time.Instant;
import java.util.UUID;

public record MaterialCopyrightAudit(
        UUID id,
        UUID materialAssetId,
        String sourceName,
        Integer sourceYear,
        String authorizationScope,
        String riskLevel,
        String decision,
        String notes,
        String auditedBy,
        Instant auditedAt
) {
}
