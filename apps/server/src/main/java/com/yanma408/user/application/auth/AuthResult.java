package com.yanma408.user.application.auth;

import java.time.Instant;
import java.util.UUID;

public record AuthResult(
        UUID userId,
        String username,
        String displayName,
        String token,
        Instant expiresAt
) {
}
