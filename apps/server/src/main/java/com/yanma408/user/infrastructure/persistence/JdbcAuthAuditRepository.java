package com.yanma408.user.infrastructure.persistence;

import com.yanma408.user.application.auth.AuthAuditView;
import com.yanma408.user.domain.repository.AuthAuditRepository;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Repository
public class JdbcAuthAuditRepository implements AuthAuditRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;

    public JdbcAuthAuditRepository(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void record(UUID userId, String username, String eventType, boolean success, String ipAddress, String userAgent, String details) {
        jdbcTemplate.update("""
                INSERT INTO auth_audit_logs (
                    id, user_id, username, event_type, success,
                    ip_address, user_agent, details, created_at
                )
                VALUES (
                    :id, :userId, :username, :eventType, :success,
                    :ipAddress, :userAgent, :details, :createdAt
                )
                """, new MapSqlParameterSource()
                .addValue("id", UUID.randomUUID())
                .addValue("userId", userId)
                .addValue("username", username)
                .addValue("eventType", eventType)
                .addValue("success", success)
                .addValue("ipAddress", truncate(ipAddress, 64))
                .addValue("userAgent", truncate(userAgent, 255))
                .addValue("details", truncate(details, 500))
                .addValue("createdAt", Timestamp.from(Instant.now())));
    }

    @Override
    public List<AuthAuditView> findByUser(UUID userId, int limit) {
        return jdbcTemplate.query("""
                SELECT id, user_id, username, event_type, success,
                       ip_address, user_agent, details, created_at
                FROM auth_audit_logs
                WHERE user_id = :userId
                ORDER BY created_at DESC
                LIMIT :limit
                """, new MapSqlParameterSource()
                .addValue("userId", userId)
                .addValue("limit", Math.max(1, Math.min(limit, 100))), (rs, rowNum) -> new AuthAuditView(
                rs.getObject("id", UUID.class),
                rs.getObject("user_id", UUID.class),
                rs.getString("username"),
                rs.getString("event_type"),
                rs.getBoolean("success"),
                rs.getString("ip_address"),
                rs.getString("user_agent"),
                rs.getString("details"),
                rs.getTimestamp("created_at").toInstant()
        ));
    }

    private String truncate(String value, int maxLength) {
        if (value == null) {
            return null;
        }
        return value.length() <= maxLength ? value : value.substring(0, maxLength);
    }
}
