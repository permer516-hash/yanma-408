package com.yanma408.comprehensive.interfaces.rest;

import com.yanma408.comprehensive.application.ComprehensiveAttemptService;
import com.yanma408.comprehensive.application.ComprehensiveAttemptView;
import com.yanma408.shared.application.security.CurrentUserProvider;
import com.yanma408.shared.application.security.UserRoleService;
import com.yanma408.workbench.application.material.MaterialUploadCommand;
import com.yanma408.workbench.application.material.MaterialAssetService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.ResponseEntity;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/comprehensive-attempts")
public class ComprehensiveAttemptController {
    private final ComprehensiveAttemptService attemptService;
    private final MaterialAssetService materialAssetService;
    private final CurrentUserProvider currentUserProvider;
    private final UserRoleService userRoleService;

    public ComprehensiveAttemptController(
            ComprehensiveAttemptService attemptService,
            MaterialAssetService materialAssetService,
            CurrentUserProvider currentUserProvider,
            UserRoleService userRoleService
    ) {
        this.attemptService = attemptService;
        this.materialAssetService = materialAssetService;
        this.currentUserProvider = currentUserProvider;
        this.userRoleService = userRoleService;
    }

    @GetMapping("/questions/{questionId}/latest")
    public ResponseEntity<ComprehensiveAttemptView> latest(@PathVariable UUID questionId) {
        requireStudent();
        var attempt = attemptService.findLatest(currentUserProvider.currentUserId(), questionId);
        return attempt == null ? ResponseEntity.noContent().build() : ResponseEntity.ok(attempt);
    }

    @PostMapping("/draft")
    public ComprehensiveAttemptView saveDraft(@Valid @RequestBody AttemptRequest request) {
        requireStudent();
        return attemptService.saveDraft(currentUserProvider.currentUserId(), request.questionId(), request.mode(), request.elapsedSeconds(), request.toCommands());
    }

    @PostMapping("/submit")
    public ComprehensiveAttemptView submit(@Valid @RequestBody AttemptRequest request) {
        requireStudent();
        return attemptService.submit(currentUserProvider.currentUserId(), request.questionId(), request.mode(), request.elapsedSeconds(), request.toCommands());
    }

    @PostMapping("/{attemptId}/review-requests")
    public void requestReview(@PathVariable UUID attemptId, @Valid @RequestBody ReviewRequest request) {
        requireStudent();
        attemptService.requestReview(currentUserProvider.currentUserId(), attemptId, request.message());
    }

    @PostMapping(value = "/attachments", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public AttachmentUploadResponse uploadAttachment(@RequestPart MultipartFile file) {
        requireStudent();
        if (file.isEmpty() || file.getContentType() == null || !file.getContentType().startsWith("image/")) {
            throw new IllegalArgumentException("只能上传图片作答");
        }
        if (file.getSize() > 5 * 1024 * 1024) {
            throw new IllegalArgumentException("图片大小不能超过 5MB");
        }
        var asset = materialAssetService.upload(new MaterialUploadCommand(
                "综合题作答附件", null, "OTHER", null, "学生综合题作答附件", file
        ));
        return new AttachmentUploadResponse("/workbench/materials/" + asset.id() + "/image");
    }

    private void requireStudent() {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "STUDENT");
    }

    public record AttemptRequest(
            @NotNull UUID questionId,
            String mode,
            @Min(0) @Max(Integer.MAX_VALUE) int elapsedSeconds,
            @NotEmpty List<@Valid ResponseRequest> responses
    ) {
        List<ComprehensiveAttemptService.ResponseCommand> toCommands() {
            return responses.stream().map(response -> new ComprehensiveAttemptService.ResponseCommand(
                    response.partId(), response.content(), response.attachmentUrls() == null ? List.of() : response.attachmentUrls()
            )).toList();
        }
    }

    public record ResponseRequest(@NotNull UUID partId, String content, List<String> attachmentUrls) {
    }

    public record ReviewRequest(@NotBlank String message) {
    }

    public record AttachmentUploadResponse(String url) {
    }
}
