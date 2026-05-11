package com.yanma408.practice.application.command;

import java.time.Duration;
import java.util.UUID;

public record SubmitAnswerCommand(
        UUID userId,
        UUID questionId,
        String submittedAnswer,
        Duration elapsed
) {
}
