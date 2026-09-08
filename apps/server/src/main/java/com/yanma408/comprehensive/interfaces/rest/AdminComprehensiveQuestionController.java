package com.yanma408.comprehensive.interfaces.rest;

import com.yanma408.comprehensive.application.ComprehensivePartCommand;
import com.yanma408.comprehensive.application.ComprehensiveQuestionAuthoringService;
import com.yanma408.question.application.command.CreateQuestionCommand;
import com.yanma408.question.application.query.QuestionDetail;
import com.yanma408.question.application.query.QuestionQueryService;
import com.yanma408.shared.application.security.CurrentUserProvider;
import com.yanma408.shared.application.security.UserRoleService;
import com.yanma408.shared.exception.ResourceNotFoundException;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.util.List;

@RestController
@RequestMapping("/admin/comprehensive-questions")
public class AdminComprehensiveQuestionController {
    private final ComprehensiveQuestionAuthoringService authoringService;
    private final QuestionQueryService questionQueryService;
    private final CurrentUserProvider currentUserProvider;
    private final UserRoleService userRoleService;

    public AdminComprehensiveQuestionController(
            ComprehensiveQuestionAuthoringService authoringService,
            QuestionQueryService questionQueryService,
            CurrentUserProvider currentUserProvider,
            UserRoleService userRoleService
    ) {
        this.authoringService = authoringService;
        this.questionQueryService = questionQueryService;
        this.currentUserProvider = currentUserProvider;
        this.userRoleService = userRoleService;
    }

    @PostMapping
    public QuestionDetail create(@Valid @RequestBody ComprehensiveQuestionRequest request) {
        requireAdmin();
        return resolve(authoringService.create(request.toParentCommand(), request.toPartCommands()));
    }

    @PostMapping("/import")
    public List<QuestionDetail> importQuestions(@Valid @RequestBody BulkComprehensiveQuestionRequest request) {
        requireAdmin();
        return request.questions().stream()
                .map(item -> resolve(authoringService.create(item.toParentCommand(), item.toPartCommands())))
                .toList();
    }

    private QuestionDetail resolve(java.util.UUID id) {
        return questionQueryService.findDetail(id)
                .orElseThrow(() -> new ResourceNotFoundException("Question not found: " + id));
    }

    private void requireAdmin() {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "ADMIN");
    }

    public record BulkComprehensiveQuestionRequest(@NotEmpty List<@Valid ComprehensiveQuestionRequest> questions) {
    }

    public record ComprehensiveQuestionRequest(
            @NotBlank String subjectCode,
            @NotBlank String chapterCode,
            @NotBlank String difficulty,
            @NotBlank String stem,
            @NotBlank String source,
            Integer sourceYear,
            @NotNull BigDecimal score,
            String stemFormat,
            String stemImageUrl,
            @NotEmpty List<@NotBlank String> knowledgePointCodes,
            List<String> tags,
            @NotEmpty List<@Valid PartRequest> parts
    ) {
        CreateQuestionCommand toParentCommand() {
            return new CreateQuestionCommand(
                    subjectCode, chapterCode, "COMPREHENSIVE", difficulty, stem,
                    "见各小问标准答案", "见各小问解析", source, sourceYear, score,
                    stemFormat, stemImageUrl, List.of(), knowledgePointCodes, tags
            );
        }

        List<ComprehensivePartCommand> toPartCommands() {
            return parts.stream().map(PartRequest::toCommand).toList();
        }
    }

    public record PartRequest(
            @NotBlank String prompt,
            @NotBlank String responseMode,
            @NotBlank String referenceAnswer,
            @NotBlank String explanation,
            @NotNull BigDecimal score,
            String imageUrl,
            @NotEmpty List<@Valid RubricRequest> rubrics
    ) {
        ComprehensivePartCommand toCommand() {
            return new ComprehensivePartCommand(
                    prompt, responseMode, referenceAnswer, explanation, score, imageUrl,
                    rubrics.stream().map(item -> new ComprehensivePartCommand.RubricCommand(item.criterion(), item.score())).toList()
            );
        }
    }

    public record RubricRequest(@NotBlank String criterion, @NotNull BigDecimal score) {
    }
}
