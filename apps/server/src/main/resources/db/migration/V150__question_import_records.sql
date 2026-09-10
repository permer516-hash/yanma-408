CREATE TABLE question_import_batches (
    id UUID PRIMARY KEY,
    operator_id UUID NOT NULL REFERENCES app_users(id),
    import_mode VARCHAR(16) NOT NULL,
    question_count INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL,
    CONSTRAINT chk_question_import_batches_mode CHECK (import_mode IN ('JSON', 'FILE')),
    CONSTRAINT chk_question_import_batches_question_count CHECK (question_count > 0)
);

CREATE TABLE question_import_batch_items (
    batch_id UUID NOT NULL REFERENCES question_import_batches(id) ON DELETE CASCADE,
    question_id UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
    PRIMARY KEY (batch_id, question_id)
);

CREATE INDEX idx_question_import_batches_created_at ON question_import_batches(created_at DESC);
CREATE INDEX idx_question_import_batch_items_question_id ON question_import_batch_items(question_id);
