ALTER TABLE app_users
    ADD COLUMN enabled BOOLEAN NOT NULL DEFAULT TRUE;

CREATE INDEX idx_app_users_enabled_created ON app_users (enabled, created_at DESC);
