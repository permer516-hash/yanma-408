package com.yanma408.shared.infrastructure.security;

import com.yanma408.shared.application.security.CurrentUserProvider;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
public class SpringSecurityCurrentUserProvider implements CurrentUserProvider {
    @Override
    public UUID currentUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            throw new AuthenticationCredentialsNotFoundException("Authentication is required");
        }
        try {
            return UUID.fromString(authentication.getName());
        } catch (IllegalArgumentException ignored) {
            throw new AuthenticationCredentialsNotFoundException("Authentication user id is invalid");
        }
    }
}
