package com.yanma408.study.application.query;

import java.util.List;
import java.util.UUID;

public interface StudyDashboardRepository {
    StudyDashboardView.TodayGoalView findTodayGoal(UUID userId, int targetCount);

    StudyDashboardView.ContinuousStudyView findContinuousStudy(UUID userId);

    StudyDashboardView.WeeklyAccuracyView findWeeklyAccuracy(UUID userId);

    List<StudyDashboardView.SubjectMasteryView> findSubjectMasteries(UUID userId);

    List<StudyDashboardView.StudyTaskView> findTodayTasks(UUID userId);

    List<StudyDashboardView.WeakKnowledgePointView> findWeakKnowledgePoints(UUID userId, int limit);
}
