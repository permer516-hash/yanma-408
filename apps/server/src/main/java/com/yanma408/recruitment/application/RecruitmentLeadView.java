package com.yanma408.recruitment.application;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public record RecruitmentLeadView(
        UUID id,
        String contactName,
        String wechatContact,
        int examYear,
        String targetSchool,
        String studyStage,
        List<String> weakSubjects,
        Integer weeklyHours,
        String currentConcern,
        String status,
        LocalDateTime createdAt
) {
}
