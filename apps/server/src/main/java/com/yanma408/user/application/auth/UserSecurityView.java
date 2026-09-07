package com.yanma408.user.application.auth;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

public record UserSecurityView(
        UUID id,
        String username,
        String displayName,
        List<String> roles,
        boolean enabled,
        Instant createdAt,
        int activeTokenCount
) {
}
