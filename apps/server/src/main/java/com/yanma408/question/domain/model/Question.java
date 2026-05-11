package com.yanma408.question.domain.model;

import java.util.List;
import java.util.Objects;

public class Question {
    private final QuestionId id;
    private final Subject subject;
    private final QuestionType type;
    private final Difficulty difficulty;
    private final String stem;
    private final List<KnowledgePoint> knowledgePoints;

    public Question(
            QuestionId id,
            Subject subject,
            QuestionType type,
            Difficulty difficulty,
            String stem,
            List<KnowledgePoint> knowledgePoints
    ) {
        this.id = Objects.requireNonNull(id);
        this.subject = Objects.requireNonNull(subject);
        this.type = Objects.requireNonNull(type);
        this.difficulty = Objects.requireNonNull(difficulty);
        this.stem = requireText(stem, "stem");
        this.knowledgePoints = List.copyOf(knowledgePoints);
    }

    public boolean isObjective() {
        return type == QuestionType.SINGLE_CHOICE || type == QuestionType.MULTIPLE_CHOICE;
    }

    public QuestionId id() {
        return id;
    }

    public Subject subject() {
        return subject;
    }

    public QuestionType type() {
        return type;
    }

    public Difficulty difficulty() {
        return difficulty;
    }

    public String stem() {
        return stem;
    }

    public List<KnowledgePoint> knowledgePoints() {
        return knowledgePoints;
    }

    private static String requireText(String value, String field) {
        if (value == null || value.isBlank()) {
            throw new IllegalArgumentException(field + " must not be blank");
        }
        return value;
    }
}
