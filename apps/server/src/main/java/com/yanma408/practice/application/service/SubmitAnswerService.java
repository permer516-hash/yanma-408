package com.yanma408.practice.application.service;

import com.yanma408.mistake.application.service.MistakeService;
import com.yanma408.practice.application.command.SubmitAnswerCommand;
import com.yanma408.practice.application.command.SubmitAnswerResult;
import com.yanma408.practice.domain.model.PracticeAttempt;
import com.yanma408.practice.domain.repository.PracticeAttemptRepository;
import com.yanma408.question.domain.repository.QuestionAnswerRepository;
import com.yanma408.shared.exception.ResourceNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.UUID;

@Service
public class SubmitAnswerService {
    private final QuestionAnswerRepository questionAnswerRepository;
    private final PracticeAttemptRepository practiceAttemptRepository;
    private final MistakeService mistakeService;
    private final AnswerJudgementService answerJudgementService;

    public SubmitAnswerService(
            QuestionAnswerRepository questionAnswerRepository,
            PracticeAttemptRepository practiceAttemptRepository,
            MistakeService mistakeService,
            AnswerJudgementService answerJudgementService
    ) {
        this.questionAnswerRepository = questionAnswerRepository;
        this.practiceAttemptRepository = practiceAttemptRepository;
        this.mistakeService = mistakeService;
        this.answerJudgementService = answerJudgementService;
    }

    @Transactional
    public SubmitAnswerResult submit(SubmitAnswerCommand command) {
        var answer = questionAnswerRepository.findPublishedAnswer(command.questionId())
                .orElseThrow(() -> new ResourceNotFoundException("Question not found: " + command.questionId()));
        var correct = answerJudgementService.judge(command.submittedAnswer(), answer.correctAnswer());
        var now = Instant.now();
        var attempt = new PracticeAttempt(
                UUID.randomUUID(),
                command.userId(),
                command.questionId(),
                command.submittedAnswer().trim(),
                answer.correctAnswer(),
                correct,
                command.elapsed(),
                now
        );

        practiceAttemptRepository.save(attempt);

        var mistakeUpdate = attempt.shouldEnterMistakeBook()
                ? mistakeService.recordWrongAttempt(attempt)
                : mistakeService.markMastered(command.userId(), command.questionId());

        return new SubmitAnswerResult(
                attempt.id(),
                attempt.questionId(),
                attempt.submittedAnswer(),
                attempt.correctAnswer(),
                attempt.correct(),
                mistakeUpdate.enteredMistakeBook(),
                mistakeUpdate.wrongCount(),
                answer.explanation(),
                attempt.submittedAt()
        );
    }
}
