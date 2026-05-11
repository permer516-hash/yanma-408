#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SERVER_PORT="${SERVER_PORT:-18082}"
WEB_PORT="${WEB_PORT:-3000}"
API_BASE_URL="${NEXT_PUBLIC_API_BASE_URL:-http://localhost:${SERVER_PORT}/api}"

echo "Starting backend on http://localhost:${SERVER_PORT} with local-h2..."
(cd "$ROOT_DIR/apps/server" && mvn spring-boot:run -Dspring-boot.run.profiles=local-h2 -Dspring-boot.run.arguments=--server.port="${SERVER_PORT}") &
SERVER_PID=$!

echo "Starting frontend on http://localhost:${WEB_PORT}..."
(cd "$ROOT_DIR/apps/web" && NEXT_PUBLIC_API_BASE_URL="$API_BASE_URL" npm run dev -- --port "$WEB_PORT") &
WEB_PID=$!

cleanup() {
  kill "$SERVER_PID" "$WEB_PID" 2>/dev/null || true
}
trap cleanup EXIT

wait
