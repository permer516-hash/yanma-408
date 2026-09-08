package com.yanma408.comprehensive.application;

import java.math.BigDecimal;
import java.util.List;

public record ComprehensivePartCommand(
        String prompt,
        String responseMode,
        String referenceAnswer,
        String explanation,
        BigDecimal score,
        String imageUrl,
        List<RubricCommand> rubrics
) {
    public record RubricCommand(String criterion, BigDecimal score) {
    }
}
