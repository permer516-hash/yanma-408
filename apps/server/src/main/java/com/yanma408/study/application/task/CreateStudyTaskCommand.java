package com.yanma408.study.application.task;

import java.time.LocalDate;
import java.time.LocalTime;

public record CreateStudyTaskCommand(
        String title,
        String subjectCode,
        String taskType,
        int targetCount,
        int estimatedMinutes,
        String priority,
        LocalDate taskDate,
        String recurrenceRule,
        LocalTime reminderTime
) {
}
