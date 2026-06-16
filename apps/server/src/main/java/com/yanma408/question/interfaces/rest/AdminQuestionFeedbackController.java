package com.yanma408.question.interfaces.rest;

import com.yanma408.question.application.feedback.QuestionFeedbackPage;
import com.yanma408.question.application.feedback.QuestionFeedbackService;
import com.yanma408.question.application.feedback.QuestionFeedbackView;
import com.yanma408.shared.application.security.CurrentUserProvider;
import com.yanma408.shared.application.security.UserRoleService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequestMapping("/admin/question-feedbacks")
public class AdminQuestionFeedbackController {
    private final QuestionFeedbackService questionFeedbackService;
    private final CurrentUserProvider currentUserProvider;
    private final UserRoleService userRoleService;

    public AdminQuestionFeedbackController(
            QuestionFeedbackService questionFeedbackService,
            CurrentUserProvider currentUserProvider,
            UserRoleService userRoleService
    ) {
        this.questionFeedbackService = questionFeedbackService;
        this.currentUserProvider = currentUserProvider;
        this.userRoleService = userRoleService;
    }

    @GetMapping
    public QuestionFeedbackPage list(
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String issueType,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "30") int size
    ) {
        requireAdmin();
        return questionFeedbackService.list(status, issueType, page, size);
    }

    @PatchMapping("/{id}/status")
    public QuestionFeedbackView updateStatus(
            @PathVariable UUID id,
            @Valid @RequestBody UpdateQuestionFeedbackStatusRequest request
    ) {
        requireAdmin();
        return questionFeedbackService.updateStatus(
                id,
                currentUserProvider.currentUserId(),
                request.status(),
                request.adminNote()
        );
    }

    private void requireAdmin() {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "ADMIN");
    }

    public record UpdateQuestionFeedbackStatusRequest(
            @NotBlank String status,
            @Size(max = 1000) String adminNote
    ) {
    }
}
