package com.yanma408.question.application.command;

import java.util.List;

public record QuestionImportValidationResult(
        int totalRows,
        int validRows,
        int invalidRows,
        List<RowError> errors
) {
    public record RowError(
            int rowNumber,
            String field,
            String message
    ) {
    }
}
