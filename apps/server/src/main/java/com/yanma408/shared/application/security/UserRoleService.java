package com.yanma408.shared.application.security;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;
import java.util.UUID;

@Service
public class UserRoleService {
    private final NamedParameterJdbcTemplate jdbcTemplate;

    public UserRoleService(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<String> roles(UUID userId) {
        return jdbcTemplate.queryForList("""
                SELECT role
                FROM app_user_roles
                WHERE user_id = :userId
                ORDER BY role
                """, new MapSqlParameterSource("userId", userId), String.class);
    }

    public void grant(UUID userId, String role) {
        if (!roles(userId).contains(role)) {
            jdbcTemplate.update("""
                    INSERT INTO app_user_roles (user_id, role, created_at)
                    VALUES (:userId, :role, CURRENT_TIMESTAMP)
                    """, new MapSqlParameterSource()
                    .addValue("userId", userId)
                    .addValue("role", role));
        }
    }

    public void requireAny(UUID userId, String... requiredRoles) {
        var currentRoles = Set.copyOf(roles(userId));
        for (String role : requiredRoles) {
            if (currentRoles.contains(role)) {
                return;
            }
        }
        throw new AccessDeniedException("Required role: " + String.join(" or ", requiredRoles));
    }
}
