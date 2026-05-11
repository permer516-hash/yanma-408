package com.yanma408.exam.application.attempt;

import java.util.List;

public record ExamAttemptComparison(
        ExamAttemptSummary latest,
        ExamAttemptSummary previous,
        int scoreDelta,
        int accuracyDelta,
        List<QuestionComparison> questions
) {
    public record QuestionComparison(
            java.util.UUID questionId,
            int sortOrder,
            String stem,
            boolean latestCorrect,
            boolean previousCorrect,
            String latestAnswer,
            String previousAnswer,
            String correctAnswer
    ) {
    }
}
