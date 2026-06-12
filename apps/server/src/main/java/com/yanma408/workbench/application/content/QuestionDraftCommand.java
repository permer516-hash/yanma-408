package com.yanma408.workbench.application.content;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

public record QuestionDraftCommand(
        UUID materialAssetId,
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
        List<String> tags,
        List<PageReferenceCommand> pageReferences,
        String createdBy
) {
    public record OptionCommand(String label, String content) {
    }

    public record PageReferenceCommand(
            UUID materialAssetId,
            UUID extractionCandidateId,
            Integer pageNumber,
            String quote,
            String referenceNote
    ) {
    }
}
