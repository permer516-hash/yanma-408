#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMPOSE_FILE="${COMPOSE_FILE:-$ROOT_DIR/deploy/docker-compose.yml}"
POSTGRES_DB="${POSTGRES_DB:-yanma408}"
POSTGRES_USER="${POSTGRES_USER:-yanma408}"
BACKUP_DIR="${BACKUP_DIR:-$ROOT_DIR/backups}"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_FILE="${BACKUP_FILE:-$BACKUP_DIR/${POSTGRES_DB}-${TIMESTAMP}.dump}"

mkdir -p "$BACKUP_DIR"

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

echo "Writing backup to ${BACKUP_FILE}..."
docker compose -f "$COMPOSE_FILE" exec -T postgres pg_dump \
  -U "$POSTGRES_USER" \
  -d "$POSTGRES_DB" \
  --format=custom \
  --no-owner \
  --no-privileges \
  > "$BACKUP_FILE"

echo "Backup completed: ${BACKUP_FILE}"
