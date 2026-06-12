package com.yanma408.workbench.application.material;

import java.nio.file.Path;
import java.time.Duration;

public interface ObjectStorageService {
    String bucket();

    void putObject(String objectKey, Path file, String contentType, long sizeBytes);

    String createDownloadUrl(String objectKey, Duration expiry);
}
