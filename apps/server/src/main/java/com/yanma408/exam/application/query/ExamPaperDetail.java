package com.yanma408.exam.application.query;

import com.yanma408.question.application.query.QuestionDetail;

import java.util.List;
import java.util.UUID;

public record ExamPaperDetail(
        UUID id,
        String title,
        String paperType,
        Integer sourceYear,
        int durationMinutes,
        int totalScore,
        int questionCount,
        List<QuestionDetail> questions
) {
}
