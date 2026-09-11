package com.yanma408.workbench.infrastructure.storage;

import org.junit.jupiter.api.Test;
import org.springframework.mock.env.MockEnvironment;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

class MinioStorageConfigTest {

    private final ObjectStorageProperties localStorage = new ObjectStorageProperties(
            "http://localhost:9000",
            "access-key",
            "secret-key",
            "yanma408-materials",
            "http://localhost:9000",
            false
    );

    @Test
    void enablesVirtualStyleForProductionCos() {
        var environment = new MockEnvironment();
        environment.setActiveProfiles("prod");

        assertTrue(MinioStorageConfig.usesVirtualStyle(localStorage, environment));
    }

    @Test
    void keepsLocalMinioPathStyleByDefault() {
        assertFalse(MinioStorageConfig.usesVirtualStyle(localStorage, new MockEnvironment()));
    }
}
