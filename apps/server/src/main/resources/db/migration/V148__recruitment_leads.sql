CREATE TABLE recruitment_leads (
    id UUID PRIMARY KEY,
    contact_name VARCHAR(40) NOT NULL,
    wechat_contact VARCHAR(80) NOT NULL,
    exam_year INTEGER NOT NULL,
    target_school VARCHAR(120),
    study_stage VARCHAR(32) NOT NULL,
    weak_subjects VARCHAR(256) NOT NULL,
    weekly_hours INTEGER,
    current_concern VARCHAR(1000),
    status VARCHAR(32) NOT NULL,
    consented_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL,
    CONSTRAINT chk_recruitment_leads_exam_year CHECK (exam_year BETWEEN 2026 AND 2035),
    CONSTRAINT chk_recruitment_leads_study_stage CHECK (
        study_stage IN ('NOT_STARTED', 'FIRST_ROUND', 'SECOND_ROUND', 'REVIEWING')
    ),
    CONSTRAINT chk_recruitment_leads_status CHECK (status = 'NEW'),
    CONSTRAINT chk_recruitment_leads_weekly_hours CHECK (weekly_hours IS NULL OR weekly_hours BETWEEN 1 AND 80)
);

CREATE INDEX idx_recruitment_leads_status_created ON recruitment_leads(status, created_at DESC);
