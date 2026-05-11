package com.yanma408.mistake.application.service;

import com.yanma408.mistake.domain.repository.MistakeRepository;
import com.yanma408.practice.domain.model.PracticeAttempt;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class MistakeService {
    private final MistakeRepository mistakeRepository;

    public MistakeService(MistakeRepository mistakeRepository) {
        this.mistakeRepository = mistakeRepository;
    }

    public MistakeUpdateResult recordWrongAttempt(PracticeAttempt attempt) {
        return mistakeRepository.upsertWrongAttempt(attempt);
    }

    public MistakeUpdateResult markMastered(UUID userId, UUID questionId) {
        mistakeRepository.markMastered(userId, questionId);
        return MistakeUpdateResult.notEntered();
    }

    public void updateMastered(UUID userId, UUID mistakeId, boolean mastered) {
        mistakeRepository.updateMastered(userId, mistakeId, mastered);
    }
}
