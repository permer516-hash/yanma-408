package com.yanma408.workbench.application.content;

import java.util.List;
import java.util.UUID;

public record CandidateDraftBatchResult(
        int requestedCount,
        int createdCount,
        List<CreatedDraft> drafts
) {
    public record CreatedDraft(
            UUID candidateId,
            UUID draftId
    ) {
    }
}
