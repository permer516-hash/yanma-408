package com.yanma408.user.application.auth;

import java.time.Instant;

public record PasswordResetRequestResult(
        boolean requested,
        String resetToken,
        Instant expiresAt
) {
}
