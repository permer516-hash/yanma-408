CREATE TABLE question_content_quotas (
    id UUID PRIMARY KEY,
    subject_code VARCHAR(64) NOT NULL,
    chapter_code VARCHAR(64) NOT NULL,
    knowledge_point_code VARCHAR(64) NOT NULL,
    source VARCHAR(32) NOT NULL,
    difficulty VARCHAR(32) NOT NULL,
    target_count INTEGER NOT NULL,
    priority VARCHAR(32) NOT NULL DEFAULT 'NORMAL',
    notes TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_question_content_quotas_source
        CHECK (source IN ('PAST_EXAM', 'MOCK', 'ORIGINAL')),
    CONSTRAINT chk_question_content_quotas_difficulty
        CHECK (difficulty IN ('BASIC', 'MEDIUM', 'HARD')),
    CONSTRAINT chk_question_content_quotas_target
        CHECK (target_count >= 0),
    CONSTRAINT uq_question_content_quota
        UNIQUE (subject_code, chapter_code, knowledge_point_code, source, difficulty)
);

CREATE TABLE question_drafts (
    id UUID PRIMARY KEY,
    material_asset_id UUID REFERENCES material_assets(id) ON DELETE SET NULL,
    subject_code VARCHAR(64) NOT NULL,
    chapter_code VARCHAR(64) NOT NULL,
    type VARCHAR(32) NOT NULL,
    difficulty VARCHAR(32) NOT NULL,
    stem TEXT NOT NULL,
    answer TEXT NOT NULL,
    explanation TEXT NOT NULL,
    source VARCHAR(32) NOT NULL,
    source_year INTEGER,
    score NUMERIC(5, 2) NOT NULL DEFAULT 2.00,
    stem_format VARCHAR(32) NOT NULL DEFAULT 'PLAIN_TEXT',
    stem_image_url TEXT,
    fingerprint VARCHAR(64) NOT NULL,
    status VARCHAR(32) NOT NULL DEFAULT 'DRAFT',
    review_status VARCHAR(32) NOT NULL DEFAULT 'PENDING',
    review_note TEXT,
    published_question_id UUID REFERENCES questions(id) ON DELETE SET NULL,
    created_by VARCHAR(64),
    reviewed_by VARCHAR(64),
    published_by VARCHAR(64),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reviewed_at TIMESTAMP,
    published_at TIMESTAMP,
    CONSTRAINT chk_question_drafts_source
        CHECK (source IN ('PAST_EXAM', 'MOCK', 'ORIGINAL')),
    CONSTRAINT chk_question_drafts_difficulty
        CHECK (difficulty IN ('BASIC', 'MEDIUM', 'HARD')),
    CONSTRAINT chk_question_drafts_status
        CHECK (status IN ('DRAFT', 'REVIEWING', 'APPROVED', 'REJECTED', 'PUBLISHED', 'ARCHIVED')),
    CONSTRAINT chk_question_drafts_review_status
        CHECK (review_status IN ('PENDING', 'APPROVED', 'REJECTED')),
    CONSTRAINT chk_question_drafts_stem_format
        CHECK (stem_format IN ('PLAIN_TEXT', 'MARKDOWN', 'HTML'))
);

CREATE TABLE question_draft_options (
    id UUID PRIMARY KEY,
    draft_id UUID NOT NULL REFERENCES question_drafts(id) ON DELETE CASCADE,
    label VARCHAR(8) NOT NULL,
    content TEXT NOT NULL,
    sort_order INTEGER NOT NULL,
    UNIQUE (draft_id, label)
);

CREATE TABLE question_draft_knowledge_points (
    draft_id UUID NOT NULL REFERENCES question_drafts(id) ON DELETE CASCADE,
    knowledge_point_code VARCHAR(64) NOT NULL,
    PRIMARY KEY (draft_id, knowledge_point_code)
);

CREATE TABLE question_draft_tags (
    draft_id UUID NOT NULL REFERENCES question_drafts(id) ON DELETE CASCADE,
    tag VARCHAR(64) NOT NULL,
    PRIMARY KEY (draft_id, tag)
);

CREATE TABLE question_draft_review_tasks (
    id UUID PRIMARY KEY,
    draft_id UUID NOT NULL REFERENCES question_drafts(id) ON DELETE CASCADE,
    stage VARCHAR(32) NOT NULL,
    status VARCHAR(32) NOT NULL,
    reviewer_role VARCHAR(32) NOT NULL,
    notes TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP,
    CONSTRAINT chk_question_draft_review_stage
        CHECK (stage IN ('INITIAL_REVIEW', 'FINAL_REVIEW')),
    CONSTRAINT chk_question_draft_review_status
        CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED')),
    CONSTRAINT chk_question_draft_review_role
        CHECK (reviewer_role IN ('AUTHOR', 'REVIEWER', 'ADMIN'))
);

CREATE INDEX idx_question_content_quotas_subject ON question_content_quotas(subject_code);
CREATE INDEX idx_question_content_quotas_kp ON question_content_quotas(knowledge_point_code);
CREATE INDEX idx_question_drafts_material ON question_drafts(material_asset_id);
CREATE INDEX idx_question_drafts_status ON question_drafts(status, review_status);
CREATE INDEX idx_question_drafts_fingerprint ON question_drafts(fingerprint);
CREATE INDEX idx_question_drafts_source ON question_drafts(source, difficulty);

INSERT INTO question_content_quotas (
    id, subject_code, chapter_code, knowledge_point_code, source, difficulty,
    target_count, priority, notes, created_at, updated_at
) VALUES
('00000000-0000-0000-0000-000000000810', 'DATA_STRUCTURE', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'ORIGINAL', 'BASIC', 20, 'HIGH', '首批上线优先覆盖二叉树遍历基础题', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('00000000-0000-0000-0000-000000000811', 'DATA_STRUCTURE', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'MOCK', 'MEDIUM', 20, 'HIGH', '模拟训练覆盖构造、遍历和性质综合', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('00000000-0000-0000-0000-000000000812', 'DATA_STRUCTURE', 'DS_TREE', 'DS_TREE_TRAVERSAL', 'PAST_EXAM', 'MEDIUM', 10, 'NORMAL', '真题需完成来源和授权审计后导入', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('00000000-0000-0000-0000-000000000813', 'COMPUTER_ORGANIZATION', 'CO_CACHE', 'CO_CACHE_MAPPING', 'ORIGINAL', 'BASIC', 20, 'HIGH', '首批上线优先覆盖 Cache 映射基础计算', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('00000000-0000-0000-0000-000000000814', 'COMPUTER_ORGANIZATION', 'CO_CACHE', 'CO_CACHE_MAPPING', 'MOCK', 'MEDIUM', 20, 'HIGH', '模拟训练覆盖映射、命中率和 AMAT', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('00000000-0000-0000-0000-000000000815', 'COMPUTER_ORGANIZATION', 'CO_CACHE', 'CO_CACHE_MAPPING', 'PAST_EXAM', 'MEDIUM', 10, 'NORMAL', '真题需完成来源和授权审计后导入', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('00000000-0000-0000-0000-000000000816', 'OPERATING_SYSTEM', 'OS_PROCESS', 'OS_SCHEDULING', 'ORIGINAL', 'BASIC', 20, 'HIGH', '首批上线优先覆盖调度概念与基础判断', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('00000000-0000-0000-0000-000000000817', 'OPERATING_SYSTEM', 'OS_PROCESS', 'OS_SCHEDULING', 'MOCK', 'MEDIUM', 20, 'HIGH', '模拟训练覆盖调度算法和同步互斥', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('00000000-0000-0000-0000-000000000818', 'OPERATING_SYSTEM', 'OS_PROCESS', 'OS_SCHEDULING', 'PAST_EXAM', 'MEDIUM', 10, 'NORMAL', '真题需完成来源和授权审计后导入', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('00000000-0000-0000-0000-000000000819', 'COMPUTER_NETWORK', 'CN_TRANSPORT', 'CN_TCP_CONGESTION', 'ORIGINAL', 'BASIC', 20, 'HIGH', '首批上线优先覆盖 TCP 基础机制', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('00000000-0000-0000-0000-000000000820', 'COMPUTER_NETWORK', 'CN_TRANSPORT', 'CN_TCP_CONGESTION', 'MOCK', 'MEDIUM', 20, 'HIGH', '模拟训练覆盖拥塞控制、流量控制和窗口计算', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('00000000-0000-0000-0000-000000000821', 'COMPUTER_NETWORK', 'CN_TRANSPORT', 'CN_TCP_CONGESTION', 'PAST_EXAM', 'MEDIUM', 10, 'NORMAL', '真题需完成来源和授权审计后导入', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
