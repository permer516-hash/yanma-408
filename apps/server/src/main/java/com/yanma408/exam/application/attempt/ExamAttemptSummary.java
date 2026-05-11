package com.yanma408.exam.application.attempt;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

public record ExamAttemptSummary(
        UUID id,
        UUID examPaperId,
        String paperTitle,
        Instant submittedAt,
        int durationSeconds,
        BigDecimal totalScore,
        BigDecimal scoredPoints,
        int correctCount,
        int questionCount,
        int accuracyPercent
) {
}
