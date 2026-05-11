package com.yanma408.exam.application.attempt;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;
import java.util.List;
import java.util.UUID;

@Service
public class ExamAttemptService {
    private final ExamAttemptRepository examAttemptRepository;

    public ExamAttemptService(ExamAttemptRepository examAttemptRepository) {
        this.examAttemptRepository = examAttemptRepository;
    }

    @Transactional
    public ExamAttemptView start(UUID userId, UUID examPaperId) {
        return examAttemptRepository.start(userId, examPaperId);
    }

    @Transactional
    public ExamAttemptReport submit(UUID userId, UUID attemptId, Map<UUID, String> answers, int durationSeconds) {
        if (answers == null || answers.isEmpty()) {
            throw new IllegalArgumentException("At least one answer is required");
        }
        if (durationSeconds < 0) {
            throw new IllegalArgumentException("durationSeconds must be greater than or equal to 0");
        }
        return examAttemptRepository.submit(new SubmitExamAttemptCommand(attemptId, userId, answers, durationSeconds));
    }

    public ExamAttemptReport report(UUID userId, UUID attemptId) {
        return examAttemptRepository.findReport(userId, attemptId)
                .orElseThrow(() -> new com.yanma408.shared.exception.ResourceNotFoundException("Exam attempt report not found: " + attemptId));
    }

    public List<ExamAttemptSummary> history(UUID userId, UUID examPaperId) {
        return examAttemptRepository.findSubmittedAttempts(userId, examPaperId);
    }

    public ExamAttemptComparison compareLatest(UUID userId, UUID examPaperId) {
        return examAttemptRepository.compareLatest(userId, examPaperId)
                .orElseThrow(() -> new com.yanma408.shared.exception.ResourceNotFoundException("Not enough exam attempts to compare: " + examPaperId));
    }

    public ExamReportOverview overview(UUID userId) {
        return examAttemptRepository.overview(userId);
    }

    @Transactional
    public BackfillMistakesResult backfillMistakes(UUID userId, UUID attemptId) {
        return new BackfillMistakesResult(examAttemptRepository.backfillMistakes(userId, attemptId));
    }

    public record BackfillMistakesResult(int createdCount) {
    }
}
