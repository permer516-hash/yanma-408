package com.yanma408.comprehensive.application;

import com.yanma408.question.application.command.CreateQuestionCommand;
import com.yanma408.question.application.command.QuestionCommandService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
public class ComprehensiveQuestionAuthoringService {
    private final QuestionCommandService questionCommandService;
    private final ComprehensiveQuestionService comprehensiveQuestionService;

    public ComprehensiveQuestionAuthoringService(
            QuestionCommandService questionCommandService,
            ComprehensiveQuestionService comprehensiveQuestionService
    ) {
        this.questionCommandService = questionCommandService;
        this.comprehensiveQuestionService = comprehensiveQuestionService;
    }

    @Transactional
    public UUID create(CreateQuestionCommand command, List<ComprehensivePartCommand> parts) {
        var questionId = questionCommandService.create(command);
        comprehensiveQuestionService.replaceParts(questionId, parts);
        return questionId;
    }
}
