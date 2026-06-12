package com.yanma408.workbench.application.content;

import java.time.Instant;
import java.util.UUID;

public record MaterialExtractionCandidate(
        UUID id,
        UUID materialAssetId,
        int pageNumber,
        String extractionMethod,
        String status,
        String rawText,
        String suggestedStem,
        String ocrText,
        String correctedStem,
        String correctedAnswer,
        String correctedExplanation,
        String correctedOptions,
        String correctedQuestionType,
        String failureReason,
        double confidence,
        Instant createdAt
) {
}
