package com.yanma408.mistake.application.query;

public record MistakeFilter(
        String subjectCode,
        Boolean mastered,
        String sort
) {
    public MistakeFilter(String subjectCode, Boolean mastered) {
        this(subjectCode, mastered, "LATEST");
    }
}
