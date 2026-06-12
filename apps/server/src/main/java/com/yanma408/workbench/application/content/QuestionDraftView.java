package com.yanma408.workbench.application.content;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

public record QuestionDraftView(
        UUID id,
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
        String fingerprint,
        String status,
        String reviewStatus,
        String reviewNote,
        UUID publishedQuestionId,
        List<OptionView> options,
        List<String> knowledgePointCodes,
        List<String> tags,
        List<PageReferenceView> pageReferences,
        Instant createdAt,
        Instant updatedAt,
        Instant reviewedAt,
        Instant publishedAt
) {
    public record OptionView(String label, String content) {
    }

    public record PageReferenceView(
            UUID id,
            UUID materialAssetId,
            UUID extractionCandidateId,
            Integer pageNumber,
            String quote,
            String referenceNote
    ) {
    }
}
