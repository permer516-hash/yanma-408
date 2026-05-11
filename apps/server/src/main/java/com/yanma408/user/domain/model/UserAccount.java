package com.yanma408.user.domain.model;

import java.time.Instant;
import java.util.UUID;

public record UserAccount(
        UUID id,
        String username,
        String displayName,
        String passwordHash,
        Instant createdAt,
        Instant updatedAt
) {
}
