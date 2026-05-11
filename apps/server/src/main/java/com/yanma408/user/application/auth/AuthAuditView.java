package com.yanma408.user.application.auth;

import java.time.Instant;
import java.util.UUID;

public record AuthAuditView(
        UUID id,
        UUID userId,
        String username,
        String eventType,
        boolean success,
        String ipAddress,
        String userAgent,
        String details,
        Instant createdAt
) {
}
