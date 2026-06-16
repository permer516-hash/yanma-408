package com.yanma408.question.application.feedback;

import java.time.LocalDateTime;
import java.util.UUID;

public record QuestionFeedbackView(
        UUID id,
        UUID questionId,
        String questionStem,
        String subjectCode,
        String subjectName,
        String chapterName,
        UUID reporterUserId,
        String reporterDisplayName,
        String issueType,
        String description,
        String status,
        String adminNote,
        UUID handledByUserId,
        String handledByDisplayName,
        LocalDateTime handledAt,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
}
