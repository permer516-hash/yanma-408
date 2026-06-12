package com.yanma408.teacher.application;

import java.time.Instant;
import java.util.UUID;

public record StudentLearningSummary(
        UUID id,
        String username,
        String displayName,
        Instant createdAt,
        int attemptCount,
        int correctCount,
        int accuracyPercent,
        int mistakeCount,
        int pendingMistakeCount,
        int masteredMistakeCount,
        int examAttemptCount,
        int latestExamAccuracyPercent,
        Instant latestActivityAt
) {
}
