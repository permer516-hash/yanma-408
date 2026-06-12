CREATE TABLE material_copyright_audits (
    id UUID PRIMARY KEY,
    material_asset_id UUID NOT NULL REFERENCES material_assets(id) ON DELETE CASCADE,
    source_name VARCHAR(200) NOT NULL,
    source_year INTEGER,
    authorization_scope VARCHAR(64) NOT NULL,
    risk_level VARCHAR(32) NOT NULL,
    decision VARCHAR(32) NOT NULL,
    notes TEXT,
    audited_by VARCHAR(64),
    audited_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_material_copyright_audits_scope
        CHECK (authorization_scope IN ('OWNED', 'LICENSED', 'PUBLIC_DOMAIN', 'INTERNAL_REFERENCE', 'UNKNOWN')),
    CONSTRAINT chk_material_copyright_audits_risk
        CHECK (risk_level IN ('LOW', 'MEDIUM', 'HIGH')),
    CONSTRAINT chk_material_copyright_audits_decision
        CHECK (decision IN ('APPROVED_FOR_EXTRACTION', 'NEEDS_PERMISSION', 'REJECTED'))
);

CREATE INDEX idx_material_copyright_audits_asset ON material_copyright_audits(material_asset_id);
CREATE INDEX idx_material_copyright_audits_decision ON material_copyright_audits(decision);
