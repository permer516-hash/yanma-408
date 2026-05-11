package com.yanma408.mistake.interfaces.rest;

import com.yanma408.mistake.application.query.MistakeFilter;
import com.yanma408.mistake.application.query.MistakeQueryService;
import com.yanma408.mistake.application.query.MistakeSummary;
import com.yanma408.mistake.application.service.MistakeService;
import com.yanma408.shared.application.security.CurrentUserProvider;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/mistakes")
public class MistakeController {
    private final MistakeQueryService mistakeQueryService;
    private final MistakeService mistakeService;
    private final CurrentUserProvider currentUserProvider;

    public MistakeController(
            MistakeQueryService mistakeQueryService,
            MistakeService mistakeService,
            CurrentUserProvider currentUserProvider
    ) {
        this.mistakeQueryService = mistakeQueryService;
        this.mistakeService = mistakeService;
        this.currentUserProvider = currentUserProvider;
    }

    @GetMapping
    public List<MistakeSummary> findMine(
            @RequestParam(required = false) String subject,
            @RequestParam(required = false) Boolean mastered,
            @RequestParam(required = false) String sort
    ) {
        var filter = new MistakeFilter(subject, mastered, sort);
        return mistakeQueryService.findMine(currentUserProvider.currentUserId(), filter);
    }

    @GetMapping("/review-queue")
    public List<MistakeSummary> reviewQueue(@RequestParam(required = false) String subject) {
        return mistakeQueryService.findMine(
                currentUserProvider.currentUserId(),
                new MistakeFilter(subject, false, "PRIORITY")
        );
    }

    @PatchMapping("/{id}/mastery")
    public void updateMastery(
            @PathVariable UUID id,
            @Valid @RequestBody UpdateMasteryRequest request
    ) {
        mistakeService.updateMastered(currentUserProvider.currentUserId(), id, request.mastered());
    }

    public record UpdateMasteryRequest(@NotNull Boolean mastered) {
    }
}
