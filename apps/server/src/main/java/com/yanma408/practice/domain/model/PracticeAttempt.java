package com.yanma408.practice.domain.model;

import java.time.Duration;
import java.time.Instant;
import java.util.Objects;
import java.util.UUID;

public class PracticeAttempt {
    private final UUID id;
    private final UUID userId;
    private final UUID questionId;
    private final String submittedAnswer;
    private final String correctAnswer;
    private final boolean correct;
    private final Duration elapsed;
    private final Instant submittedAt;

    public PracticeAttempt(
            UUID id,
            UUID userId,
            UUID questionId,
            String submittedAnswer,
            String correctAnswer,
            boolean correct,
            Duration elapsed,
            Instant submittedAt
    ) {
        this.id = Objects.requireNonNull(id);
        this.userId = Objects.requireNonNull(userId);
        this.questionId = Objects.requireNonNull(questionId);
        this.submittedAnswer = Objects.requireNonNull(submittedAnswer);
        this.correctAnswer = Objects.requireNonNull(correctAnswer);
        this.correct = correct;
        this.elapsed = Objects.requireNonNull(elapsed);
        this.submittedAt = Objects.requireNonNull(submittedAt);
    }

    public boolean shouldEnterMistakeBook() {
        return !correct;
    }

    public UUID id() {
        return id;
    }

    public UUID userId() {
        return userId;
    }

    public UUID questionId() {
        return questionId;
    }

    public String submittedAnswer() {
        return submittedAnswer;
    }

    public String correctAnswer() {
        return correctAnswer;
    }

    public boolean correct() {
        return correct;
    }

    public Duration elapsed() {
        return elapsed;
    }

    public Instant submittedAt() {
        return submittedAt;
    }
}
