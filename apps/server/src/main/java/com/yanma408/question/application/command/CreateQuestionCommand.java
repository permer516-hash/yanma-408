package com.yanma408.question.application.command;

import java.math.BigDecimal;
import java.util.List;

public record CreateQuestionCommand(
        String subjectCode,
        String chapterCode,
        String type,
        String difficulty,
        String stem,
        String answer,
        String explanation,
        String source,
        Integer sourceYear,
        BigDecimal score,
        String stemFormat,
        String stemImageUrl,
        List<OptionCommand> options,
        List<String> knowledgePointCodes,
        List<String> tags
) {
    public record OptionCommand(
            String label,
            String content
    ) {
    }
}
