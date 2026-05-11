package com.yanma408.practice.interfaces.rest;

import com.yanma408.practice.application.command.SubmitAnswerCommand;
import com.yanma408.practice.application.command.SubmitAnswerResult;
import com.yanma408.practice.application.service.SubmitAnswerService;
import com.yanma408.shared.application.security.CurrentUserProvider;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Duration;
import java.util.UUID;

@RestController
@RequestMapping("/practice")
public class PracticeController {
    private final SubmitAnswerService submitAnswerService;
    private final CurrentUserProvider currentUserProvider;

    public PracticeController(SubmitAnswerService submitAnswerService, CurrentUserProvider currentUserProvider) {
        this.submitAnswerService = submitAnswerService;
        this.currentUserProvider = currentUserProvider;
    }

    @PostMapping("/attempts")
    public SubmitAnswerResult submit(@Valid @RequestBody SubmitAnswerRequest request) {
        var command = new SubmitAnswerCommand(
                currentUserProvider.currentUserId(),
                request.questionId(),
                request.submittedAnswer(),
                Duration.ofSeconds(request.elapsedSeconds())
        );
        return submitAnswerService.submit(command);
    }

    public record SubmitAnswerRequest(
            @NotNull UUID questionId,
            @NotBlank String submittedAnswer,
            @Min(0) @Max(Integer.MAX_VALUE) long elapsedSeconds
    ) {
    }
}
