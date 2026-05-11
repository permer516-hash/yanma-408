package com.yanma408.study.application.query;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

public record StudyDashboardView(
        TodayGoalView todayGoal,
        ContinuousStudyView continuousStudy,
        WeeklyAccuracyView weeklyAccuracy,
        List<SubjectMasteryView> subjectMasteries,
        List<StudyTaskView> todayTasks,
        List<WeakKnowledgePointView> weakKnowledgePoints
) {
    public record TodayGoalView(
            int completedCount,
            int targetCount
    ) {
    }

    public record WeeklyAccuracyView(
            int percent,
            int deltaPercent,
            int attemptCount
    ) {
    }

    public record ContinuousStudyView(
            int days
    ) {
    }

    public record SubjectMasteryView(
            String subjectCode,
            String subjectName,
            int practicedCount,
            int correctCount,
            int masteryPercent,
            String weakestKnowledgePoint
    ) {
    }

    public record WeakKnowledgePointView(
            UUID id,
            String code,
            String name,
            String subjectCode,
            String subjectName,
            String chapterName,
            int mistakeCount,
            int wrongCount,
            int pendingMistakeCount,
            Instant latestWrongAt
    ) {
    }

    public record StudyTaskView(
            UUID id,
            String title,
            String subjectCode,
            String taskType,
            int targetCount,
            int estimatedMinutes,
            String status,
            String priority,
            LocalDate taskDate,
            String recurrenceRule,
            LocalTime reminderTime
    ) {
    }
}
