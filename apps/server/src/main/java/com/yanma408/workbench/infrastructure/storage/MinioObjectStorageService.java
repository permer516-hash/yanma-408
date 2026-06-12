package com.yanma408.workbench.infrastructure.storage;

import com.yanma408.workbench.application.material.ObjectStorageService;
import io.minio.BucketExistsArgs;
import io.minio.GetPresignedObjectUrlArgs;
import io.minio.MakeBucketArgs;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import io.minio.http.Method;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Duration;

@Service
public class MinioObjectStorageService implements ObjectStorageService {
    private final MinioClient minioClient;
    private final ObjectStorageProperties properties;

    public MinioObjectStorageService(MinioClient minioClient, ObjectStorageProperties properties) {
        this.minioClient = minioClient;
        this.properties = properties;
    }

    @Override
    public String bucket() {
        return properties.bucket();
    }

    @Override
    public void putObject(String objectKey, Path file, String contentType, long sizeBytes) {
        try {
            ensureBucket();
            try (var input = Files.newInputStream(file)) {
                minioClient.putObject(PutObjectArgs.builder()
                        .bucket(properties.bucket())
                        .object(objectKey)
                        .stream(input, sizeBytes, -1)
                        .contentType(contentType)
                        .build());
            }
        } catch (Exception exception) {
            throw new IllegalStateException("Failed to upload object: " + objectKey, exception);
        }
    }

    @Override
    public String createDownloadUrl(String objectKey, Duration expiry) {
        try {
            return minioClient.getPresignedObjectUrl(GetPresignedObjectUrlArgs.builder()
                    .method(Method.GET)
                    .bucket(properties.bucket())
                    .object(objectKey)
                    .expiry(Math.toIntExact(expiry.toSeconds()))
                    .build());
        } catch (Exception exception) {
            throw new IllegalStateException("Failed to create download url: " + objectKey, exception);
        }
    }

    private void ensureBucket() throws Exception {
        var exists = minioClient.bucketExists(BucketExistsArgs.builder()
                .bucket(properties.bucket())
                .build());
        if (!exists) {
            minioClient.makeBucket(MakeBucketArgs.builder()
                    .bucket(properties.bucket())
                    .build());
        }
    }
}
