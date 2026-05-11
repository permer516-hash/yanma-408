#!/usr/bin/env bash
set -euo pipefail

if [[ "${CONFIRM_RESET:-}" != "reset-demo" ]]; then
  echo "Refusing to reset demo data without CONFIRM_RESET=reset-demo." >&2
  exit 2
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMPOSE_FILE="${COMPOSE_FILE:-$ROOT_DIR/deploy/docker-compose.yml}"
POSTGRES_DB="${POSTGRES_DB:-yanma408}"
POSTGRES_USER="${POSTGRES_USER:-yanma408}"
DRY_RUN="${DRY_RUN:-false}"

echo "Starting PostgreSQL container if needed..."
docker compose -f "$COMPOSE_FILE" up -d postgres

echo "Waiting for PostgreSQL..."
for _ in {1..30}; do
  if docker compose -f "$COMPOSE_FILE" exec -T postgres pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB" >/dev/null; then
    break
  fi
  sleep 1
done
docker compose -f "$COMPOSE_FILE" exec -T postgres pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB" >/dev/null

if [[ "$DRY_RUN" == "true" ]]; then
  echo "Running demo data reset in dry-run mode; changes will be rolled back."
  TX_START="BEGIN;"
  TX_END="ROLLBACK;"
else
  TX_START="BEGIN;"
  TX_END="COMMIT;"
fi

docker compose -f "$COMPOSE_FILE" exec -T postgres psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<SQL
${TX_START}

DELETE FROM study_notifications;
DELETE FROM study_notification_preferences;
DELETE FROM auth_audit_logs;
DELETE FROM auth_tokens;
DELETE FROM exam_attempt_answers;
DELETE FROM exam_attempts;
DELETE FROM mistakes;
DELETE FROM practice_attempts;
DELETE FROM study_task_occurrences;
DELETE FROM study_plan_tasks;

DELETE FROM question_tag_relations;
DELETE FROM question_tags;
DELETE FROM exam_paper_questions
WHERE exam_paper_id <> '00000000-0000-0000-0000-000000000801'
   OR question_id NOT IN (
      '00000000-0000-0000-0000-000000000401',
      '00000000-0000-0000-0000-000000000402'
   );
DELETE FROM exam_papers
WHERE id <> '00000000-0000-0000-0000-000000000801';
DELETE FROM question_options
WHERE question_id NOT IN (
  '00000000-0000-0000-0000-000000000401',
  '00000000-0000-0000-0000-000000000402'
);
DELETE FROM question_knowledge_points
WHERE question_id NOT IN (
  '00000000-0000-0000-0000-000000000401',
  '00000000-0000-0000-0000-000000000402'
);
DELETE FROM questions
WHERE id NOT IN (
  '00000000-0000-0000-0000-000000000401',
  '00000000-0000-0000-0000-000000000402'
);

DELETE FROM app_users
WHERE id <> '00000000-0000-0000-0000-000000000001';

INSERT INTO app_users (
    id, username, display_name, password_hash,
    password_reset_token_hash, password_reset_expires_at,
    created_at, updated_at
) VALUES (
    '00000000-0000-0000-0000-000000000001',
    'demo',
    '研码同学',
    '{noop}yanma408',
    NULL,
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
    username = EXCLUDED.username,
    display_name = EXCLUDED.display_name,
    password_hash = EXCLUDED.password_hash,
    password_reset_token_hash = NULL,
    password_reset_expires_at = NULL,
    updated_at = CURRENT_TIMESTAMP;

UPDATE questions
SET status = 'PUBLISHED',
    review_status = 'APPROVED',
    review_note = NULL,
    reviewed_at = NULL,
    stem_format = 'PLAIN_TEXT',
    stem_image_url = NULL,
    updated_at = CURRENT_TIMESTAMP
WHERE id IN (
  '00000000-0000-0000-0000-000000000401',
  '00000000-0000-0000-0000-000000000402'
);

UPDATE exam_papers
SET title = '408 迷你模拟卷 A',
    paper_type = 'MOCK',
    source_year = NULL,
    duration_minutes = 25,
    total_score = 4.00,
    question_count = 2,
    status = 'PUBLISHED',
    updated_at = CURRENT_TIMESTAMP
WHERE id = '00000000-0000-0000-0000-000000000801';

INSERT INTO study_plan_tasks (
    id, user_id, title, subject_code, task_type, target_count, estimated_minutes,
    status, priority, task_date, recurrence_rule, reminder_time, created_at, updated_at
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
    'NONE',
    NULL,
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
    'NONE',
    NULL,
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
    'NONE',
    NULL,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

INSERT INTO study_notification_preferences (user_id, channel, enabled, target, updated_at) VALUES
('00000000-0000-0000-0000-000000000001', 'IN_APP', TRUE, NULL, CURRENT_TIMESTAMP),
('00000000-0000-0000-0000-000000000001', 'BROWSER', FALSE, NULL, CURRENT_TIMESTAMP),
('00000000-0000-0000-0000-000000000001', 'EMAIL', FALSE, NULL, CURRENT_TIMESTAMP);

${TX_END}

SELECT 'app_users' AS table_name, COUNT(*) AS rows FROM app_users
UNION ALL SELECT 'questions', COUNT(*) FROM questions
UNION ALL SELECT 'study_plan_tasks', COUNT(*) FROM study_plan_tasks
UNION ALL SELECT 'practice_attempts', COUNT(*) FROM practice_attempts
UNION ALL SELECT 'mistakes', COUNT(*) FROM mistakes
UNION ALL SELECT 'exam_attempts', COUNT(*) FROM exam_attempts
UNION ALL SELECT 'auth_tokens', COUNT(*) FROM auth_tokens
UNION ALL SELECT 'auth_audit_logs', COUNT(*) FROM auth_audit_logs
ORDER BY table_name;
SQL

if [[ "$DRY_RUN" == "true" ]]; then
  echo "Dry-run completed; no data changed."
else
  echo "Demo data reset completed."
fi
