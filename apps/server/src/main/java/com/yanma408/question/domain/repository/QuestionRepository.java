package com.yanma408.question.domain.repository;

import com.yanma408.question.domain.model.Question;
import com.yanma408.question.domain.model.QuestionId;

import java.util.Optional;

public interface QuestionRepository {

    Optional<Question> findById(QuestionId id);

    Question save(Question question);
}
