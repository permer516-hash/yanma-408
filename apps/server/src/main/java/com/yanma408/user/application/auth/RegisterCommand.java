package com.yanma408.user.application.auth;

public record RegisterCommand(
        String username,
        String displayName,
        String password
) {
}
