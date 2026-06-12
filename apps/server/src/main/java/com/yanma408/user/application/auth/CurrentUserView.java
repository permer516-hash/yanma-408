package com.yanma408.user.application.auth;

import java.util.UUID;
import java.util.List;

public record CurrentUserView(
        UUID id,
        String username,
        String displayName,
        List<String> roles
) {
}
