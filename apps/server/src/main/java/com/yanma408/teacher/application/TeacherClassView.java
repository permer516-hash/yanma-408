package com.yanma408.teacher.application;

import java.time.Instant;
import java.util.UUID;

public record TeacherClassView(
        UUID id,
        UUID teacherId,
        String teacherUsername,
        String teacherDisplayName,
        String name,
        String courseName,
        String description,
        String status,
        int studentCount,
        Instant createdAt,
        Instant updatedAt
) {
}
