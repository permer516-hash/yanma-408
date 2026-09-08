package com.yanma408.recruitment.application;

import java.util.List;

public record RecruitmentLeadPage(
        List<RecruitmentLeadView> items,
        int page,
        int size,
        int total,
        int totalPages
) {
}
