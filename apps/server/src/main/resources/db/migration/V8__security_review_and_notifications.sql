ALTER TABLE app_users
    ADD COLUMN password_reset_token_hash VARCHAR(128);

ALTER TABLE auth_tokens
    ADD COLUMN revoked_at TIMESTAMP;

ALTER TABLE app_users
    ADD COLUMN password_reset_expires_at TIMESTAMP;

ALTER TABLE auth_tokens
    ADD COLUMN last_used_at TIMESTAMP;

UPDATE auth_tokens
SET last_used_at = created_at
WHERE last_used_at IS NULL;

CREATE TABLE auth_audit_logs (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES app_users(id) ON DELETE SET NULL,
    username VARCHAR(64),
    event_type VARCHAR(64) NOT NULL,
    success BOOLEAN NOT NULL,
    ip_address VARCHAR(64),
    user_agent VARCHAR(255),
    details VARCHAR(500),
    created_at TIMESTAMP NOT NULL
);

CREATE INDEX idx_auth_audit_logs_created ON auth_audit_logs(created_at DESC);
CREATE INDEX idx_auth_audit_logs_user_created ON auth_audit_logs(user_id, created_at DESC);

CREATE TABLE study_notification_preferences (
    user_id UUID NOT NULL REFERENCES app_users(id) ON DELETE CASCADE,
    channel VARCHAR(32) NOT NULL,
    enabled BOOLEAN NOT NULL,
    target VARCHAR(255),
    updated_at TIMESTAMP NOT NULL,
    PRIMARY KEY (user_id, channel)
);

INSERT INTO study_notification_preferences (user_id, channel, enabled, target, updated_at)
SELECT id, 'IN_APP', TRUE, NULL, CURRENT_TIMESTAMP FROM app_users
ON CONFLICT DO NOTHING;

INSERT INTO study_notification_preferences (user_id, channel, enabled, target, updated_at)
SELECT id, 'BROWSER', FALSE, NULL, CURRENT_TIMESTAMP FROM app_users
ON CONFLICT DO NOTHING;

INSERT INTO study_notification_preferences (user_id, channel, enabled, target, updated_at)
SELECT id, 'EMAIL', FALSE, NULL, CURRENT_TIMESTAMP FROM app_users
ON CONFLICT DO NOTHING;

ALTER TABLE questions
    ADD COLUMN review_note VARCHAR(1000);

ALTER TABLE questions
    ADD COLUMN reviewed_at TIMESTAMP;
