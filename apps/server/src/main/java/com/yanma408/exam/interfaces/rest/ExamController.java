package com.yanma408.exam.interfaces.rest;

import com.yanma408.exam.application.attempt.ExamAttemptComparison;
import com.yanma408.exam.application.attempt.ExamAttemptReport;
import com.yanma408.exam.application.attempt.ExamAttemptService;
import com.yanma408.exam.application.attempt.ExamAttemptSummary;
import com.yanma408.exam.application.attempt.ExamAttemptView;
import com.yanma408.exam.application.attempt.ExamReportOverview;
import com.yanma408.exam.application.query.ExamPaperDetail;
import com.yanma408.exam.application.query.ExamPaperQueryService;
import com.yanma408.exam.application.query.ExamPaperSummary;
import com.yanma408.shared.application.security.CurrentUserProvider;
import com.yanma408.shared.exception.ResourceNotFoundException;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/exams")
public class ExamController {
    private final CurrentUserProvider currentUserProvider;
    private final ExamPaperQueryService examPaperQueryService;
    private final ExamAttemptService examAttemptService;

    public ExamController(
            CurrentUserProvider currentUserProvider,
            ExamPaperQueryService examPaperQueryService,
            ExamAttemptService examAttemptService
    ) {
        this.currentUserProvider = currentUserProvider;
        this.examPaperQueryService = examPaperQueryService;
        this.examAttemptService = examAttemptService;
    }

    @GetMapping
    public List<ExamPaperSummary> list() {
        return examPaperQueryService.listPublished();
    }

    @GetMapping("/{id}")
    public ExamPaperDetail detail(@PathVariable UUID id) {
        return examPaperQueryService.findPublishedDetail(id)
                .orElseThrow(() -> new ResourceNotFoundException("Exam paper not found: " + id));
    }

    @PostMapping("/{id}/attempts")
    public ExamAttemptView startAttempt(@PathVariable UUID id) {
        return examAttemptService.start(currentUserProvider.currentUserId(), id);
    }

    @PostMapping("/attempts/{id}/submit")
    public ExamAttemptReport submitAttempt(
            @PathVariable UUID id,
            @Valid @RequestBody SubmitExamAttemptRequest request
    ) {
        return examAttemptService.submit(
                currentUserProvider.currentUserId(),
                id,
                request.answers(),
                request.durationSeconds()
        );
    }

    @GetMapping("/attempts/{id}/report")
    public ExamAttemptReport attemptReport(@PathVariable UUID id) {
        return examAttemptService.report(currentUserProvider.currentUserId(), id);
    }

    @GetMapping("/attempts")
    public List<ExamAttemptSummary> attemptHistory(@RequestParam(required = false) UUID paperId) {
        return examAttemptService.history(currentUserProvider.currentUserId(), paperId);
    }

    @GetMapping("/reports/overview")
    public ExamReportOverview reportOverview() {
        return examAttemptService.overview(currentUserProvider.currentUserId());
    }

    @GetMapping("/{id}/attempts")
    public List<ExamAttemptSummary> paperAttemptHistory(@PathVariable UUID id) {
        return examAttemptService.history(currentUserProvider.currentUserId(), id);
    }

    @GetMapping("/{id}/attempts/compare")
    public ExamAttemptComparison comparePaperAttempts(@PathVariable UUID id) {
        return examAttemptService.compareLatest(currentUserProvider.currentUserId(), id);
    }

    @PostMapping("/attempts/{id}/mistakes/backfill")
    public ExamAttemptService.BackfillMistakesResult backfillMistakes(@PathVariable UUID id) {
        return examAttemptService.backfillMistakes(currentUserProvider.currentUserId(), id);
    }

    public record SubmitExamAttemptRequest(
            @NotEmpty Map<UUID, String> answers,
            @Min(0) @Max(2147483647) int durationSeconds
    ) {
    }
}
