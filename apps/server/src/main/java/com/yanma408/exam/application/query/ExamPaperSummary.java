package com.yanma408.exam.application.query;

import java.util.UUID;

public record ExamPaperSummary(
        UUID id,
        String title,
        String paperType,
        Integer sourceYear,
        int durationMinutes,
        int totalScore,
        int questionCount
) {
}
