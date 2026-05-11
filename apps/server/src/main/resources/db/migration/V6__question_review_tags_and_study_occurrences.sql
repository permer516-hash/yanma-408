ALTER TABLE questions
    ADD COLUMN review_status VARCHAR(32) NOT NULL DEFAULT 'APPROVED';

ALTER TABLE questions
    ADD COLUMN stem_format VARCHAR(32) NOT NULL DEFAULT 'PLAIN_TEXT';

ALTER TABLE questions
    ADD COLUMN stem_image_url TEXT;

CREATE TABLE question_tags (
    id UUID PRIMARY KEY,
    name VARCHAR(64) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL
);

CREATE TABLE question_tag_relations (
    question_id UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
    tag_id UUID NOT NULL REFERENCES question_tags(id) ON DELETE CASCADE,
    PRIMARY KEY (question_id, tag_id)
);

CREATE TABLE study_task_occurrences (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES app_users(id) ON DELETE CASCADE,
    task_id UUID NOT NULL REFERENCES study_plan_tasks(id) ON DELETE CASCADE,
    occurrence_date DATE NOT NULL,
    status VARCHAR(32) NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    UNIQUE (task_id, occurrence_date)
);

CREATE INDEX idx_questions_review_status ON questions(review_status);
CREATE INDEX idx_question_tag_relations_tag ON question_tag_relations(tag_id);
CREATE INDEX idx_study_task_occurrences_user_date ON study_task_occurrences(user_id, occurrence_date);
