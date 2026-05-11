CREATE TABLE exam_papers (
    id UUID PRIMARY KEY,
    title VARCHAR(128) NOT NULL,
    paper_type VARCHAR(32) NOT NULL,
    source_year INTEGER,
    duration_minutes INTEGER NOT NULL,
    total_score NUMERIC(6, 2) NOT NULL,
    question_count INTEGER NOT NULL,
    status VARCHAR(32) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE exam_paper_questions (
    id UUID PRIMARY KEY,
    exam_paper_id UUID NOT NULL REFERENCES exam_papers(id) ON DELETE CASCADE,
    question_id UUID NOT NULL REFERENCES questions(id),
    sort_order INTEGER NOT NULL,
    score NUMERIC(5, 2) NOT NULL,
    UNIQUE (exam_paper_id, question_id)
);

CREATE INDEX idx_exam_papers_status ON exam_papers(status);
CREATE INDEX idx_exam_paper_questions_paper ON exam_paper_questions(exam_paper_id);

INSERT INTO exam_papers (
    id, title, paper_type, source_year, duration_minutes, total_score,
    question_count, status, created_at, updated_at
) VALUES
(
    '00000000-0000-0000-0000-000000000801',
    '408 迷你模拟卷 A',
    'MOCK',
    NULL,
    25,
    4.00,
    2,
    'PUBLISHED',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

INSERT INTO exam_paper_questions (
    id, exam_paper_id, question_id, sort_order, score
) VALUES
(
    '00000000-0000-0000-0000-000000000901',
    '00000000-0000-0000-0000-000000000801',
    '00000000-0000-0000-0000-000000000401',
    1,
    2.00
),
(
    '00000000-0000-0000-0000-000000000902',
    '00000000-0000-0000-0000-000000000801',
    '00000000-0000-0000-0000-000000000402',
    2,
    2.00
);
