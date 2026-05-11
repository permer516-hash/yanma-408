package com.yanma408.question.domain.model;

import java.util.UUID;

public record QuestionId(UUID value) {

    public static QuestionId newId() {
        return new QuestionId(UUID.randomUUID());
    }
}
