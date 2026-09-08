package com.yanma408.question.application.query;

import com.yanma408.comprehensive.application.ComprehensiveQuestionService;
import com.yanma408.question.domain.repository.QuestionQueryRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class QuestionQueryService {
    private final QuestionQueryRepository questionQueryRepository;
    private final ComprehensiveQuestionService comprehensiveQuestionService;

    public QuestionQueryService(
            QuestionQueryRepository questionQueryRepository,
            ComprehensiveQuestionService comprehensiveQuestionService
    ) {
        this.questionQueryRepository = questionQueryRepository;
        this.comprehensiveQuestionService = comprehensiveQuestionService;
    }

    public List<QuestionSummary> listPublished(String subjectCode) {
        return questionQueryRepository.findPublished(subjectCode);
    }

    public QuestionPage searchPublished(QuestionSearchFilter filter) {
        return questionQueryRepository.searchPublished(filter);
    }

    public QuestionPage searchAll(AdminQuestionSearchFilter filter) {
        return questionQueryRepository.searchAll(filter);
    }

    public Optional<QuestionDetail> findPublishedDetail(UUID id) {
        return questionQueryRepository.findPublishedDetail(id).map(this::enrichComprehensiveParts);
    }

    public Optional<QuestionDetail> findDetail(UUID id) {
        return questionQueryRepository.findDetail(id).map(this::enrichComprehensiveParts);
    }

    private QuestionDetail enrichComprehensiveParts(QuestionDetail detail) {
        if (!"COMPREHENSIVE".equals(detail.type())) {
            return detail;
        }
        return detail.withComprehensiveParts(comprehensiveQuestionService.findParts(detail.id()));
    }
}
