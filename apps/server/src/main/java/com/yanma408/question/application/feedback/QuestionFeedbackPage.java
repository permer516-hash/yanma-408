package com.yanma408.question.application.feedback;

import java.util.List;

public record QuestionFeedbackPage(
        List<QuestionFeedbackView> items,
        int page,
        int size,
        int total,
        int totalPages
) {
}
