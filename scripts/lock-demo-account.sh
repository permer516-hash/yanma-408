#!/usr/bin/env bash
set -euo pipefail

if [[ "${CONFIRM_LOCK_DEMO:-}" != "lock-demo" ]]; then
  echo "Refusing to lock demo account without CONFIRM_LOCK_DEMO=lock-demo." >&2
  exit 2
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMPOSE_FILE="${COMPOSE_FILE:-$ROOT_DIR/deploy/docker-compose.yml}"
POSTGRES_DB="${POSTGRES_DB:-yanma408}"
POSTGRES_USER="${POSTGRES_USER:-yanma408}"
DEMO_USERNAME="${DEMO_USERNAME:-demo}"
DRY_RUN="${DRY_RUN:-false}"

if [[ "$DEMO_USERNAME" == *"'"* || "${DEMO_NEW_PASSWORD:-}" == *"'"* ]]; then
  echo "DEMO_USERNAME and DEMO_NEW_PASSWORD must not contain single quotes." >&2
  exit 2
fi

if [[ -n "${DEMO_NEW_PASSWORD:-}" ]]; then
  NEW_PASSWORD="$DEMO_NEW_PASSWORD"
else
  NEW_PASSWORD="disabled-$(date +%s)-$(openssl rand -hex 18)"
fi

if [[ "$DRY_RUN" == "true" ]]; then
  TX_START="BEGIN;"
  TX_END="ROLLBACK;"
  echo "Running demo account lock in dry-run mode; changes will be rolled back."
else
  TX_START="BEGIN;"
  TX_END="COMMIT;"
fi

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

docker compose -f "$COMPOSE_FILE" exec -T postgres psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<SQL
${TX_START}

WITH target_user AS (
  SELECT id
  FROM app_users
  WHERE username = '${DEMO_USERNAME}'
)
UPDATE app_users
SET password_hash = '{noop}${NEW_PASSWORD}',
    password_reset_token_hash = NULL,
    password_reset_expires_at = NULL,
    updated_at = CURRENT_TIMESTAMP
WHERE id IN (SELECT id FROM target_user);

DELETE FROM auth_tokens
WHERE user_id IN (
  SELECT id
  FROM app_users
  WHERE username = '${DEMO_USERNAME}'
);

INSERT INTO auth_audit_logs (
    id, user_id, username, event_type, success, ip_address, user_agent, details, created_at
)
SELECT gen_random_uuid(), id, username, 'DEMO_ACCOUNT_LOCK', TRUE, NULL, 'maintenance-script',
       CASE WHEN '${DRY_RUN}' = 'true' THEN 'dry_run' ELSE 'locked_and_tokens_revoked' END,
       CURRENT_TIMESTAMP
FROM app_users
WHERE username = '${DEMO_USERNAME}';

${TX_END}

SELECT username, display_name, updated_at
FROM app_users
WHERE username = '${DEMO_USERNAME}';
SQL

if [[ -n "${DEMO_NEW_PASSWORD:-}" ]]; then
  echo "Demo account password was rotated to DEMO_NEW_PASSWORD and existing tokens were revoked."
else
  echo "Demo account password was replaced with an unprinted random value and existing tokens were revoked."
fi

if [[ "$DRY_RUN" == "true" ]]; then
  echo "Dry-run completed; no data changed."
fi
