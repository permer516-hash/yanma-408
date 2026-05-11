package com.yanma408.user.application.auth;

import java.time.Instant;
import java.util.UUID;

public record AuthTokenView(
        UUID id,
        Instant createdAt,
        Instant expiresAt,
        Instant lastUsedAt,
        boolean revoked,
        boolean active
) {
}
