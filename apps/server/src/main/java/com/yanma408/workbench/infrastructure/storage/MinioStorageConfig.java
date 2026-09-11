package com.yanma408.workbench.infrastructure.storage;

import io.minio.MinioClient;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

@Configuration
@EnableConfigurationProperties(ObjectStorageProperties.class)
public class MinioStorageConfig {

    @Bean
    public MinioClient minioClient(ObjectStorageProperties properties, Environment environment) {
        var client = MinioClient.builder()
                .endpoint(properties.endpoint())
                .credentials(properties.accessKey(), properties.secretKey())
                .build();
        if (usesVirtualStyle(properties, environment)) {
            client.enableVirtualStyleEndpoint();
        }
        return client;
    }

    static boolean usesVirtualStyle(ObjectStorageProperties properties, Environment environment) {
        return properties.virtualStyle() || environment.matchesProfiles("prod");
    }
}
