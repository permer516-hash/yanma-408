CREATE TABLE exam_attempts (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES app_users(id) ON DELETE CASCADE,
    exam_paper_id UUID NOT NULL REFERENCES exam_papers(id) ON DELETE CASCADE,
    status VARCHAR(32) NOT NULL,
    started_at TIMESTAMP NOT NULL,
    submitted_at TIMESTAMP,
    duration_seconds INTEGER,
    total_score NUMERIC(6, 2) NOT NULL,
    scored_points NUMERIC(6, 2) NOT NULL,
    correct_count INTEGER NOT NULL,
    question_count INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE exam_attempt_answers (
    id UUID PRIMARY KEY,
    exam_attempt_id UUID NOT NULL REFERENCES exam_attempts(id) ON DELETE CASCADE,
    question_id UUID NOT NULL REFERENCES questions(id),
    submitted_answer TEXT NOT NULL,
    correct_answer TEXT NOT NULL,
    correct BOOLEAN NOT NULL,
    score NUMERIC(5, 2) NOT NULL,
    earned_score NUMERIC(5, 2) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    UNIQUE (exam_attempt_id, question_id)
);

CREATE INDEX idx_exam_attempts_user_paper ON exam_attempts(user_id, exam_paper_id);
CREATE INDEX idx_exam_attempt_answers_attempt ON exam_attempt_answers(exam_attempt_id);

ALTER TABLE study_plan_tasks
    ADD COLUMN recurrence_rule VARCHAR(32) NOT NULL DEFAULT 'NONE';

ALTER TABLE study_plan_tasks
    ADD COLUMN reminder_time TIME;
