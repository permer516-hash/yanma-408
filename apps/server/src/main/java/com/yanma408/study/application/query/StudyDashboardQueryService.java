package com.yanma408.study.application.query;

import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class StudyDashboardQueryService {
    private static final int DEFAULT_WEAK_POINT_LIMIT = 4;
    private static final int DAILY_TARGET_COUNT = 60;

    private final StudyDashboardRepository studyDashboardRepository;

    public StudyDashboardQueryService(StudyDashboardRepository studyDashboardRepository) {
        this.studyDashboardRepository = studyDashboardRepository;
    }

    public StudyDashboardView findDashboard(UUID userId) {
        return new StudyDashboardView(
                studyDashboardRepository.findTodayGoal(userId, DAILY_TARGET_COUNT),
                studyDashboardRepository.findContinuousStudy(userId),
                studyDashboardRepository.findWeeklyAccuracy(userId),
                studyDashboardRepository.findSubjectMasteries(userId),
                studyDashboardRepository.findTodayTasks(userId),
                studyDashboardRepository.findWeakKnowledgePoints(userId, DEFAULT_WEAK_POINT_LIMIT)
        );
    }
}
