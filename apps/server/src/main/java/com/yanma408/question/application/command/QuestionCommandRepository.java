package com.yanma408.question.application.command;

import java.util.List;
import java.util.UUID;

public interface QuestionCommandRepository {
    UUID create(CreateQuestionCommand command);

    void validateReferences(CreateQuestionCommand command);

    void update(UUID questionId, CreateQuestionCommand command);

    void updateStatus(UUID questionId, String status);

    void updateDifficulty(UUID questionId, String difficulty);

    void updateSource(UUID questionId, String source);

    void updateReviewStatus(UUID questionId, String reviewStatus, String reviewNote);

    void bulkUpdate(List<UUID> questionIds, String status, String reviewStatus, List<String> tags);

    void delete(UUID questionId);
}
