package com.yanma408.user.application.auth;

import org.springframework.stereotype.Component;

import java.time.Duration;
import java.time.Instant;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class RegistrationRateLimiter {
    private static final Duration WINDOW = Duration.ofHours(1);
    private static final int MAX_REGISTRATIONS_PER_WINDOW = 5;
    private static final int MAX_TRACKED_ADDRESSES = 10_000;

    private final Map<String, AttemptWindow> attempts = new ConcurrentHashMap<>();

    public void check(String ipAddress) {
        var now = Instant.now();
        var address = ipAddress == null || ipAddress.isBlank() ? "unknown" : ipAddress.trim();
        evictExpired(now);
        if (!attempts.containsKey(address) && attempts.size() >= MAX_TRACKED_ADDRESSES) {
            throw new RegistrationRateLimitExceededException();
        }
        attempts.compute(address, (ignored, current) -> {
            var window = current == null || current.startedAt().plus(WINDOW).isBefore(now)
                    ? new AttemptWindow(0, now)
                    : current;
            if (window.count() >= MAX_REGISTRATIONS_PER_WINDOW) {
                throw new RegistrationRateLimitExceededException();
            }
            return new AttemptWindow(window.count() + 1, window.startedAt());
        });
    }

    private void evictExpired(Instant now) {
        attempts.entrySet().removeIf(entry -> entry.getValue().startedAt().plus(WINDOW).isBefore(now));
    }

    private record AttemptWindow(int count, Instant startedAt) {
    }
}
