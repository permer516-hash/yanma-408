package com.yanma408.user.infrastructure.persistence;

import com.yanma408.user.application.auth.AuthTokenView;
import com.yanma408.user.domain.repository.AuthTokenRepository;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public class JdbcAuthTokenRepository implements AuthTokenRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;

    public JdbcAuthTokenRepository(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public UUID save(UUID userId, String token, Instant expiresAt) {
        var sql = """
                INSERT INTO auth_tokens (id, user_id, token_hash, expires_at, created_at, last_used_at)
                VALUES (:id, :userId, :tokenHash, :expiresAt, :createdAt, :lastUsedAt)
                """;
        var now = Instant.now();
        var id = UUID.randomUUID();
        var params = new MapSqlParameterSource()
                .addValue("id", id)
                .addValue("userId", userId)
                .addValue("tokenHash", TokenHash.sha256(token))
                .addValue("expiresAt", Timestamp.from(expiresAt))
                .addValue("createdAt", Timestamp.from(now))
                .addValue("lastUsedAt", Timestamp.from(now));
        jdbcTemplate.update(sql, params);
        return id;
    }

    @Override
    public Optional<UUID> findUserIdByToken(String token) {
        var sql = """
                SELECT user_id
                FROM auth_tokens
                WHERE token_hash = :tokenHash
                  AND expires_at > CURRENT_TIMESTAMP
                  AND revoked_at IS NULL
                """;
        var params = new MapSqlParameterSource("tokenHash", TokenHash.sha256(token));
        var userId = jdbcTemplate.query(sql, params, (rs, rowNum) -> rs.getObject("user_id", UUID.class))
                .stream()
                .findFirst();
        userId.ifPresent(ignored -> jdbcTemplate.update("""
                UPDATE auth_tokens
                SET last_used_at = CURRENT_TIMESTAMP
                WHERE token_hash = :tokenHash
                """, params));
        return userId;
    }

    @Override
    public void revoke(String token) {
        jdbcTemplate.update("""
                UPDATE auth_tokens
                SET expires_at = CURRENT_TIMESTAMP,
                    revoked_at = CURRENT_TIMESTAMP
                WHERE token_hash = :tokenHash
                """, new MapSqlParameterSource("tokenHash", TokenHash.sha256(token)));
    }

    @Override
    public void revokeById(UUID userId, UUID tokenId) {
        jdbcTemplate.update("""
                UPDATE auth_tokens
                SET expires_at = CURRENT_TIMESTAMP,
                    revoked_at = CURRENT_TIMESTAMP
                WHERE id = :tokenId
                  AND user_id = :userId
                """, new MapSqlParameterSource()
                .addValue("tokenId", tokenId)
                .addValue("userId", userId));
    }

    @Override
    public void revokeAllByUser(UUID userId) {
        jdbcTemplate.update("""
                UPDATE auth_tokens
                SET expires_at = CURRENT_TIMESTAMP,
                    revoked_at = CURRENT_TIMESTAMP
                WHERE user_id = :userId
                  AND revoked_at IS NULL
                """, new MapSqlParameterSource("userId", userId));
    }

    @Override
    public List<AuthTokenView> findByUser(UUID userId) {
        return jdbcTemplate.query("""
                SELECT id, created_at, expires_at, last_used_at, revoked_at,
                       CASE WHEN expires_at > CURRENT_TIMESTAMP AND revoked_at IS NULL THEN TRUE ELSE FALSE END AS active
                FROM auth_tokens
                WHERE user_id = :userId
                ORDER BY created_at DESC
                LIMIT 20
                """, new MapSqlParameterSource("userId", userId), (rs, rowNum) -> new AuthTokenView(
                rs.getObject("id", UUID.class),
                rs.getTimestamp("created_at").toInstant(),
                rs.getTimestamp("expires_at").toInstant(),
                rs.getTimestamp("last_used_at") == null ? null : rs.getTimestamp("last_used_at").toInstant(),
                rs.getTimestamp("revoked_at") != null,
                rs.getBoolean("active")
        ));
    }

    @Override
    public int countActiveByUser(UUID userId) {
        var count = jdbcTemplate.queryForObject("""
                SELECT COUNT(*)
                FROM auth_tokens
                WHERE user_id = :userId
                  AND expires_at > CURRENT_TIMESTAMP
                  AND revoked_at IS NULL
                """, new MapSqlParameterSource("userId", userId), Integer.class);
        return count == null ? 0 : count;
    }

    @Override
    public int deleteExpired(Instant now) {
        return jdbcTemplate.update("""
                DELETE FROM auth_tokens
                WHERE expires_at <= :now
                """, new MapSqlParameterSource("now", Timestamp.from(now)));
    }
}
