package com.yanma408.question.interfaces.rest;

import com.yanma408.question.application.command.CreateQuestionCommand;
import com.yanma408.question.application.command.QuestionCommandService;
import com.yanma408.question.application.query.QuestionDetail;
import com.yanma408.question.application.query.QuestionPage;
import com.yanma408.question.application.query.QuestionQueryService;
import com.yanma408.question.application.query.QuestionSearchFilter;
import com.yanma408.question.application.query.QuestionSummary;
import com.yanma408.shared.exception.ResourceNotFoundException;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/questions")
public class QuestionController {
    private final QuestionQueryService questionQueryService;
    private final QuestionCommandService questionCommandService;

    public QuestionController(QuestionQueryService questionQueryService, QuestionCommandService questionCommandService) {
        this.questionQueryService = questionQueryService;
        this.questionCommandService = questionCommandService;
    }

    @GetMapping
    public List<QuestionSummary> list(@RequestParam(required = false) String subject) {
        return questionQueryService.listPublished(subject);
    }

    @GetMapping("/search")
    public QuestionPage search(
            @RequestParam(required = false) String subject,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String difficulty,
            @RequestParam(required = false) String knowledgePoint,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        return questionQueryService.searchPublished(
                new QuestionSearchFilter(subject, keyword, difficulty, knowledgePoint, page, size)
        );
    }

    @GetMapping("/{id}")
    public QuestionDetail detail(@PathVariable UUID id) {
        return questionQueryService.findPublishedDetail(id)
                .orElseThrow(() -> new ResourceNotFoundException("Question not found: " + id));
    }

    @PostMapping
    public QuestionDetail create(@Valid @RequestBody CreateQuestionRequest request) {
        var id = questionCommandService.create(request.toCommand());
        return questionQueryService.findPublishedDetail(id)
                .orElseThrow(() -> new ResourceNotFoundException("Question not found: " + id));
    }

    public record CreateQuestionRequest(
            @NotBlank String subjectCode,
            @NotBlank String chapterCode,
            @NotBlank String type,
            @NotBlank String difficulty,
            @NotBlank @Size(max = 4000) String stem,
            @NotBlank String answer,
            @NotBlank @Size(max = 4000) String explanation,
            @NotBlank String source,
            Integer sourceYear,
            BigDecimal score,
            String stemFormat,
            String stemImageUrl,
            @NotEmpty List<@Valid OptionRequest> options,
            @NotEmpty List<@NotBlank String> knowledgePointCodes,
            List<String> tags
    ) {
        private CreateQuestionCommand toCommand() {
            return new CreateQuestionCommand(
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
                    options.stream()
                            .map(option -> new CreateQuestionCommand.OptionCommand(option.label(), option.content()))
                            .toList(),
                    knowledgePointCodes,
                    tags
            );
        }
    }

    public record OptionRequest(
            @NotBlank String label,
            @NotBlank String content
    ) {
    }
}
