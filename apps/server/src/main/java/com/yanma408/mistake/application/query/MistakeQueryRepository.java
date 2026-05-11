package com.yanma408.mistake.application.query;

import java.util.List;
import java.util.UUID;

public interface MistakeQueryRepository {
    List<MistakeSummary> findByUserId(UUID userId, MistakeFilter filter);
}
