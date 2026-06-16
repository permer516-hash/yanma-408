package com.yanma408.question.domain.repository;

import com.yanma408.question.application.query.AdminQuestionSearchFilter;
import com.yanma408.question.application.query.QuestionDetail;
import com.yanma408.question.application.query.QuestionPage;
import com.yanma408.question.application.query.QuestionSearchFilter;
import com.yanma408.question.application.query.QuestionSummary;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface QuestionQueryRepository {

    List<QuestionSummary> findPublished(String subjectCode);

    QuestionPage searchPublished(QuestionSearchFilter filter);

    QuestionPage searchAll(AdminQuestionSearchFilter filter);

    Optional<QuestionDetail> findPublishedDetail(UUID id);

    Optional<QuestionDetail> findDetail(UUID id);
}
