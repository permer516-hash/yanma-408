package com.yanma408.question.interfaces.rest;

import com.yanma408.question.application.importrecord.QuestionImportBatchDetail;
import com.yanma408.question.application.importrecord.QuestionImportBatchPage;
import com.yanma408.question.application.importrecord.QuestionImportRecordService;
import com.yanma408.shared.application.security.CurrentUserProvider;
import com.yanma408.shared.application.security.UserRoleService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequestMapping("/admin/question-imports")
public class AdminQuestionImportRecordController {
    private final QuestionImportRecordService importRecordService;
    private final CurrentUserProvider currentUserProvider;
    private final UserRoleService userRoleService;

    public AdminQuestionImportRecordController(
            QuestionImportRecordService importRecordService,
            CurrentUserProvider currentUserProvider,
            UserRoleService userRoleService
    ) {
        this.importRecordService = importRecordService;
        this.currentUserProvider = currentUserProvider;
        this.userRoleService = userRoleService;
    }

    @GetMapping
    public QuestionImportBatchPage list(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size
    ) {
        requireAdmin();
        return importRecordService.list(page, size);
    }

    @GetMapping("/{id}")
    public QuestionImportBatchDetail detail(@PathVariable UUID id) {
        requireAdmin();
        return importRecordService.find(id);
    }

    private void requireAdmin() {
        userRoleService.requireAny(currentUserProvider.currentUserId(), "ADMIN");
    }
}
