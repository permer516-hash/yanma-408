package com.yanma408.user.domain.repository;

import com.yanma408.user.application.auth.AuthAuditView;

import java.util.List;
import java.util.UUID;

public interface AuthAuditRepository {
    void record(UUID userId, String username, String eventType, boolean success, String ipAddress, String userAgent, String details);

    List<AuthAuditView> findByUser(UUID userId, int limit);
}
