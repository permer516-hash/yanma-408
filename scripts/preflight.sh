#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SERVER_PORT="${SERVER_PORT:-18082}"
E2E_SERVER_PORT="${E2E_SERVER_PORT:-18083}"
WEB_PORT="${WEB_PORT:-3000}"
API_BASE_URL="http://localhost:${E2E_SERVER_PORT}/api"
SERVER_PID=""
WEB_PID=""

cleanup() {
  if [[ -n "$SERVER_PID" ]]; then
    kill "$SERVER_PID" 2>/dev/null || true
  fi
  if [[ -n "$WEB_PID" ]]; then
    kill "$WEB_PID" 2>/dev/null || true
  fi
}
trap cleanup EXIT

echo "Running PostgreSQL regression..."
"$ROOT_DIR/scripts/regression-postgres.sh"

echo "Running frontend production dependency audit..."
(cd "$ROOT_DIR/apps/web" && npm audit --omit=dev)

echo "Starting local-h2 backend for E2E at ${API_BASE_URL}..."
(cd "$ROOT_DIR/apps/server" && SERVER_PORT="$E2E_SERVER_PORT" mvn spring-boot:run -Dspring-boot.run.profiles=local-h2) &
SERVER_PID=$!

echo "Waiting for local-h2 backend health..."
for _ in {1..60}; do
  if curl -fsS "${API_BASE_URL}/health" >/dev/null; then
    break
  fi
  sleep 1
done
curl -fsS "${API_BASE_URL}/health" >/dev/null

echo "Starting frontend for E2E at http://localhost:${WEB_PORT}..."
(cd "$ROOT_DIR/apps/web" && NEXT_PUBLIC_API_BASE_URL="$API_BASE_URL" npm run dev -- --port "$WEB_PORT") &
WEB_PID=$!

echo "Waiting for frontend..."
for _ in {1..60}; do
  if curl -fsS "http://localhost:${WEB_PORT}/login" >/dev/null; then
    break
  fi
  sleep 1
done
curl -fsS "http://localhost:${WEB_PORT}/login" >/dev/null

echo "Running Playwright E2E..."
(cd "$ROOT_DIR/apps/web" && E2E_BASE_URL="http://localhost:${WEB_PORT}" npm run e2e)

echo "Preflight passed."
