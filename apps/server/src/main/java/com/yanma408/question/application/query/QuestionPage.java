package com.yanma408.question.application.query;

import java.math.BigDecimal;
import java.util.List;

public record QuestionPage(
        List<QuestionSummary> items,
        int page,
        int size,
        int total,
        int totalPages,
        BigDecimal totalScore
) {
}
