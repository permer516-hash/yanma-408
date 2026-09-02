package com.yanma408.user.domain.repository;

import com.yanma408.user.domain.model.UserAccount;

import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UserAccountRepository {
    boolean existsByUsername(String username);

    Optional<UserAccount> findByUsername(String username);

    Optional<UserAccount> findById(UUID id);

    List<UserAccount> findAll();

    void save(UserAccount user);

    void savePasswordResetToken(UUID userId, String tokenHash, Instant expiresAt);

    Optional<UserAccount> findByPasswordResetTokenHash(String tokenHash);

    void updatePassword(UUID userId, String passwordHash);

    void updateEnabled(UUID userId, boolean enabled);
}
