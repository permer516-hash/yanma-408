CREATE TABLE app_users (
    id UUID PRIMARY KEY,
    username VARCHAR(64) NOT NULL UNIQUE,
    display_name VARCHAR(64) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE auth_tokens (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES app_users(id) ON DELETE CASCADE,
    token_hash VARCHAR(128) NOT NULL UNIQUE,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL
);

CREATE TABLE study_plan_tasks (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES app_users(id) ON DELETE CASCADE,
    title VARCHAR(128) NOT NULL,
    subject_code VARCHAR(64) NOT NULL,
    task_type VARCHAR(32) NOT NULL,
    target_count INTEGER NOT NULL,
    estimated_minutes INTEGER NOT NULL,
    status VARCHAR(32) NOT NULL,
    priority VARCHAR(32) NOT NULL,
    task_date DATE NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE INDEX idx_auth_tokens_hash ON auth_tokens(token_hash);
CREATE INDEX idx_auth_tokens_user ON auth_tokens(user_id);
CREATE INDEX idx_study_plan_tasks_user_date ON study_plan_tasks(user_id, task_date);

INSERT INTO app_users (id, username, display_name, password_hash, created_at, updated_at) VALUES
('00000000-0000-0000-0000-000000000001', 'demo', '研码同学', '{noop}yanma408', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO study_plan_tasks (
    id, user_id, title, subject_code, task_type, target_count, estimated_minutes,
    status, priority, task_date, created_at, updated_at
) VALUES
(
    '00000000-0000-0000-0000-000000000701',
    '00000000-0000-0000-0000-000000000001',
    '网络层选择题',
    'COMPUTER_NETWORK',
    'QUESTION_SET',
    20,
    22,
    'PENDING',
    'NORMAL',
    CURRENT_DATE,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
),
(
    '00000000-0000-0000-0000-000000000702',
    '00000000-0000-0000-0000-000000000001',
    'Cache 映射专题',
    'COMPUTER_ORGANIZATION',
    'WEAK_POINT',
    10,
    15,
    'PENDING',
    'IMPORTANT',
    CURRENT_DATE,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
),
(
    '00000000-0000-0000-0000-000000000703',
    '00000000-0000-0000-0000-000000000001',
    '错题回炉',
    'DATA_STRUCTURE',
    'MISTAKE_REVIEW',
    15,
    20,
    'PENDING',
    'REVIEW',
    CURRENT_DATE,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);
