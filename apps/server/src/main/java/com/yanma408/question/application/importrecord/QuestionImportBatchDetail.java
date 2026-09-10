package com.yanma408.question.application.importrecord;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

public record QuestionImportBatchDetail(
        UUID id,
        String importMode,
        int questionCount,
        String operatorUsername,
        String operatorDisplayName,
        Instant createdAt,
        List<QuestionImportBatchItem> items
) {
}
