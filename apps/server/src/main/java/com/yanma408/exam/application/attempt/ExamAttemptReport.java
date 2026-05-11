package com.yanma408.exam.application.attempt;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

public record ExamAttemptReport(
        UUID id,
        UUID examPaperId,
        String paperTitle,
        String status,
        Instant startedAt,
        Instant submittedAt,
        int durationSeconds,
        BigDecimal totalScore,
        BigDecimal scoredPoints,
        int correctCount,
        int questionCount,
        int accuracyPercent,
        List<QuestionResult> results
) {
    public record QuestionResult(
            UUID questionId,
            int sortOrder,
            String stem,
            String submittedAnswer,
            String correctAnswer,
            boolean correct,
            BigDecimal score,
            BigDecimal earnedScore,
            String explanation
    ) {
    }
}
