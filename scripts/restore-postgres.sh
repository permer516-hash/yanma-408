#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: CONFIRM_RESTORE=restore-demo scripts/restore-postgres.sh <backup.dump>" >&2
  exit 2
fi

if [[ "${CONFIRM_RESTORE:-}" != "restore-demo" ]]; then
  echo "Refusing to restore without CONFIRM_RESTORE=restore-demo." >&2
  exit 2
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMPOSE_FILE="${COMPOSE_FILE:-$ROOT_DIR/deploy/docker-compose.yml}"
POSTGRES_DB="${POSTGRES_DB:-yanma408}"
POSTGRES_USER="${POSTGRES_USER:-yanma408}"
BACKUP_FILE="$1"

if [[ ! -f "$BACKUP_FILE" ]]; then
  echo "Backup file not found: ${BACKUP_FILE}" >&2
  exit 2
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

echo "Dropping and recreating public schema in ${POSTGRES_DB}..."
docker compose -f "$COMPOSE_FILE" exec -T postgres psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<'SQL'
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
SQL

echo "Restoring ${BACKUP_FILE}..."
docker compose -f "$COMPOSE_FILE" exec -T postgres pg_restore \
  -U "$POSTGRES_USER" \
  -d "$POSTGRES_DB" \
  --no-owner \
  --no-privileges \
  --clean \
  --if-exists \
  < "$BACKUP_FILE"

echo "Restore completed."
