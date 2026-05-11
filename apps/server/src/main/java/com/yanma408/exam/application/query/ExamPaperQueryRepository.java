package com.yanma408.exam.application.query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ExamPaperQueryRepository {
    List<ExamPaperSummary> findPublished();

    Optional<ExamPaperDetail> findPublishedDetail(UUID id);
}
