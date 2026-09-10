package com.yanma408.question.application.importrecord;

import java.util.List;

public record QuestionImportBatchPage(
        List<QuestionImportBatchSummary> items,
        int page,
        int size,
        int total,
        int totalPages
) {
}
