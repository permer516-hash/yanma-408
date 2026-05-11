package com.yanma408.mistake.application.query;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

public record MistakeSummary(
        UUID id,
        UUID questionId,
        String subjectCode,
        String subjectName,
        String chapterName,
        String type,
        String difficulty,
        String stem,
        String source,
        Integer sourceYear,
        BigDecimal score,
        int wrongCount,
        boolean mastered,
        String reason,
        Instant firstWrongAt,
        Instant latestWrongAt,
        Instant updatedAt,
        List<String> knowledgePoints
) {
}
