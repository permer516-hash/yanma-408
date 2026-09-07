package com.yanma408.user.infrastructure.persistence;

import com.yanma408.user.domain.model.UserAccount;
import com.yanma408.user.domain.repository.UserAccountRepository;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public class JdbcUserAccountRepository implements UserAccountRepository {
    private final NamedParameterJdbcTemplate jdbcTemplate;

    public JdbcUserAccountRepository(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public boolean existsByUsername(String username) {
        var sql = "SELECT COUNT(*) FROM app_users WHERE username = :username";
        var count = jdbcTemplate.queryForObject(sql, new MapSqlParameterSource("username", username), Integer.class);
        return count != null && count > 0;
    }

    @Override
    public Optional<UserAccount> findByUsername(String username) {
        var sql = """
                SELECT id, username, display_name, password_hash, enabled, created_at, updated_at
                FROM app_users
                WHERE username = :username
                """;
        return jdbcTemplate.query(sql, new MapSqlParameterSource("username", username), (rs, rowNum) -> toUser(rs))
                .stream()
                .findFirst();
    }

    @Override
    public Optional<UserAccount> findById(UUID id) {
        var sql = """
                SELECT id, username, display_name, password_hash, enabled, created_at, updated_at
                FROM app_users
                WHERE id = :id
                """;
        return jdbcTemplate.query(sql, new MapSqlParameterSource("id", id), (rs, rowNum) -> toUser(rs))
                .stream()
                .findFirst();
    }

    @Override
    public List<UserAccount> findAll() {
        return jdbcTemplate.query("""
                SELECT id, username, display_name, password_hash, enabled, created_at, updated_at
                FROM app_users
                ORDER BY created_at DESC, username ASC
                """, new MapSqlParameterSource(), (rs, rowNum) -> toUser(rs));
    }

    @Override
    public void save(UserAccount user) {
        var sql = """
                INSERT INTO app_users (id, username, display_name, password_hash, enabled, created_at, updated_at)
                VALUES (:id, :username, :displayName, :passwordHash, :enabled, :createdAt, :updatedAt)
                """;
        var params = new MapSqlParameterSource()
                .addValue("id", user.id())
                .addValue("username", user.username())
                .addValue("displayName", user.displayName())
                .addValue("passwordHash", user.passwordHash())
                .addValue("enabled", user.enabled())
                .addValue("createdAt", Timestamp.from(user.createdAt()))
                .addValue("updatedAt", Timestamp.from(user.updatedAt()));
        jdbcTemplate.update(sql, params);
    }

    @Override
    public void savePasswordResetToken(UUID userId, String tokenHash, Instant expiresAt) {
        jdbcTemplate.update("""
                UPDATE app_users
                SET password_reset_token_hash = :tokenHash,
                    password_reset_expires_at = :expiresAt,
                    updated_at = CURRENT_TIMESTAMP
                WHERE id = :userId
                """, new MapSqlParameterSource()
                .addValue("userId", userId)
                .addValue("tokenHash", tokenHash)
                .addValue("expiresAt", Timestamp.from(expiresAt)));
    }

    @Override
    public Optional<UserAccount> findByPasswordResetTokenHash(String tokenHash) {
        var sql = """
                SELECT id, username, display_name, password_hash, enabled, created_at, updated_at
                FROM app_users
                WHERE password_reset_token_hash = :tokenHash
                  AND password_reset_expires_at > CURRENT_TIMESTAMP
                """;
        return jdbcTemplate.query(sql, new MapSqlParameterSource("tokenHash", tokenHash), (rs, rowNum) -> toUser(rs))
                .stream()
                .findFirst();
    }

    @Override
    public void updatePassword(UUID userId, String passwordHash) {
        jdbcTemplate.update("""
                UPDATE app_users
                SET password_hash = :passwordHash,
                    password_reset_token_hash = null,
                    password_reset_expires_at = null,
                    updated_at = CURRENT_TIMESTAMP
                WHERE id = :userId
                """, new MapSqlParameterSource()
                .addValue("userId", userId)
                .addValue("passwordHash", passwordHash));
    }

    @Override
    public void updateEnabled(UUID userId, boolean enabled) {
        jdbcTemplate.update("""
                UPDATE app_users
                SET enabled = :enabled,
                    updated_at = CURRENT_TIMESTAMP
                WHERE id = :userId
                """, new MapSqlParameterSource()
                .addValue("userId", userId)
                .addValue("enabled", enabled));
    }

    private UserAccount toUser(ResultSet rs) throws SQLException {
        return new UserAccount(
                rs.getObject("id", UUID.class),
                rs.getString("username"),
                rs.getString("display_name"),
                rs.getString("password_hash"),
                rs.getBoolean("enabled"),
                rs.getTimestamp("created_at").toInstant(),
                rs.getTimestamp("updated_at").toInstant()
        );
    }
}
