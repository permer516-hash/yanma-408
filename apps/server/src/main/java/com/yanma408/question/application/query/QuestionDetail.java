package com.yanma408.question.application.query;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

public record QuestionDetail(
        UUID id,
        String subjectCode,
        String subjectName,
        String chapterCode,
        String chapterName,
        String type,
        String difficulty,
        String stem,
        String answer,
        String explanation,
        String source,
        Integer sourceYear,
        BigDecimal score,
        String status,
        String reviewStatus,
        String reviewNote,
        String stemFormat,
        String stemImageUrl,
        List<String> tags,
        List<QuestionOptionView> options,
        List<KnowledgePointView> knowledgePoints,
        List<ComprehensivePartView> comprehensiveParts
) {
    public QuestionDetail withComprehensiveParts(List<ComprehensivePartView> parts) {
        return new QuestionDetail(
                id, subjectCode, subjectName, chapterCode, chapterName, type, difficulty, stem, answer, explanation,
                source, sourceYear, score, status, reviewStatus, reviewNote, stemFormat, stemImageUrl, tags, options,
                knowledgePoints, parts
        );
    }
}
