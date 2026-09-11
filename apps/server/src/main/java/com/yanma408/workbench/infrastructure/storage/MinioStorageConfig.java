package com.yanma408.workbench.infrastructure.storage;

import io.minio.MinioClient;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableConfigurationProperties(ObjectStorageProperties.class)
public class MinioStorageConfig {

    @Bean
    public MinioClient minioClient(ObjectStorageProperties properties) {
        var client = MinioClient.builder()
                .endpoint(properties.endpoint())
                .credentials(properties.accessKey(), properties.secretKey())
                .build();
        if (properties.virtualStyle()) {
            client.enableVirtualStyleEndpoint();
        }
        return client;
    }
}
