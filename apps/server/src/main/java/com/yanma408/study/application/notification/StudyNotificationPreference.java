package com.yanma408.study.application.notification;

import java.time.Instant;

public record StudyNotificationPreference(
        String channel,
        boolean enabled,
        String target,
        Instant updatedAt
) {
}
