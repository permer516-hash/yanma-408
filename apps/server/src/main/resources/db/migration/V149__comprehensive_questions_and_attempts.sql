CREATE TABLE comprehensive_question_parts (
    id UUID PRIMARY KEY,
    question_id UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
    sort_order INTEGER NOT NULL,
    prompt TEXT NOT NULL,
    response_mode VARCHAR(32) NOT NULL,
    reference_answer TEXT NOT NULL,
    explanation TEXT NOT NULL,
    score NUMERIC(5, 2) NOT NULL,
    image_url TEXT,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    UNIQUE (question_id, sort_order),
    CONSTRAINT chk_comprehensive_question_parts_response_mode
        CHECK (response_mode IN ('RICH_TEXT', 'PSEUDOCODE', 'CALCULATION', 'IMAGE')),
    CONSTRAINT chk_comprehensive_question_parts_score CHECK (score > 0)
);

CREATE TABLE comprehensive_part_rubrics (
    id UUID PRIMARY KEY,
    part_id UUID NOT NULL REFERENCES comprehensive_question_parts(id) ON DELETE CASCADE,
    sort_order INTEGER NOT NULL,
    criterion TEXT NOT NULL,
    score NUMERIC(5, 2) NOT NULL,
    UNIQUE (part_id, sort_order),
    CONSTRAINT chk_comprehensive_part_rubrics_score CHECK (score > 0)
);

CREATE TABLE comprehensive_attempts (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES app_users(id),
    question_id UUID NOT NULL REFERENCES questions(id),
    mode VARCHAR(32) NOT NULL,
    status VARCHAR(32) NOT NULL,
    elapsed_seconds INTEGER NOT NULL DEFAULT 0,
    submitted_at TIMESTAMP,
    finalized_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    CONSTRAINT chk_comprehensive_attempts_mode CHECK (mode IN ('DAILY_PRACTICE', 'MOCK_EXAM')),
    CONSTRAINT chk_comprehensive_attempts_status CHECK (status IN ('DRAFT', 'SUBMITTED', 'AI_SCORED', 'PENDING_MANUAL', 'REVIEW_REQUESTED', 'MANUALLY_SCORED', 'FINALIZED'))
);

CREATE TABLE comprehensive_part_responses (
    id UUID PRIMARY KEY,
    attempt_id UUID NOT NULL REFERENCES comprehensive_attempts(id) ON DELETE CASCADE,
    part_id UUID NOT NULL REFERENCES comprehensive_question_parts(id),
    content TEXT NOT NULL,
    attachment_urls TEXT NOT NULL DEFAULT '',
    updated_at TIMESTAMP NOT NULL,
    UNIQUE (attempt_id, part_id)
);

CREATE TABLE comprehensive_part_grades (
    id UUID PRIMARY KEY,
    attempt_id UUID NOT NULL REFERENCES comprehensive_attempts(id) ON DELETE CASCADE,
    part_id UUID NOT NULL REFERENCES comprehensive_question_parts(id),
    grader_type VARCHAR(32) NOT NULL,
    score NUMERIC(5, 2),
    feedback TEXT NOT NULL,
    model_name VARCHAR(128),
    created_at TIMESTAMP NOT NULL,
    CONSTRAINT chk_comprehensive_part_grades_type CHECK (grader_type IN ('AI', 'MANUAL'))
);

CREATE TABLE comprehensive_review_requests (
    id UUID PRIMARY KEY,
    attempt_id UUID NOT NULL REFERENCES comprehensive_attempts(id) ON DELETE CASCADE,
    student_message TEXT NOT NULL,
    status VARCHAR(32) NOT NULL,
    reviewer_id UUID REFERENCES app_users(id),
    reviewer_note TEXT,
    created_at TIMESTAMP NOT NULL,
    resolved_at TIMESTAMP,
    CONSTRAINT chk_comprehensive_review_requests_status CHECK (status IN ('PENDING', 'RESOLVED'))
);

CREATE INDEX idx_comprehensive_parts_question ON comprehensive_question_parts(question_id, sort_order);
CREATE INDEX idx_comprehensive_attempts_user_question ON comprehensive_attempts(user_id, question_id, updated_at DESC);
CREATE INDEX idx_comprehensive_attempts_status ON comprehensive_attempts(status, submitted_at);
