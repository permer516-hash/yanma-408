package com.yanma408.exam.application.attempt;

import java.util.Optional;
import java.util.List;
import java.util.UUID;

public interface ExamAttemptRepository {

    ExamAttemptView start(UUID userId, UUID examPaperId);

    ExamAttemptReport submit(SubmitExamAttemptCommand command);

    Optional<ExamAttemptReport> findReport(UUID userId, UUID attemptId);

    List<ExamAttemptSummary> findSubmittedAttempts(UUID userId, UUID examPaperId);

    Optional<ExamAttemptComparison> compareLatest(UUID userId, UUID examPaperId);

    ExamReportOverview overview(UUID userId);

    int backfillMistakes(UUID userId, UUID attemptId);
}
