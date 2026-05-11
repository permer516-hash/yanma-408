package com.yanma408.study.application.notification;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

public interface StudyNotificationRepository {
    int createDueNotifications(LocalDate date, LocalTime now);

    List<StudyNotificationView> findByUser(UUID userId, boolean unreadOnly);

    void markRead(UUID userId, UUID notificationId);

    List<StudyNotificationPreference> findPreferences(UUID userId);

    void savePreference(UUID userId, String channel, boolean enabled, String target);
}
