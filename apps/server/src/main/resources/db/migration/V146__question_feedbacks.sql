CREATE TABLE question_feedbacks (
    id UUID PRIMARY KEY,
    question_id UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
    reporter_user_id UUID NOT NULL REFERENCES app_users(id) ON DELETE CASCADE,
    issue_type VARCHAR(64) NOT NULL,
    description TEXT NOT NULL,
    status VARCHAR(32) NOT NULL,
    admin_note TEXT,
    handled_by_user_id UUID REFERENCES app_users(id),
    handled_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    CONSTRAINT chk_question_feedbacks_issue_type CHECK (
        issue_type IN (
            'ANSWER_INCORRECT',
            'EXPLANATION_UNCLEAR',
            'STEM_ERROR',
            'OPTION_ERROR',
            'IMAGE_DISPLAY_ERROR',
            'OTHER'
        )
    ),
    CONSTRAINT chk_question_feedbacks_status CHECK (status IN ('PENDING', 'RESOLVED', 'IGNORED'))
);

CREATE INDEX idx_question_feedbacks_status_created ON question_feedbacks(status, created_at DESC);
CREATE INDEX idx_question_feedbacks_question ON question_feedbacks(question_id);
CREATE INDEX idx_question_feedbacks_reporter ON question_feedbacks(reporter_user_id);
