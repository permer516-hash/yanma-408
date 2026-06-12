ALTER TABLE material_extraction_candidates
    DROP CONSTRAINT chk_material_extraction_candidates_status;

ALTER TABLE material_extraction_candidates
    ADD COLUMN ocr_text TEXT;

ALTER TABLE material_extraction_candidates
    ADD COLUMN corrected_stem TEXT;

ALTER TABLE material_extraction_candidates
    ADD COLUMN corrected_answer TEXT;

ALTER TABLE material_extraction_candidates
    ADD COLUMN corrected_explanation TEXT;

ALTER TABLE material_extraction_candidates
    ADD COLUMN corrected_options TEXT;

ALTER TABLE material_extraction_candidates
    ADD COLUMN corrected_question_type VARCHAR(32);

ALTER TABLE material_extraction_candidates
    ADD COLUMN reviewed_by UUID REFERENCES app_users(id) ON DELETE SET NULL;

ALTER TABLE material_extraction_candidates
    ADD COLUMN reviewed_at TIMESTAMP;

ALTER TABLE material_extraction_candidates
    ADD COLUMN failure_reason TEXT;

ALTER TABLE material_extraction_candidates
    ADD CONSTRAINT chk_material_extraction_candidates_status
    CHECK (status IN ('EXTRACTED', 'OCR_REQUIRED', 'OCR_DONE', 'REVIEWING', 'REVIEWED', 'DRAFTED', 'EMPTY', 'FAILED'));

ALTER TABLE material_extraction_candidates
    ADD CONSTRAINT chk_material_extraction_candidates_corrected_type
    CHECK (
        corrected_question_type IS NULL
        OR corrected_question_type IN ('SINGLE_CHOICE', 'MULTIPLE_CHOICE', 'COMPREHENSIVE', 'ALGORITHM', 'CALCULATION')
    );

CREATE TABLE question_text_vectors (
    id UUID PRIMARY KEY,
    entity_type VARCHAR(32) NOT NULL,
    entity_id UUID NOT NULL,
    normalized_text TEXT NOT NULL,
    token_vector TEXT NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_question_text_vectors_entity_type
        CHECK (entity_type IN ('DRAFT', 'QUESTION')),
    CONSTRAINT uq_question_text_vectors_entity
        UNIQUE (entity_type, entity_id)
);

CREATE INDEX idx_question_text_vectors_entity ON question_text_vectors(entity_type, entity_id);
