#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Running backend tests..."
(cd "$ROOT_DIR/apps/server" && mvn test)

echo "Running frontend lint..."
(cd "$ROOT_DIR/apps/web" && npm run lint)

echo "Running frontend type checks..."
(cd "$ROOT_DIR/apps/web" && npm run typecheck)

echo "Building the frontend..."
(cd "$ROOT_DIR/apps/web" && npm run build)

echo "Running lightweight Playwright E2E tests..."
(cd "$ROOT_DIR/apps/web" && npm run test:e2e)

echo "Predeployment tests passed."
