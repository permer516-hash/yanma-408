package com.yanma408.workbench.application.material;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.Duration;
import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class MaterialAssetServiceTest {
    @Mock
    private MaterialAssetRepository repository;

    @Mock
    private ObjectStorageService objectStorageService;

    @InjectMocks
    private MaterialAssetService service;

    @Test
    void createImageDisplayUrlReturnsSignedStorageUrlForImages() {
        var id = UUID.randomUUID();
        var asset = asset(id, "image/png");
        when(repository.findById(id)).thenReturn(Optional.of(asset));
        when(objectStorageService.createDownloadUrl(asset.objectKey(), Duration.ofMinutes(10)))
                .thenReturn("http://storage.example/tree.png");

        var result = service.createImageDisplayUrl(id);

        assertEquals("http://storage.example/tree.png", result);
    }

    @Test
    void createImageDisplayUrlRejectsNonImageAssets() {
        var id = UUID.randomUUID();
        var asset = asset(id, "application/pdf");
        when(repository.findById(id)).thenReturn(Optional.of(asset));

        assertThrows(IllegalArgumentException.class, () -> service.createImageDisplayUrl(id));
        verify(objectStorageService, never()).createDownloadUrl(asset.objectKey(), Duration.ofMinutes(10));
    }

    private MaterialAsset asset(UUID id, String contentType) {
        var now = Instant.now();
        return new MaterialAsset(
                id,
                "题干配图",
                "DATA_STRUCTURE",
                "OTHER",
                null,
                "yanma408-materials",
                "question-image/tree.png",
                "tree.png",
                contentType,
                32,
                "0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef",
                "REGISTERED",
                null,
                now,
                now
        );
    }
}
