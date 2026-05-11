package com.yanma408.study.application.task;

import com.yanma408.study.application.query.StudyDashboardView;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public interface StudyTaskRepository {
    List<StudyDashboardView.StudyTaskView> findByDate(UUID userId, LocalDate taskDate);

    List<StudyDashboardView.StudyTaskView> findByRange(UUID userId, LocalDate startDate, LocalDate endDate);

    StudyDashboardView.StudyTaskView create(UUID userId, CreateStudyTaskCommand command);

    StudyDashboardView.StudyTaskView update(UUID userId, UUID taskId, CreateStudyTaskCommand command);

    void updateStatus(UUID userId, UUID taskId, String status);

    void updateOccurrenceStatus(UUID userId, UUID taskId, LocalDate occurrenceDate, String status);

    List<StudyDashboardView.StudyTaskView> findReminders(UUID userId, LocalDate date);

    void delete(UUID userId, UUID taskId);
}
