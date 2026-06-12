package com.yanma408.workbench.application.material;

public record MaterialCopyrightAuditCommand(
        String sourceName,
        Integer sourceYear,
        String authorizationScope,
        String riskLevel,
        String decision,
        String notes,
        String auditedBy
) {
}
