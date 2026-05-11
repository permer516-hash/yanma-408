package com.yanma408.exam.application.query;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class ExamPaperQueryService {
    private final ExamPaperQueryRepository examPaperQueryRepository;

    public ExamPaperQueryService(ExamPaperQueryRepository examPaperQueryRepository) {
        this.examPaperQueryRepository = examPaperQueryRepository;
    }

    public List<ExamPaperSummary> listPublished() {
        return examPaperQueryRepository.findPublished();
    }

    public Optional<ExamPaperDetail> findPublishedDetail(UUID id) {
        return examPaperQueryRepository.findPublishedDetail(id);
    }
}
