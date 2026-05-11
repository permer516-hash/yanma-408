package com.yanma408.question.application.query;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

public record QuestionSummary(
        UUID id,
        String subjectCode,
        String subjectName,
        String chapterName,
        String type,
        String difficulty,
        String stem,
        String source,
        Integer sourceYear,
        BigDecimal score,
        String status,
        String reviewStatus,
        String reviewNote,
        String stemFormat,
        String stemImageUrl,
        List<String> tags,
        List<String> knowledgePoints
) {
}
