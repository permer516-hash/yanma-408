CREATE TABLE material_assets (
    id UUID PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    subject_code VARCHAR(64),
    source_type VARCHAR(32) NOT NULL,
    source_year INTEGER,
    bucket VARCHAR(128) NOT NULL,
    object_key VARCHAR(512) NOT NULL,
    original_file_name VARCHAR(255) NOT NULL,
    content_type VARCHAR(128) NOT NULL,
    size_bytes BIGINT NOT NULL,
    sha256 VARCHAR(64) NOT NULL,
    status VARCHAR(32) NOT NULL DEFAULT 'REGISTERED',
    notes TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_material_assets_source_type
        CHECK (source_type IN ('TEXTBOOK', 'PAST_EXAM', 'MOCK_EXAM', 'ORIGINAL_DRAFT', 'OTHER')),
    CONSTRAINT chk_material_assets_status
        CHECK (status IN ('REGISTERED', 'INDEXING', 'STRUCTURED', 'REVIEWING', 'APPROVED', 'REJECTED')),
    CONSTRAINT chk_material_assets_size
        CHECK (size_bytes > 0),
    CONSTRAINT uq_material_assets_object
        UNIQUE (bucket, object_key)
);

CREATE INDEX idx_material_assets_source_type ON material_assets(source_type);
CREATE INDEX idx_material_assets_subject ON material_assets(subject_code);
CREATE INDEX idx_material_assets_sha256 ON material_assets(sha256);
CREATE INDEX idx_material_assets_status ON material_assets(status);
