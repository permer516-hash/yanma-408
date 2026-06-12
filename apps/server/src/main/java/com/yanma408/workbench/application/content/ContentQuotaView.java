package com.yanma408.workbench.application.content;

import java.util.UUID;

public record ContentQuotaView(
        UUID id,
        String subjectCode,
        String chapterCode,
        String knowledgePointCode,
        String source,
        String difficulty,
        int targetCount,
        int publishedCount,
        int approvedDraftCount,
        int reviewingDraftCount,
        int remainingCount,
        String priority,
        String notes
) {
}
