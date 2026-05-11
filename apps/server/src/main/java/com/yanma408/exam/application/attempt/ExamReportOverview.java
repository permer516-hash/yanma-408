package com.yanma408.exam.application.attempt;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

public record ExamReportOverview(
        int attemptCount,
        int averageAccuracyPercent,
        BigDecimal bestScore,
        int latestAccuracyPercent,
        int totalDurationSeconds,
        List<TrendPoint> trend,
        List<WeakQuestion> weakQuestions
) {
    public record TrendPoint(
            UUID attemptId,
            UUID examPaperId,
            String paperTitle,
            String submittedAt,
            BigDecimal scoredPoints,
            int accuracyPercent
    ) {
    }

    public record WeakQuestion(
            UUID questionId,
            String stem,
            int wrongCount,
            String latestWrongAnswer,
            String correctAnswer
    ) {
    }
}
