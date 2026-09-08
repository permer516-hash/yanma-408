package com.yanma408.comprehensive.interfaces.rest;

import com.yanma408.comprehensive.application.ComprehensiveAttemptService;
import com.yanma408.comprehensive.application.ComprehensiveAttemptView;
import com.yanma408.comprehensive.application.ComprehensiveGradingQueueItemView;
import com.yanma408.shared.application.security.CurrentUserProvider;
import com.yanma408.shared.application.security.UserRoleService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/teacher/comprehensive-attempts")
public class TeacherComprehensiveGradingController {
    private final ComprehensiveAttemptService attemptService;
    private final CurrentUserProvider currentUserProvider;
    private final UserRoleService userRoleService;

    public TeacherComprehensiveGradingController(
            ComprehensiveAttemptService attemptService,
            CurrentUserProvider currentUserProvider,
            UserRoleService userRoleService
    ) {
        this.attemptService = attemptService;
        this.currentUserProvider = currentUserProvider;
        this.userRoleService = userRoleService;
    }

    @GetMapping("/pending")
    public List<ComprehensiveGradingQueueItemView> pending() {
        var userId = currentUserProvider.currentUserId();
        var roles = userRoleService.roles(userId);
        if (!roles.contains("ADMIN") && !roles.contains("TEACHER")) {
            userRoleService.requireAny(userId, "TEACHER", "ADMIN");
        }
        return attemptService.findPendingForReviewer(userId, roles.contains("ADMIN"));
    }

    @PostMapping("/{attemptId}/grade")
    public ComprehensiveAttemptView grade(@PathVariable UUID attemptId, @Valid @RequestBody GradeRequest request) {
        var userId = currentUserProvider.currentUserId();
        var roles = userRoleService.roles(userId);
        if (!roles.contains("ADMIN") && !roles.contains("TEACHER")) {
            userRoleService.requireAny(userId, "TEACHER", "ADMIN");
        }
        return attemptService.gradeManually(userId, roles.contains("ADMIN"), attemptId, request.toCommands(), request.note());
    }

    public record GradeRequest(@NotEmpty List<@Valid PartGradeRequest> grades, String note) {
        List<ComprehensiveAttemptService.ManualGradeCommand> toCommands() {
            return grades.stream().map(grade -> new ComprehensiveAttemptService.ManualGradeCommand(
                    grade.partId(), grade.score(), grade.feedback()
            )).toList();
        }
    }

    public record PartGradeRequest(@NotNull UUID partId, @NotNull BigDecimal score, String feedback) {
    }
}
