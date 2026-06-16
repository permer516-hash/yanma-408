package com.yanma408.workbench.interfaces.rest;

import com.yanma408.shared.application.security.CurrentUserProvider;
import com.yanma408.shared.application.security.UserRoleService;
import com.yanma408.workbench.application.material.MaterialAsset;
import com.yanma408.workbench.application.material.MaterialAuthorizationAttachment;
import com.yanma408.workbench.application.material.MaterialAuthorizationAttachmentService;
import com.yanma408.workbench.application.material.MaterialCopyrightAudit;
import com.yanma408.workbench.application.material.MaterialCopyrightAuditCommand;
import com.yanma408.workbench.application.material.MaterialCopyrightAuditService;
import com.yanma408.workbench.application.material.MaterialAssetSearchFilter;
import com.yanma408.workbench.application.material.MaterialAssetService;
import com.yanma408.workbench.application.material.MaterialScanResult;
import com.yanma408.workbench.application.material.MaterialUploadCommand;
import jakarta.validation.constraints.NotBlank;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.net.URI;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/workbench/materials")
public class MaterialWorkbenchController {
    private final MaterialAssetService materialAssetService;
    private final MaterialCopyrightAuditService copyrightAuditService;
    private final MaterialAuthorizationAttachmentService attachmentService;
    private final CurrentUserProvider currentUserProvider;
    private final UserRoleService userRoleService;

    public MaterialWorkbenchController(
            MaterialAssetService materialAssetService,
            MaterialCopyrightAuditService copyrightAuditService,
            MaterialAuthorizationAttachmentService attachmentService,
            CurrentUserProvider currentUserProvider,
            UserRoleService userRoleService
    ) {
        this.materialAssetService = materialAssetService;
        this.copyrightAuditService = copyrightAuditService;
        this.attachmentService = attachmentService;
        this.currentUserProvider = currentUserProvider;
        this.userRoleService = userRoleService;
    }

    @GetMapping
    public List<MaterialAsset> search(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String subjectCode,
            @RequestParam(required = false) String sourceType,
            @RequestParam(required = false) String status
    ) {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "ADMIN");
        return materialAssetService.search(new MaterialAssetSearchFilter(keyword, subjectCode, sourceType, status));
    }

    @PostMapping(value = "/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public MaterialAsset upload(
            @RequestParam @NotBlank String title,
            @RequestParam(required = false) String subjectCode,
            @RequestParam @NotBlank String sourceType,
            @RequestParam(required = false) Integer sourceYear,
            @RequestParam(required = false) String notes,
            @RequestPart MultipartFile file
    ) {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "ADMIN");
        return materialAssetService.upload(new MaterialUploadCommand(
                title,
                subjectCode,
                sourceType,
                sourceYear,
                notes,
                file
        ));
    }

    @GetMapping("/{id}/download-url")
    public DownloadUrlResponse createDownloadUrl(@PathVariable UUID id) {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "ADMIN");
        return new DownloadUrlResponse(materialAssetService.createDownloadUrl(id), 600);
    }

    @GetMapping("/{id}/image")
    public ResponseEntity<Void> displayImage(@PathVariable UUID id) {
        return ResponseEntity.status(HttpStatus.FOUND)
                .location(URI.create(materialAssetService.createImageDisplayUrl(id)))
                .build();
    }

    @PostMapping("/scan-local")
    public MaterialScanResult scanLocal(@RequestBody ScanLocalMaterialsRequest request) {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "ADMIN");
        return materialAssetService.scanLocalDirectory(request.rootPath());
    }

    @GetMapping("/{id}/copyright-audits")
    public List<MaterialCopyrightAudit> copyrightAudits(@PathVariable UUID id) {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "ADMIN");
        return copyrightAuditService.list(id);
    }

    @PostMapping("/{id}/copyright-audits")
    public MaterialCopyrightAudit createCopyrightAudit(
            @PathVariable UUID id,
            @RequestBody CreateCopyrightAuditRequest request
    ) {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "ADMIN");
        return copyrightAuditService.create(id, new MaterialCopyrightAuditCommand(
                request.sourceName(),
                request.sourceYear(),
                request.authorizationScope(),
                request.riskLevel(),
                request.decision(),
                request.notes(),
                request.auditedBy()
        ));
    }

    @GetMapping("/{id}/authorization-attachments")
    public List<MaterialAuthorizationAttachment> authorizationAttachments(@PathVariable UUID id) {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "ADMIN");
        return attachmentService.list(id);
    }

    @PostMapping(value = "/{id}/authorization-attachments", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public MaterialAuthorizationAttachment uploadAuthorizationAttachment(
            @PathVariable UUID id,
            @RequestParam(required = false) UUID auditId,
            @RequestParam(required = false) String notes,
            @RequestPart MultipartFile file
    ) {
        var userId = currentUserProvider.currentUserId();
        userRoleService.requireAny(userId, "ADMIN");
        return attachmentService.upload(id, auditId, notes, file, userId);
    }

    public record DownloadUrlResponse(String url, int expiresInSeconds) {
    }

    public record ScanLocalMaterialsRequest(@NotBlank String rootPath) {
    }

    public record CreateCopyrightAuditRequest(
            @NotBlank String sourceName,
            Integer sourceYear,
            @NotBlank String authorizationScope,
            @NotBlank String riskLevel,
            @NotBlank String decision,
            String notes,
            String auditedBy
    ) {
    }
}
