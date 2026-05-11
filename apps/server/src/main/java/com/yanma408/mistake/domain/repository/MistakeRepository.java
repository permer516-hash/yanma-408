package com.yanma408.mistake.domain.repository;

import com.yanma408.mistake.application.service.MistakeUpdateResult;
import com.yanma408.practice.domain.model.PracticeAttempt;

import java.util.UUID;

public interface MistakeRepository {

    MistakeUpdateResult upsertWrongAttempt(PracticeAttempt attempt);

    void markMastered(UUID userId, UUID questionId);

    void updateMastered(UUID userId, UUID mistakeId, boolean mastered);
}
