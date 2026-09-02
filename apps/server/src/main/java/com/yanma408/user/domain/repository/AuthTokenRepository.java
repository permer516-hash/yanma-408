package com.yanma408.user.domain.repository;

import com.yanma408.user.application.auth.AuthTokenView;

import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface AuthTokenRepository {
    UUID save(UUID userId, String token, Instant expiresAt);

    Optional<UUID> findUserIdByToken(String token);

    void revoke(String token);

    void revokeById(UUID userId, UUID tokenId);

    void revokeAllByUser(UUID userId);

    List<AuthTokenView> findByUser(UUID userId);

    int countActiveByUser(UUID userId);

    int deleteExpired(Instant now);
}
