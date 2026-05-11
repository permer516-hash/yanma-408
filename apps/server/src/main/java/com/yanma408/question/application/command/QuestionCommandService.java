package com.yanma408.question.application.command;

import com.yanma408.question.domain.model.Difficulty;
import com.yanma408.question.domain.model.QuestionType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Service
public class QuestionCommandService {
    private static final Set<String> ALLOWED_STATUSES = Set.of("PUBLISHED", "DRAFT");
    private static final Set<String> ALLOWED_REVIEW_STATUSES = Set.of("PENDING", "APPROVED", "REJECTED");
    private static final Set<String> ALLOWED_STEM_FORMATS = Set.of("PLAIN_TEXT", "MARKDOWN", "HTML");

    private final QuestionCommandRepository questionCommandRepository;

    public QuestionCommandService(QuestionCommandRepository questionCommandRepository) {
        this.questionCommandRepository = questionCommandRepository;
    }

    @Transactional
    public UUID create(CreateQuestionCommand command) {
        validate(command);
        return questionCommandRepository.create(normalize(command));
    }

    @Transactional
    public void update(UUID questionId, CreateQuestionCommand command) {
        validate(command);
        questionCommandRepository.update(questionId, normalize(command));
    }

    @Transactional
    public void updateStatus(UUID questionId, String status) {
        var normalizedStatus = status.trim().toUpperCase();
        if (!ALLOWED_STATUSES.contains(normalizedStatus)) {
            throw new IllegalArgumentException("Unsupported question status: " + status);
        }
        questionCommandRepository.updateStatus(questionId, normalizedStatus);
    }

    @Transactional
    public void updateReviewStatus(UUID questionId, String reviewStatus, String reviewNote) {
        var normalizedReviewStatus = normalizeAllowed(reviewStatus, ALLOWED_REVIEW_STATUSES, "reviewStatus");
        questionCommandRepository.updateReviewStatus(
                questionId,
                normalizedReviewStatus,
                reviewNote == null || reviewNote.isBlank() ? null : reviewNote.trim()
        );
    }

    @Transactional
    public void bulkUpdate(List<UUID> questionIds, String status, String reviewStatus, List<String> tags) {
        if (questionIds == null || questionIds.isEmpty()) {
            throw new IllegalArgumentException("At least one question is required");
        }
        var normalizedStatus = status == null || status.isBlank()
                ? null
                : normalizeAllowed(status, ALLOWED_STATUSES, "status");
        var normalizedReviewStatus = reviewStatus == null || reviewStatus.isBlank()
                ? null
                : normalizeAllowed(reviewStatus, ALLOWED_REVIEW_STATUSES, "reviewStatus");
        var normalizedTags = tags == null
                ? null
                : tags.stream().map(String::trim).filter(tag -> !tag.isBlank()).distinct().toList();
        questionCommandRepository.bulkUpdate(questionIds, normalizedStatus, normalizedReviewStatus, normalizedTags);
    }

    @Transactional
    public void delete(UUID questionId) {
        questionCommandRepository.delete(questionId);
    }

    @Transactional
    public List<UUID> bulkCreate(List<CreateQuestionCommand> commands) {
        if (commands == null || commands.isEmpty()) {
            throw new IllegalArgumentException("At least one question is required");
        }
        return commands.stream()
                .map(command -> {
                    validate(command);
                    return questionCommandRepository.create(normalize(command));
                })
                .toList();
    }

    public QuestionImportValidationResult validateImport(List<CreateQuestionCommand> commands) {
        if (commands == null || commands.isEmpty()) {
            throw new IllegalArgumentException("At least one question is required");
        }
        var errors = new ArrayList<QuestionImportValidationResult.RowError>();
        for (int index = 0; index < commands.size(); index++) {
            try {
                validate(commands.get(index));
                questionCommandRepository.validateReferences(normalize(commands.get(index)));
            } catch (RuntimeException exception) {
                errors.add(new QuestionImportValidationResult.RowError(
                        index + 1,
                        inferField(exception.getMessage()),
                        exception.getMessage()
                ));
            }
        }
        return new QuestionImportValidationResult(
                commands.size(),
                commands.size() - errors.size(),
                errors.size(),
                errors
        );
    }

    private void validate(CreateQuestionCommand command) {
        requireText(command.subjectCode(), "subjectCode");
        requireText(command.chapterCode(), "chapterCode");
        requireText(command.type(), "type");
        requireText(command.difficulty(), "difficulty");
        requireText(command.stem(), "stem");
        requireText(command.answer(), "answer");
        requireText(command.explanation(), "explanation");
        requireText(command.source(), "source");
        QuestionType.valueOf(command.type().trim().toUpperCase());
        Difficulty.valueOf(command.difficulty().trim().toUpperCase());
        if (command.options() == null || command.options().size() < 2) {
            throw new IllegalArgumentException("At least two options are required");
        }
        for (CreateQuestionCommand.OptionCommand option : command.options()) {
            requireText(option.label(), "option.label");
            requireText(option.content(), "option.content");
        }
        if (command.knowledgePointCodes() == null || command.knowledgePointCodes().isEmpty()) {
            throw new IllegalArgumentException("At least one knowledge point is required");
        }
    }

    private void requireText(String value, String fieldName) {
        if (value == null || value.isBlank()) {
            throw new IllegalArgumentException(fieldName + " is required");
        }
    }

    private CreateQuestionCommand normalize(CreateQuestionCommand command) {
        return new CreateQuestionCommand(
                command.subjectCode().trim().toUpperCase(),
                command.chapterCode().trim().toUpperCase(),
                command.type().trim().toUpperCase(),
                command.difficulty().trim().toUpperCase(),
                command.stem().trim(),
                command.answer().trim().toUpperCase(),
                command.explanation().trim(),
                command.source().trim().toUpperCase(),
                command.sourceYear(),
                command.score() == null ? BigDecimal.valueOf(2) : command.score(),
                command.stemFormat() == null || command.stemFormat().isBlank()
                        ? "PLAIN_TEXT"
                        : normalizeAllowed(command.stemFormat(), ALLOWED_STEM_FORMATS, "stemFormat"),
                command.stemImageUrl() == null || command.stemImageUrl().isBlank() ? null : command.stemImageUrl().trim(),
                command.options().stream()
                        .map(option -> new CreateQuestionCommand.OptionCommand(
                                option.label().trim().toUpperCase(),
                                option.content().trim()
                        ))
                        .toList(),
                command.knowledgePointCodes().stream()
                        .map(code -> code.trim().toUpperCase())
                        .toList(),
                command.tags() == null
                        ? List.of()
                        : command.tags().stream().map(String::trim).filter(tag -> !tag.isBlank()).distinct().toList()
        );
    }

    private String normalizeAllowed(String value, Set<String> allowedValues, String fieldName) {
        var normalized = value.trim().toUpperCase();
        if (!allowedValues.contains(normalized)) {
            throw new IllegalArgumentException("Unsupported " + fieldName + ": " + value);
        }
        return normalized;
    }

    private String inferField(String message) {
        if (message == null || message.isBlank()) {
            return "row";
        }
        if (message.contains(":")) {
            return message.substring(0, message.indexOf(":")).replace(" not found", "").trim();
        }
        if (message.contains(" ")) {
            return message.substring(0, message.indexOf(" ")).trim();
        }
        return "row";
    }
}
