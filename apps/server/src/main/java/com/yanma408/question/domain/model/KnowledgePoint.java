package com.yanma408.question.domain.model;

public record KnowledgePoint(String code, String name) {

    public KnowledgePoint {
        if (code == null || code.isBlank()) {
            throw new IllegalArgumentException("code must not be blank");
        }
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("name must not be blank");
        }
    }
}
