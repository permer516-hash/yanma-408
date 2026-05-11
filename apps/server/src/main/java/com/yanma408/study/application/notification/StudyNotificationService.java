package com.yanma408.study.application.notification;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Service
public class StudyNotificationService {
    private final StudyNotificationRepository repository;

    public StudyNotificationService(StudyNotificationRepository repository) {
        this.repository = repository;
    }

    @Scheduled(initialDelay = 60_000L, fixedDelay = 60_000L)
    @Transactional
    public void createDueNotifications() {
        repository.createDueNotifications(LocalDate.now(), LocalTime.now());
    }

    @Transactional
    public int createDueNotificationsNow() {
        return repository.createDueNotifications(LocalDate.now(), LocalTime.now());
    }

    public List<StudyNotificationView> findByUser(UUID userId, boolean unreadOnly) {
        return repository.findByUser(userId, unreadOnly);
    }

    @Transactional
    public void markRead(UUID userId, UUID notificationId) {
        repository.markRead(userId, notificationId);
    }

    public List<StudyNotificationPreference> findPreferences(UUID userId) {
        return repository.findPreferences(userId);
    }

    @Transactional
    public void savePreference(UUID userId, String channel, boolean enabled, String target) {
        var normalizedChannel = channel.trim().toUpperCase();
        if (!Set.of("IN_APP", "BROWSER", "EMAIL").contains(normalizedChannel)) {
            throw new IllegalArgumentException("Unsupported notification channel: " + channel);
        }
        repository.savePreference(userId, normalizedChannel, enabled, target);
    }
}
