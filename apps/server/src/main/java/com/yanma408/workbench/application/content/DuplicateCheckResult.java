package com.yanma408.workbench.application.content;

import java.util.List;
import java.util.UUID;

public record DuplicateCheckResult(
        UUID draftId,
        String fingerprint,
        boolean duplicate,
        List<DuplicateItem> items
) {
    public record DuplicateItem(
            String type,
            UUID id,
            String status,
            String stemPreview,
            String matchType,
            double similarityScore
    ) {
    }
}
