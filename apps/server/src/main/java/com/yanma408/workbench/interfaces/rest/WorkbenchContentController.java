package com.yanma408.workbench.interfaces.rest;

import com.yanma408.workbench.application.content.ContentQuotaView;
import com.yanma408.workbench.application.content.CandidateDraftBatchResult;
import com.yanma408.workbench.application.content.DuplicateCheckResult;
import com.yanma408.workbench.application.content.MaterialExtractionCandidate;
import com.yanma408.workbench.application.content.QuestionDraftCommand;
import com.yanma408.workbench.application.content.QuestionDraftView;
import com.yanma408.workbench.application.content.WorkbenchContentService;
import com.yanma408.shared.application.security.CurrentUserProvider;
import com.yanma408.shared.application.security.UserRoleService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/workbench")
public class WorkbenchContentController {
    private final WorkbenchContentService service;
    private final CurrentUserProvider currentUserProvider;
    private final UserRoleService userRoleService;

    public WorkbenchContentController(
            WorkbenchContentService service,
            CurrentUserProvider currentUserProvider,
            UserRoleService userRoleService
    ) {
        this.service = service;
        this.currentUserProvider = currentUserProvider;
        this.userRoleService = userRoleService;
    }

    @GetMapping("/content-quotas")
    public List<ContentQuotaView> quotas() {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "AUTHOR", "REVIEWER", "ADMIN");
        return service.listQuotas();
    }

    @GetMapping("/question-drafts")
    public List<QuestionDraftView> drafts(
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String reviewStatus
    ) {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "AUTHOR", "REVIEWER", "ADMIN");
        return service.listDrafts(status, reviewStatus);
    }

    @GetMapping("/question-drafts/{id}")
    public QuestionDraftView draft(@PathVariable UUID id) {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "AUTHOR", "REVIEWER", "ADMIN");
        return service.getDraft(id);
    }

    @PostMapping("/question-drafts")
    public QuestionDraftView createDraft(@Valid @RequestBody DraftRequest request) {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "AUTHOR", "ADMIN");
        return service.createDraft(request.toCommand());
    }

    @PostMapping("/question-drafts/{id}/submit-review")
    public QuestionDraftView submitReview(@PathVariable UUID id) {
        var userId = currentUserProvider.currentUserId();
        userRoleService.requireAny(userId, "AUTHOR", "REVIEWER", "ADMIN");
        return service.submitForReview(id, primaryWorkbenchRole(userId));
    }

    @PatchMapping("/question-drafts/{id}/review")
    public QuestionDraftView review(@PathVariable UUID id, @Valid @RequestBody ReviewRequest request) {
        var userId = currentUserProvider.currentUserId();
        userRoleService.requireAny(userId, "REVIEWER", "ADMIN");
        return service.review(id, request.reviewStatus(), request.reviewNote(), primaryWorkbenchRole(userId));
    }

    @PostMapping("/question-drafts/{id}/publish")
    public QuestionDraftView publish(@PathVariable UUID id) {
        var userId = currentUserProvider.currentUserId();
        userRoleService.requireAny(userId, "ADMIN");
        return service.publish(id, userId.toString());
    }

    @GetMapping("/question-drafts/{id}/duplicates")
    public DuplicateCheckResult duplicates(@PathVariable UUID id) {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "AUTHOR", "REVIEWER", "ADMIN");
        return service.checkDuplicates(id);
    }

    @PostMapping("/materials/{id}/extract-candidates")
    public List<MaterialExtractionCandidate> extractCandidates(
            @PathVariable UUID id,
            @Valid @RequestBody ExtractCandidatesRequest request
    ) {
        var userId = currentUserProvider.currentUserId();
        userRoleService.requireAny(userId, "AUTHOR", "REVIEWER", "ADMIN");
        return service.extractCandidates(id, request.startPage(), request.endPage(), userId);
    }

    @GetMapping("/materials/{id}/extract-candidates")
    public List<MaterialExtractionCandidate> candidates(@PathVariable UUID id) {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "AUTHOR", "REVIEWER", "ADMIN");
        return service.listCandidates(id);
    }

    @PostMapping("/extraction-candidates/{id}/run-ocr")
    public MaterialExtractionCandidate runOcr(
            @PathVariable UUID id,
            @RequestBody(required = false) RunOcrRequest request
    ) {
        var userId = currentUserProvider.currentUserId();
        userRoleService.requireAny(userId, "AUTHOR", "REVIEWER", "ADMIN");
        return service.runOcr(id, request == null ? null : request.ocrTextOverride(), userId);
    }

    @PatchMapping("/extraction-candidates/{id}/review")
    public MaterialExtractionCandidate reviewCandidate(
            @PathVariable UUID id,
            @Valid @RequestBody CandidateReviewRequest request
    ) {
        var userId = currentUserProvider.currentUserId();
        userRoleService.requireAny(userId, "AUTHOR", "REVIEWER", "ADMIN");
        return service.reviewCandidate(id, request.toCommand(), userId);
    }

    @PostMapping("/extraction-candidates/batch-create-drafts")
    public CandidateDraftBatchResult batchCreateDrafts(@Valid @RequestBody CandidateBatchDraftRequest request) {
        var userId = currentUserProvider.currentUserId();
        userRoleService.requireAny(userId, "AUTHOR", "ADMIN");
        return service.createDraftsFromCandidates(request.candidateIds(), request.toDefaults(), userId);
    }

    public record DraftRequest(
            UUID materialAssetId,
            @NotBlank String subjectCode,
            @NotBlank String chapterCode,
            @NotBlank String type,
            @NotBlank String difficulty,
            @NotBlank String stem,
            @NotBlank String answer,
            @NotBlank String explanation,
            @NotBlank String source,
            Integer sourceYear,
            BigDecimal score,
            String stemFormat,
            String stemImageUrl,
            List<@Valid OptionRequest> options,
            @NotEmpty List<@NotBlank String> knowledgePointCodes,
            List<String> tags,
            List<PageReferenceRequest> pageReferences,
            String createdBy
    ) {
        private QuestionDraftCommand toCommand() {
            return new QuestionDraftCommand(
                    materialAssetId,
                    subjectCode,
                    chapterCode,
                    type,
                    difficulty,
                    stem,
                    answer,
                    explanation,
                    source,
                    sourceYear,
                    score,
                    stemFormat,
                    stemImageUrl,
                    (options == null ? List.<OptionRequest>of() : options).stream()
                            .map(option -> new QuestionDraftCommand.OptionCommand(option.label(), option.content()))
                            .toList(),
                    knowledgePointCodes,
                    tags,
                    pageReferences == null ? List.of() : pageReferences.stream()
                            .map(reference -> new QuestionDraftCommand.PageReferenceCommand(
                                    reference.materialAssetId(),
                                    reference.extractionCandidateId(),
                                    reference.pageNumber(),
                                    reference.quote(),
                                    reference.referenceNote()
                            ))
                            .toList(),
                    createdBy
            );
        }
    }

    public record OptionRequest(
            @NotBlank String label,
            @NotBlank String content
    ) {
    }

    public record ReviewRequest(
            @NotBlank String reviewStatus,
            String reviewNote
    ) {
    }

    public record PageReferenceRequest(
            UUID materialAssetId,
            UUID extractionCandidateId,
            Integer pageNumber,
            String quote,
            String referenceNote
    ) {
    }

    public record ExtractCandidatesRequest(
            int startPage,
            int endPage
    ) {
    }

    public record RunOcrRequest(String ocrTextOverride) {
    }

    public record CandidateReviewRequest(
            @NotBlank String stem,
            @NotBlank String answer,
            @NotBlank String explanation,
            String type,
            List<OptionRequest> options
    ) {
        private WorkbenchContentService.CandidateReviewCommand toCommand() {
            return new WorkbenchContentService.CandidateReviewCommand(
                    stem,
                    answer,
                    explanation,
                    type,
                    options == null ? List.of() : options.stream()
                            .map(option -> new QuestionDraftCommand.OptionCommand(option.label(), option.content()))
                            .toList()
            );
        }
    }

    public record CandidateBatchDraftRequest(
            @NotEmpty List<UUID> candidateIds,
            @NotBlank String subjectCode,
            @NotBlank String chapterCode,
            @NotBlank String difficulty,
            @NotBlank String source,
            Integer sourceYear,
            BigDecimal score,
            @NotEmpty List<@NotBlank String> knowledgePointCodes,
            List<String> tags
    ) {
        private WorkbenchContentService.CandidateDraftDefaults toDefaults() {
            return new WorkbenchContentService.CandidateDraftDefaults(
                    subjectCode,
                    chapterCode,
                    difficulty,
                    source,
                    sourceYear,
                    score,
                    knowledgePointCodes,
                    tags
            );
        }
    }

    private String primaryWorkbenchRole(UUID userId) {
        var roles = userRoleService.roles(userId);
        if (roles.contains("ADMIN")) {
            return "ADMIN";
        }
        if (roles.contains("REVIEWER")) {
            return "REVIEWER";
        }
        return "AUTHOR";
    }
}
