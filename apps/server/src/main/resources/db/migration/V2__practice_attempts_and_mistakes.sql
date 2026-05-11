CREATE TABLE practice_attempts (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    question_id UUID NOT NULL REFERENCES questions(id),
    submitted_answer TEXT NOT NULL,
    correct_answer TEXT NOT NULL,
    correct BOOLEAN NOT NULL,
    elapsed_seconds INTEGER NOT NULL,
    submitted_at TIMESTAMP NOT NULL
);

CREATE TABLE mistakes (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    question_id UUID NOT NULL REFERENCES questions(id),
    first_wrong_attempt_id UUID NOT NULL REFERENCES practice_attempts(id),
    latest_wrong_attempt_id UUID NOT NULL REFERENCES practice_attempts(id),
    wrong_count INTEGER NOT NULL,
    mastered BOOLEAN NOT NULL,
    reason VARCHAR(64),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    UNIQUE (user_id, question_id)
);

CREATE INDEX idx_practice_attempts_user ON practice_attempts(user_id);
CREATE INDEX idx_practice_attempts_question ON practice_attempts(question_id);
CREATE INDEX idx_mistakes_user ON mistakes(user_id);
CREATE INDEX idx_mistakes_question ON mistakes(question_id);
