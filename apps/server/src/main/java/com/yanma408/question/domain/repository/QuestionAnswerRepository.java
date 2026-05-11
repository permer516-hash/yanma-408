package com.yanma408.question.domain.repository;

import java.util.Optional;
import java.util.UUID;

public interface QuestionAnswerRepository {

    Optional<QuestionAnswerSnapshot> findPublishedAnswer(UUID questionId);

    record QuestionAnswerSnapshot(UUID questionId, String correctAnswer, String explanation) {
    }
}
