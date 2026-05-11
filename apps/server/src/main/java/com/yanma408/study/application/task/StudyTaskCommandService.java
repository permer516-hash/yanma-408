package com.yanma408.study.application.task;

import com.yanma408.study.application.query.StudyDashboardView;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Service
public class StudyTaskCommandService {
    private static final Set<String> ALLOWED_STATUSES = Set.of("PENDING", "DONE");
    private static final Set<String> ALLOWED_OCCURRENCE_STATUSES = Set.of("PENDING", "DONE", "SKIPPED");
    private static final Set<String> ALLOWED_TASK_TYPES = Set.of("QUESTION_SET", "WEAK_POINT", "MISTAKE_REVIEW", "CUSTOM");
    private static final Set<String> ALLOWED_PRIORITIES = Set.of("NORMAL", "IMPORTANT", "REVIEW");
    private static final Set<String> ALLOWED_RECURRENCE_RULES = Set.of("NONE", "DAILY", "WEEKLY", "MONTHLY");
    private static final Set<String> ALLOWED_SUBJECTS = Set.of(
            "DATA_STRUCTURE",
            "COMPUTER_ORGANIZATION",
            "OPERATING_SYSTEM",
            "COMPUTER_NETWORK"
    );

    private final StudyTaskRepository studyTaskRepository;

    public StudyTaskCommandService(StudyTaskRepository studyTaskRepository) {
        this.studyTaskRepository = studyTaskRepository;
    }

    public List<StudyDashboardView.StudyTaskView> findByDate(UUID userId, LocalDate taskDate) {
        return studyTaskRepository.findByDate(userId, taskDate == null ? LocalDate.now() : taskDate);
    }

    public List<StudyDashboardView.StudyTaskView> findByRange(UUID userId, LocalDate startDate, LocalDate endDate) {
        var normalizedStart = startDate == null ? LocalDate.now() : startDate;
        var normalizedEnd = endDate == null ? normalizedStart.plusDays(6) : endDate;
        if (normalizedEnd.isBefore(normalizedStart)) {
            throw new IllegalArgumentException("end date must not be before start date");
        }
        if (normalizedStart.plusDays(62).isBefore(normalizedEnd)) {
            throw new IllegalArgumentException("date range cannot exceed 63 days");
        }
        return studyTaskRepository.findByRange(userId, normalizedStart, normalizedEnd);
    }

    @Transactional
    public StudyDashboardView.StudyTaskView create(UUID userId, CreateStudyTaskCommand command) {
        var normalized = normalizeCommand(command);
        return studyTaskRepository.create(userId, normalized);
    }

    @Transactional
    public StudyDashboardView.StudyTaskView update(UUID userId, UUID taskId, CreateStudyTaskCommand command) {
        var normalized = normalizeCommand(command);
        return studyTaskRepository.update(userId, taskId, normalized);
    }

    @Transactional
    public void updateStatus(UUID userId, UUID taskId, String status) {
        var normalizedStatus = normalizeAllowed(status, ALLOWED_STATUSES, "status");
        studyTaskRepository.updateStatus(userId, taskId, normalizedStatus);
    }

    @Transactional
    public void updateOccurrenceStatus(UUID userId, UUID taskId, LocalDate occurrenceDate, String status) {
        var normalizedStatus = normalizeAllowed(status, ALLOWED_OCCURRENCE_STATUSES, "status");
        studyTaskRepository.updateOccurrenceStatus(
                userId,
                taskId,
                occurrenceDate == null ? LocalDate.now() : occurrenceDate,
                normalizedStatus
        );
    }

    public List<StudyDashboardView.StudyTaskView> reminders(UUID userId, LocalDate date) {
        return studyTaskRepository.findReminders(userId, date == null ? LocalDate.now() : date);
    }

    @Transactional
    public void delete(UUID userId, UUID taskId) {
        studyTaskRepository.delete(userId, taskId);
    }

    private CreateStudyTaskCommand normalizeCommand(CreateStudyTaskCommand command) {
        var subjectCode = normalizeAllowed(command.subjectCode(), ALLOWED_SUBJECTS, "subjectCode");
        var taskType = normalizeAllowed(command.taskType(), ALLOWED_TASK_TYPES, "taskType");
        var priority = normalizeAllowed(command.priority(), ALLOWED_PRIORITIES, "priority");
        var recurrenceRule = command.recurrenceRule() == null || command.recurrenceRule().isBlank()
                ? "NONE"
                : normalizeAllowed(command.recurrenceRule(), ALLOWED_RECURRENCE_RULES, "recurrenceRule");
        return new CreateStudyTaskCommand(
                command.title().trim(),
                subjectCode,
                taskType,
                command.targetCount(),
                command.estimatedMinutes(),
                priority,
                command.taskDate() == null ? LocalDate.now() : command.taskDate(),
                recurrenceRule,
                command.reminderTime()
        );
    }

    private String normalizeAllowed(String value, Set<String> allowedValues, String fieldName) {
        var normalized = value.trim().toUpperCase();
        if (!allowedValues.contains(normalized)) {
            throw new IllegalArgumentException("Unsupported " + fieldName + ": " + value);
        }
        return normalized;
    }
}
