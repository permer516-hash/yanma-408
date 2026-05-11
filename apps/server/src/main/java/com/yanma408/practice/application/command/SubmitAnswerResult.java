package com.yanma408.practice.application.command;

import java.time.Instant;
import java.util.UUID;

public record SubmitAnswerResult(
        UUID attemptId,
        UUID questionId,
        String submittedAnswer,
        String correctAnswer,
        boolean correct,
        boolean enteredMistakeBook,
        int wrongCount,
        String explanation,
        Instant submittedAt
) {
}
