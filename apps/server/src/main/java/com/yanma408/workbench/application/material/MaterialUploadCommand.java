package com.yanma408.workbench.application.material;

import org.springframework.web.multipart.MultipartFile;

public record MaterialUploadCommand(
        String title,
        String subjectCode,
        String sourceType,
        Integer sourceYear,
        String notes,
        MultipartFile file
) {
}
