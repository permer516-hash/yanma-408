package com.yanma408.study.application.notification;

import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

public record StudyNotificationView(
        UUID id,
        UUID taskId,
        LocalDate notificationDate,
        String channel,
        String title,
        String content,
        boolean read,
        Instant createdAt
) {
}
