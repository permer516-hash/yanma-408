package com.yanma408.comprehensive.application;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

public record ComprehensiveAttemptView(
        UUID id,
        UUID questionId,
        String mode,
        String status,
        int elapsedSeconds,
        Instant submittedAt,
        Instant finalizedAt,
        List<PartResponseView> responses
) {
    public record PartResponseView(
            UUID partId,
            String content,
            List<String> attachmentUrls,
            BigDecimal latestScore,
            String latestFeedback,
            String latestGraderType
    ) {
    }
}
