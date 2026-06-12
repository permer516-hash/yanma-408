package com.yanma408.workbench.application.material;

import com.yanma408.shared.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.DigestInputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.HexFormat;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Stream;

@Service
public class MaterialAssetService {
    private static final Set<String> ALLOWED_SOURCE_TYPES = Set.of(
            "TEXTBOOK", "PAST_EXAM", "MOCK_EXAM", "ORIGINAL_DRAFT", "OTHER"
    );
    private static final Set<String> ALLOWED_SUBJECT_CODES = Set.of(
            "DATA_STRUCTURE", "COMPUTER_ORGANIZATION", "OPERATING_SYSTEM", "COMPUTER_NETWORK"
    );

    private final MaterialAssetRepository repository;
    private final ObjectStorageService objectStorageService;

    public MaterialAssetService(MaterialAssetRepository repository, ObjectStorageService objectStorageService) {
        this.repository = repository;
        this.objectStorageService = objectStorageService;
    }

    @Transactional
    public MaterialAsset upload(MaterialUploadCommand command) {
        validate(command);
        var normalizedSourceType = normalizeSourceType(command.sourceType());
        var normalizedSubjectCode = normalizeSubjectCode(command.subjectCode());
        var title = command.title().trim();
        var file = command.file();
        var originalFileName = safeFileName(file.getOriginalFilename());
        var contentType = file.getContentType() == null || file.getContentType().isBlank()
                ? "application/octet-stream"
                : file.getContentType();
        var tempFile = createTempFile();
        try {
            var sha256 = copyAndHash(file, tempFile);
            var sizeBytes = Files.size(tempFile);
            if (sizeBytes <= 0) {
                throw new IllegalArgumentException("file must not be empty");
            }
            var id = UUID.randomUUID();
            var objectKey = buildObjectKey(normalizedSourceType, command.sourceYear(), title, originalFileName, sha256);
            objectStorageService.putObject(objectKey, tempFile, contentType, sizeBytes);
            var now = Instant.now();
            var asset = new MaterialAsset(
                    id,
                    title,
                    normalizedSubjectCode,
                    normalizedSourceType,
                    command.sourceYear(),
                    objectStorageService.bucket(),
                    objectKey,
                    originalFileName,
                    contentType,
                    sizeBytes,
                    sha256,
                    "REGISTERED",
                    blankToNull(command.notes()),
                    now,
                    now
            );
            return repository.save(asset);
        } catch (IOException exception) {
            throw new IllegalStateException("Failed to store material file", exception);
        } finally {
            deleteQuietly(tempFile);
        }
    }

    public List<MaterialAsset> search(MaterialAssetSearchFilter filter) {
        return repository.search(new MaterialAssetSearchFilter(
                blankToNull(filter.keyword()),
                normalizeSubjectCode(filter.subjectCode()),
                normalizeSourceTypeOrNull(filter.sourceType()),
                normalizeStatusOrNull(filter.status())
        ));
    }

    public String createDownloadUrl(UUID id) {
        var asset = repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Material asset not found: " + id));
        return objectStorageService.createDownloadUrl(asset.objectKey(), Duration.ofMinutes(10));
    }

    public String createImageDisplayUrl(UUID id) {
        var asset = repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Material asset not found: " + id));
        if (asset.contentType() == null || !asset.contentType().toLowerCase(Locale.ROOT).startsWith("image/")) {
            throw new IllegalArgumentException("Material asset is not an image");
        }
        return objectStorageService.createDownloadUrl(asset.objectKey(), Duration.ofMinutes(10));
    }

    @Transactional
    public MaterialScanResult scanLocalDirectory(String rootPath) {
        requireText(rootPath, "rootPath");
        var root = Path.of(rootPath).toAbsolutePath().normalize();
        if (!Files.isDirectory(root)) {
            throw new IllegalArgumentException("rootPath must be an existing directory");
        }
        var registered = new ArrayList<MaterialAsset>();
        var scannedFiles = 0;
        try (Stream<Path> paths = Files.walk(root)) {
            var files = paths
                    .filter(Files::isRegularFile)
                    .filter(this::isSupportedMaterialFile)
                    .sorted()
                    .toList();
            scannedFiles = files.size();
            for (Path file : files) {
                var objectKey = file.toAbsolutePath().normalize().toString();
                if (repository.findByBucketAndObjectKey("LOCAL", objectKey).isPresent()) {
                    continue;
                }
                var asset = registerLocalFile(root, file);
                registered.add(asset);
            }
            return new MaterialScanResult(
                    root.toString(),
                    scannedFiles,
                    registered.size(),
                    scannedFiles - registered.size(),
                    registered
            );
        } catch (IOException exception) {
            throw new IllegalStateException("Failed to scan material directory", exception);
        }
    }

    private void validate(MaterialUploadCommand command) {
        requireText(command.title(), "title");
        requireText(command.sourceType(), "sourceType");
        if (command.file() == null || command.file().isEmpty()) {
            throw new IllegalArgumentException("file is required");
        }
        var sourceType = normalizeSourceType(command.sourceType());
        normalizeSubjectCode(command.subjectCode());
        if ("PAST_EXAM".equals(sourceType) && command.sourceYear() == null) {
            throw new IllegalArgumentException("sourceYear is required for past exam materials");
        }
        if (command.sourceYear() != null && (command.sourceYear() < 2009 || command.sourceYear() > 2100)) {
            throw new IllegalArgumentException("sourceYear must be between 2009 and 2100");
        }
    }

    private void requireText(String value, String fieldName) {
        if (value == null || value.isBlank()) {
            throw new IllegalArgumentException(fieldName + " is required");
        }
    }

    private String normalizeSourceType(String value) {
        var normalized = normalizeSourceTypeOrNull(value);
        if (normalized == null) {
            throw new IllegalArgumentException("sourceType is required");
        }
        return normalized;
    }

    private String normalizeSourceTypeOrNull(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        var normalized = switch (value.trim()) {
            case "教材", "课本", "TEXTBOOK" -> "TEXTBOOK";
            case "真题", "真题卷", "PAST_EXAM" -> "PAST_EXAM";
            case "模拟", "模拟卷", "MOCK_EXAM" -> "MOCK_EXAM";
            case "原创", "原创草稿", "ORIGINAL_DRAFT" -> "ORIGINAL_DRAFT";
            case "其他", "OTHER" -> "OTHER";
            default -> value.trim().toUpperCase(Locale.ROOT);
        };
        if (!ALLOWED_SOURCE_TYPES.contains(normalized)) {
            throw new IllegalArgumentException("Unsupported sourceType: " + value);
        }
        return normalized;
    }

    private String normalizeSubjectCode(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        var normalized = switch (value.trim()) {
            case "数据结构", "DATA_STRUCTURE" -> "DATA_STRUCTURE";
            case "计组", "计算机组成原理", "COMPUTER_ORGANIZATION" -> "COMPUTER_ORGANIZATION";
            case "操作系统", "OPERATING_SYSTEM" -> "OPERATING_SYSTEM";
            case "计网", "计算机网络", "COMPUTER_NETWORK" -> "COMPUTER_NETWORK";
            default -> value.trim().toUpperCase(Locale.ROOT);
        };
        if (!ALLOWED_SUBJECT_CODES.contains(normalized)) {
            throw new IllegalArgumentException("Unsupported subjectCode: " + value);
        }
        return normalized;
    }

    private String normalizeStatusOrNull(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        return value.trim().toUpperCase(Locale.ROOT);
    }

    private String copyAndHash(org.springframework.web.multipart.MultipartFile file, java.nio.file.Path target) throws IOException {
        try {
            var digest = MessageDigest.getInstance("SHA-256");
            try (var input = new DigestInputStream(file.getInputStream(), digest);
                 var output = Files.newOutputStream(target)) {
                input.transferTo(output);
            }
            return HexFormat.of().formatHex(digest.digest());
        } catch (NoSuchAlgorithmException exception) {
            throw new IllegalStateException("SHA-256 is not available", exception);
        }
    }

    private MaterialAsset registerLocalFile(Path root, Path file) throws IOException {
        var fileName = safeFileName(file.getFileName().toString());
        var relativePath = root.relativize(file).toString();
        var title = titleFromFileName(fileName);
        var sha256 = hashPath(file);
        var sizeBytes = Files.size(file);
        var now = Instant.now();
        var inferred = inferMetadata(relativePath + " " + fileName);
        var asset = new MaterialAsset(
                UUID.randomUUID(),
                title,
                inferred.subjectCode(),
                inferred.sourceType(),
                inferred.sourceYear(),
                "LOCAL",
                file.toAbsolutePath().normalize().toString(),
                fileName,
                contentType(file),
                sizeBytes,
                sha256,
                "REGISTERED",
                "Local scan from %s; relative path: %s; copyright audit required before extracting or publishing past exam content."
                        .formatted(root, relativePath),
                now,
                now
        );
        return repository.saveIfAbsent(asset);
    }

    private String hashPath(Path file) throws IOException {
        try {
            var digest = MessageDigest.getInstance("SHA-256");
            try (var input = new DigestInputStream(Files.newInputStream(file), digest)) {
                input.transferTo(java.io.OutputStream.nullOutputStream());
            }
            return HexFormat.of().formatHex(digest.digest());
        } catch (NoSuchAlgorithmException exception) {
            throw new IllegalStateException("SHA-256 is not available", exception);
        }
    }

    private java.nio.file.Path createTempFile() {
        try {
            return Files.createTempFile("yanma408-material-", ".upload");
        } catch (IOException exception) {
            throw new IllegalStateException("Failed to create temporary upload file", exception);
        }
    }

    private String buildObjectKey(String sourceType, Integer sourceYear, String title, String fileName, String sha256) {
        var yearSegment = sourceYear == null ? "unknown-year" : sourceYear.toString();
        var extension = fileExtension(fileName);
        return "raw/%s/%s/%s-%s%s".formatted(
                sourceType.toLowerCase(Locale.ROOT).replace('_', '-'),
                yearSegment,
                slug(title),
                sha256.substring(0, 16),
                extension
        );
    }

    private String slug(String value) {
        var slug = value.trim()
                .toLowerCase(Locale.ROOT)
                .replaceAll("[^a-z0-9\\u4e00-\\u9fa5]+", "-")
                .replaceAll("^-|-$", "");
        return slug.isBlank() ? "material" : slug;
    }

    private String safeFileName(String value) {
        if (value == null || value.isBlank()) {
            return "material.bin";
        }
        return value.replaceAll("[\\\\/]+", "_").trim();
    }

    private String fileExtension(String fileName) {
        var index = fileName.lastIndexOf('.');
        if (index < 0 || index == fileName.length() - 1) {
            return "";
        }
        return fileName.substring(index).toLowerCase(Locale.ROOT).replaceAll("[^a-z0-9.]", "");
    }

    private boolean isSupportedMaterialFile(Path path) {
        var name = path.getFileName().toString().toLowerCase(Locale.ROOT);
        return name.endsWith(".pdf")
                || name.endsWith(".doc")
                || name.endsWith(".docx")
                || name.endsWith(".xls")
                || name.endsWith(".xlsx")
                || name.endsWith(".csv")
                || name.endsWith(".png")
                || name.endsWith(".jpg")
                || name.endsWith(".jpeg");
    }

    private String titleFromFileName(String fileName) {
        var index = fileName.lastIndexOf('.');
        var title = index > 0 ? fileName.substring(0, index) : fileName;
        return title.isBlank() ? "本地资料" : title;
    }

    private String contentType(Path file) {
        try {
            var detected = Files.probeContentType(file);
            return detected == null || detected.isBlank() ? "application/octet-stream" : detected;
        } catch (IOException ignored) {
            return "application/octet-stream";
        }
    }

    private InferredMaterialMetadata inferMetadata(String path) {
        var text = path.toLowerCase(Locale.ROOT);
        var sourceType = "OTHER";
        if (text.contains("教材") || text.contains("数据结构.pdf") || text.contains("计算机网络.pdf")
                || text.contains("计算机组成原理.pdf") || text.contains("操作系统.pdf")) {
            sourceType = "TEXTBOOK";
        } else if (text.contains("真题")) {
            sourceType = "PAST_EXAM";
        } else if (text.contains("模拟") || text.contains("套卷")) {
            sourceType = "MOCK_EXAM";
        }
        var subjectCode = (String) null;
        if (text.contains("数据结构")) {
            subjectCode = "DATA_STRUCTURE";
        } else if (text.contains("组成") || text.contains("计组")) {
            subjectCode = "COMPUTER_ORGANIZATION";
        } else if (text.contains("操作系统")) {
            subjectCode = "OPERATING_SYSTEM";
        } else if (text.contains("网络")) {
            subjectCode = "COMPUTER_NETWORK";
        }
        return new InferredMaterialMetadata(subjectCode, sourceType, inferYear(path));
    }

    private Integer inferYear(String value) {
        var matcher = java.util.regex.Pattern.compile("(20\\d{2})").matcher(value);
        if (matcher.find()) {
            return Integer.valueOf(matcher.group(1));
        }
        var shortYear = java.util.regex.Pattern.compile("(^|[^0-9])(2[0-9])([^0-9]|$)").matcher(value);
        if (shortYear.find()) {
            return 2000 + Integer.parseInt(shortYear.group(2));
        }
        return null;
    }

    private String blankToNull(String value) {
        return value == null || value.isBlank() ? null : value.trim();
    }

    private void deleteQuietly(java.nio.file.Path path) {
        try {
            Files.deleteIfExists(path);
        } catch (IOException ignored) {
            // Temporary file cleanup failure should not hide a successful upload.
        }
    }

    private record InferredMaterialMetadata(String subjectCode, String sourceType, Integer sourceYear) {
    }
}
