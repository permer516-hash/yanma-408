package com.yanma408.practice.application.service;

import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.stream.Collectors;

@Service
public class AnswerJudgementService {

    public boolean judge(String submittedAnswer, String correctAnswer) {
        return normalize(submittedAnswer).equals(normalize(correctAnswer));
    }

    private String normalize(String answer) {
        if (answer == null) {
            return "";
        }
        return Arrays.stream(answer.trim().toUpperCase().split("[,，\\s]+"))
                .filter(part -> !part.isBlank())
                .sorted()
                .collect(Collectors.joining(","));
    }
}
