CREATE TABLE study_notifications (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES app_users(id) ON DELETE CASCADE,
    task_id UUID REFERENCES study_plan_tasks(id) ON DELETE CASCADE,
    notification_date DATE NOT NULL,
    channel VARCHAR(32) NOT NULL,
    title VARCHAR(128) NOT NULL,
    content TEXT NOT NULL,
    read_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL,
    UNIQUE (user_id, task_id, notification_date, channel)
);

CREATE INDEX idx_study_notifications_user_created ON study_notifications(user_id, created_at DESC);
