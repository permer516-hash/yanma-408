package com.yanma408.comprehensive.application;

import com.yanma408.question.application.query.QuestionDetail;

import java.time.Instant;
import java.util.UUID;

public record ComprehensiveGradingQueueItemView(
        UUID attemptId,
        UUID studentId,
        String studentUsername,
        String studentDisplayName,
        Instant submittedAt,
        ComprehensiveAttemptView attempt,
        QuestionDetail question
) {
}
