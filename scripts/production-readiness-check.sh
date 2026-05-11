#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="${ENV_FILE:-${1:-}}"
SKIP_REMOTE_CHECK="${SKIP_REMOTE_CHECK:-false}"

if [[ -n "$ENV_FILE" ]]; then
  if [[ ! -f "$ENV_FILE" ]]; then
    echo "Environment file not found: ${ENV_FILE}" >&2
    exit 2
  fi
  set -a
  # shellcheck disable=SC1090
  source "$ENV_FILE"
  set +a
fi

failures=0

fail() {
  echo "FAIL: $1" >&2
  failures=$((failures + 1))
}

pass() {
  echo "PASS: $1"
}

require_value() {
  local name="$1"
  local value="${!name:-}"
  if [[ -z "$value" ]]; then
    fail "${name} is required"
  else
    pass "${name} is set"
  fi
}

reject_default_secret() {
  local name="$1"
  local value="${!name:-}"
  if [[ -z "$value" ]]; then
    return
  fi
  case "$value" in
    yanma408|password|CHANGE_ME*|changeme|123456|admin)
      fail "${name} still uses a default or placeholder secret"
      ;;
    *)
      pass "${name} does not look like a default secret"
      ;;
  esac
}

reject_local_url() {
  local name="$1"
  local value="${!name:-}"
  if [[ -z "$value" ]]; then
    return
  fi
  case "$value" in
    *localhost*|*127.0.0.1*|*0.0.0.0*|*h2:mem*)
      fail "${name} points to a local-only address"
      ;;
    http://*|https://*|jdbc:postgresql://*)
      pass "${name} is not local-only"
      ;;
    *)
      fail "${name} has an unexpected format: ${value}"
      ;;
  esac
}

if [[ "$SKIP_REMOTE_CHECK" == "true" ]]; then
  echo "SKIP: git remote check"
else
  if git -C "$ROOT_DIR" remote get-url origin >/dev/null 2>&1; then
    pass "git remote origin is configured"
  else
    fail "git remote origin is not configured; GitHub Actions cannot be triggered from this checkout"
  fi
fi

[[ -x "$ROOT_DIR/scripts/preflight.sh" ]] && pass "scripts/preflight.sh is executable" || fail "scripts/preflight.sh is not executable"
[[ -f "$ROOT_DIR/.github/workflows/preflight.yml" ]] && pass "Preflight workflow exists" || fail "Preflight workflow is missing"
[[ -f "$ROOT_DIR/docs/deployment/mvp-release-checklist.md" ]] && pass "MVP release checklist exists" || fail "MVP release checklist is missing"
[[ -f "$ROOT_DIR/docs/deployment/operations-runbook.md" ]] && pass "operations runbook exists" || fail "operations runbook is missing"

require_value NEXT_PUBLIC_API_BASE_URL
reject_local_url NEXT_PUBLIC_API_BASE_URL

if [[ -n "${YANMA408_DB_URL:-}" ]]; then
  reject_local_url YANMA408_DB_URL
elif [[ -n "${SPRING_DATASOURCE_URL:-}" ]]; then
  reject_local_url SPRING_DATASOURCE_URL
else
  fail "YANMA408_DB_URL or SPRING_DATASOURCE_URL is required"
fi

if [[ -n "${YANMA408_DB_PASSWORD:-}" ]]; then
  reject_default_secret YANMA408_DB_PASSWORD
elif [[ -n "${SPRING_DATASOURCE_PASSWORD:-}" ]]; then
  reject_default_secret SPRING_DATASOURCE_PASSWORD
else
  fail "YANMA408_DB_PASSWORD or SPRING_DATASOURCE_PASSWORD is required"
fi

reject_default_secret POSTGRES_PASSWORD

case "${SPRING_PROFILES_ACTIVE:-}" in
  prod|production)
    pass "SPRING_PROFILES_ACTIVE is production-like"
    ;;
  *)
    fail "SPRING_PROFILES_ACTIVE should be prod for production"
    ;;
esac

case "${DEMO_ACCOUNT_ACTION:-}" in
  locked|removed|password-rotated)
    pass "DEMO_ACCOUNT_ACTION is explicit"
    ;;
  *)
    fail "DEMO_ACCOUNT_ACTION must be locked, removed, or password-rotated"
    ;;
esac

if [[ "$failures" -gt 0 ]]; then
  echo "Production readiness failed with ${failures} issue(s)." >&2
  exit 1
fi

echo "Production readiness checks passed."
