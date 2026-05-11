package com.yanma408.mistake.application.query;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class MistakeQueryService {
    private final MistakeQueryRepository mistakeQueryRepository;

    public MistakeQueryService(MistakeQueryRepository mistakeQueryRepository) {
        this.mistakeQueryRepository = mistakeQueryRepository;
    }

    public List<MistakeSummary> findMine(UUID userId, MistakeFilter filter) {
        return mistakeQueryRepository.findByUserId(userId, filter);
    }
}
