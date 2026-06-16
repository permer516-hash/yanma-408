package com.yanma408.question.application.query;

public record AdminQuestionSearchFilter(
        String subjectCode,
        String status,
        String reviewStatus,
        String difficulty,
        String source,
        String keyword,
        int page,
        int size
) {
    public int normalizedPage() {
        return Math.max(0, page);
    }

    public int normalizedSize() {
        return Math.min(100, Math.max(1, size <= 0 ? 30 : size));
    }
}
