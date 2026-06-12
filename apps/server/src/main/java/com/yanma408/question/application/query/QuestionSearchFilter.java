package com.yanma408.question.application.query;

public record QuestionSearchFilter(
        String subjectCode,
        String keyword,
        String difficulty,
        String source,
        String knowledgePoint,
        int page,
        int size
) {
    public int normalizedPage() {
        return Math.max(0, page);
    }

    public int normalizedSize() {
        return Math.min(50, Math.max(1, size <= 0 ? 10 : size));
    }
}
