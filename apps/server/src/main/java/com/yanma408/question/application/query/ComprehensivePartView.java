package com.yanma408.question.application.query;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

public record ComprehensivePartView(
        UUID id,
        int sortOrder,
        String prompt,
        String responseMode,
        String referenceAnswer,
        String explanation,
        BigDecimal score,
        String imageUrl,
        List<RubricView> rubrics
) {
    public record RubricView(UUID id, int sortOrder, String criterion, BigDecimal score) {
    }
}
