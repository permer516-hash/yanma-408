#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
COMPOSE_FILE="$ROOT_DIR/deploy/production/docker-compose.yml"
ENV_FILE="${ENV_FILE:-$ROOT_DIR/deploy/production/.env}"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing production environment file: $ENV_FILE" >&2
  echo "Copy deploy/production/.env.example to deploy/production/.env and fill every value." >&2
  exit 2
fi

docker compose --env-file "$ENV_FILE" -f "$COMPOSE_FILE" up -d --build --remove-orphans
docker image prune -f
docker compose --env-file "$ENV_FILE" -f "$COMPOSE_FILE" ps
