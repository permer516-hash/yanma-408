package com.yanma408.teacher.application;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

public record TeacherTaskAssignmentView(
        UUID id,
        UUID classId,
        UUID teacherId,
        String title,
        String subjectCode,
        String taskType,
        int targetCount,
        int estimatedMinutes,
        String priority,
        LocalDate taskDate,
        String recurrenceRule,
        LocalTime reminderTime,
        int assignedCount,
        Instant createdAt
) {
}
