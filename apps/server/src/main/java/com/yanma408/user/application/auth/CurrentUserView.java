package com.yanma408.user.application.auth;

import java.util.UUID;

public record CurrentUserView(
        UUID id,
        String username,
        String displayName
) {
}
