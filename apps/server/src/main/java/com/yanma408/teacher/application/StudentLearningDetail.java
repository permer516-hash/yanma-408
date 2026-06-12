package com.yanma408.teacher.application;

import com.yanma408.mistake.application.query.MistakeSummary;
import com.yanma408.study.application.query.StudyDashboardView;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

public record StudentLearningDetail(
        StudentLearningSummary summary,
        StudyDashboardView dashboard,
        List<MistakeSummary> recentMistakes,
        List<PracticeAttemptItem> practiceAttempts,
        List<ExamAttemptItem> examAttempts,
        List<StudyDashboardView.WeakKnowledgePointView> weakKnowledgePoints
) {
    public record PracticeAttemptItem(
            UUID id,
            UUID questionId,
            String subjectCode,
            String subjectName,
            String chapterName,
            String stem,
            String submittedAnswer,
            String correctAnswer,
            boolean correct,
            int elapsedSeconds,
            Instant submittedAt
    ) {
    }

    public record ExamAttemptItem(
            UUID id,
            UUID examPaperId,
            String paperTitle,
            String paperType,
            Integer sourceYear,
            Instant submittedAt,
            int durationSeconds,
            BigDecimal totalScore,
            BigDecimal scoredPoints,
            int correctCount,
            int questionCount,
            int accuracyPercent
    ) {
    }
}
