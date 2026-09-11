package com.yanma408.workbench.infrastructure.storage;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "yanma408.object-storage")
public record ObjectStorageProperties(
        String endpoint,
        String accessKey,
        String secretKey,
        String bucket,
        String publicEndpoint,
        boolean virtualStyle
) {
}
