package com.yanma408.workbench.application.material;

public record MaterialAssetSearchFilter(
        String keyword,
        String subjectCode,
        String sourceType,
        String status
) {
}
