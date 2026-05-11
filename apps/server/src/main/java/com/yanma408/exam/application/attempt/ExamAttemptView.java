package com.yanma408.exam.application.attempt;

import com.yanma408.exam.application.query.ExamPaperDetail;

import java.time.Instant;
import java.util.UUID;

public record ExamAttemptView(
        UUID id,
        UUID examPaperId,
        String status,
        Instant startedAt,
        Instant expiresAt,
        ExamPaperDetail paper
) {
}
