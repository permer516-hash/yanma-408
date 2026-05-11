package com.yanma408.user.application.auth;

public record LoginCommand(
        String username,
        String password
) {
}
