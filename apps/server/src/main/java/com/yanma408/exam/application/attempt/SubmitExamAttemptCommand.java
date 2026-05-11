package com.yanma408.exam.application.attempt;

import java.util.Map;
import java.util.UUID;

public record SubmitExamAttemptCommand(
        UUID attemptId,
        UUID userId,
        Map<UUID, String> answers,
        int durationSeconds
) {
}
