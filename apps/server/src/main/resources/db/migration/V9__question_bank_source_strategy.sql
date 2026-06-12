UPDATE questions
SET source = CASE
    WHEN source IN ('真题', '历年真题', 'REAL_EXAM') THEN 'PAST_EXAM'
    WHEN source IN ('模拟', '模拟题', 'SIMULATION') THEN 'MOCK'
    WHEN source IN ('原创', '原创题') THEN 'ORIGINAL'
    ELSE source
END;

UPDATE questions
SET difficulty = CASE
    WHEN difficulty IN ('基础', '简单') THEN 'BASIC'
    WHEN difficulty = '中等' THEN 'MEDIUM'
    WHEN difficulty = '困难' THEN 'HARD'
    ELSE difficulty
END;

ALTER TABLE questions
    ADD CONSTRAINT chk_questions_source
    CHECK (source IN ('PAST_EXAM', 'MOCK', 'ORIGINAL'));

ALTER TABLE questions
    ADD CONSTRAINT chk_questions_difficulty
    CHECK (difficulty IN ('BASIC', 'MEDIUM', 'HARD'));

CREATE INDEX idx_questions_source ON questions(source);
