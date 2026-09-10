package com.yanma408.question.application.importrecord;

import java.time.Instant;
import java.util.UUID;

public record QuestionImportBatchSummary(
        UUID id,
        String importMode,
        int questionCount,
        String operatorUsername,
        String operatorDisplayName,
        Instant createdAt
) {
}
