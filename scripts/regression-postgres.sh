#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SERVER_PORT="${SERVER_PORT:-18082}"
API_BASE_URL="http://localhost:${SERVER_PORT}/api"
SERVER_PID=""

cleanup() {
  if [[ -n "$SERVER_PID" ]]; then
    kill "$SERVER_PID" 2>/dev/null || true
  fi
}
trap cleanup EXIT

echo "Starting PostgreSQL/Redis..."
docker compose -f "$ROOT_DIR/deploy/docker-compose.yml" up -d

echo "Running backend tests..."
(cd "$ROOT_DIR/apps/server" && mvn test)

echo "Running frontend lint/build..."
(cd "$ROOT_DIR/apps/web" && npm run lint && npm run build)

echo "Starting backend on PostgreSQL at ${API_BASE_URL}..."
(cd "$ROOT_DIR/apps/server" && mvn spring-boot:run -Dspring-boot.run.arguments=--server.port="${SERVER_PORT}") &
SERVER_PID=$!

echo "Waiting for backend health..."
for _ in {1..60}; do
  if curl -fsS "${API_BASE_URL}/health" >/dev/null; then
    break
  fi
  sleep 1
done
curl -fsS "${API_BASE_URL}/health" >/dev/null

echo "Running PostgreSQL smoke API checks..."
TOKEN="$(curl -fsS -X POST "${API_BASE_URL}/auth/login" \
  -H "Content-Type: application/json" \
  -d '{"username":"demo","password":"yanma408"}' \
  | sed -n 's/.*"token":"\([^"]*\)".*/\1/p')"

curl -fsS "${API_BASE_URL}/questions/search?page=0&size=5" >/dev/null
curl -fsS "${API_BASE_URL}/study/dashboard" -H "Authorization: Bearer ${TOKEN}" >/dev/null
curl -fsS "${API_BASE_URL}/mistakes/review-queue" -H "Authorization: Bearer ${TOKEN}" >/dev/null
curl -fsS "${API_BASE_URL}/exams/reports/overview" -H "Authorization: Bearer ${TOKEN}" >/dev/null

echo "PostgreSQL regression passed."
