#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SERVER_PORT="${E2E_SERVER_PORT:-18084}"
WEB_PORT="${E2E_WEB_PORT:-3101}"
API_BASE_URL="http://localhost:${SERVER_PORT}/api"
WEB_BASE_URL="http://localhost:${WEB_PORT}"
SERVER_LOG="$(mktemp)"
WEB_LOG="$(mktemp)"
SERVER_PID=""
WEB_PID=""

cleanup() {
  set +e
  if [[ -n "$WEB_PID" ]]; then
    kill "$WEB_PID" >/dev/null 2>&1 || true
    wait "$WEB_PID" >/dev/null 2>&1 || true
  fi
  if [[ -n "$SERVER_PID" ]]; then
    kill "$SERVER_PID" >/dev/null 2>&1 || true
    wait "$SERVER_PID" >/dev/null 2>&1 || true
  fi
  rm -f "$SERVER_LOG" "$WEB_LOG"
}
trap cleanup EXIT

wait_for_url() {
  local url="$1"
  local name="$2"
  local log_file="$3"

  for _ in {1..60}; do
    if curl -fsS "$url" >/dev/null 2>&1; then
      return 0
    fi
    sleep 1
  done

  echo "${name} did not become ready at ${url}." >&2
  echo "--- ${name} log ---" >&2
  tail -n 80 "$log_file" >&2 || true
  exit 1
}

echo "Starting backend smoke server on ${SERVER_PORT}..."
(
  cd "$ROOT_DIR/apps/server"
  APP_CORS_ALLOWED_ORIGINS="$WEB_BASE_URL" SERVER_PORT="$SERVER_PORT" \
    mvn spring-boot:run -Dspring-boot.run.profiles=e2e
) >"$SERVER_LOG" 2>&1 &
SERVER_PID="$!"
wait_for_url "${API_BASE_URL}/health" "Backend" "$SERVER_LOG"

echo "Starting production frontend smoke server on ${WEB_PORT}..."
(
  cd "$ROOT_DIR/apps/web"
  NEXT_PUBLIC_API_BASE_URL="$API_BASE_URL" npm run start -- --port "$WEB_PORT"
) >"$WEB_LOG" 2>&1 &
WEB_PID="$!"
wait_for_url "${WEB_BASE_URL}/login" "Frontend" "$WEB_LOG"

echo "Production smoke passed."
