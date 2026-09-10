package com.yanma408.question.application.importrecord;

import java.util.UUID;

public record QuestionImportBatchItem(
        UUID questionId,
        String subjectCode,
        String subjectName,
        String chapterName,
        String type,
        String difficulty,
        String source,
        String stem
) {
}
