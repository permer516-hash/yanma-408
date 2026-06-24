# Predeployment Test Flow Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a repeatable deployment gate that verifies the Spring Boot backend, Next.js frontend, and a small set of critical browser flows without relying on local PostgreSQL state.

**Architecture:** Reuse the repository's Flyway seed data with a new `e2e` Spring profile backed by an isolated H2 database. Let Playwright start both services on dedicated ports and run a small, role-aware smoke suite; a repository script composes backend tests, frontend static/build checks, and E2E into one command.

**Tech Stack:** Spring Boot 3.4, Maven, JUnit 5, MockMvc, H2, Next.js 16, TypeScript, ESLint, Playwright Test.

---

### Task 1: Add an isolated backend E2E profile and integration contract

**Files:**
- Create: `apps/server/src/main/resources/application-e2e.yml`
- Create: `apps/server/src/test/java/com/yanma408/E2eProfileIntegrationTest.java`

- [ ] **Step 1: Write the failing profile integration test**

Create a Spring Boot/MockMvc test with `@ActiveProfiles("e2e")` that asserts `/health` is `ok`, `demo / yanma408` can log in, `/auth/me` returns `STUDENT`, and `/questions/search?size=1` returns at least one seeded question.

- [ ] **Step 2: Run the test and verify RED**

Run: `mvn -Dtest=E2eProfileIntegrationTest test`

Expected: FAIL because the `e2e` profile still attempts the default PostgreSQL datasource.

- [ ] **Step 3: Add the minimal E2E profile**

Configure `jdbc:h2:mem:yanma408_e2e;MODE=PostgreSQL;DATABASE_TO_LOWER=TRUE;DEFAULT_NULL_ORDERING=HIGH`, the H2 driver, `sa`, an empty password, `ddl-auto: none`, and disable the H2 console. Do not add runtime mocks or production conditionals.

- [ ] **Step 4: Verify GREEN and the existing backend suite**

Run:

```bash
mvn -Dtest=E2eProfileIntegrationTest test
mvn test
```

Expected: the new contract passes; the full suite reports 0 failures and 0 errors.

### Task 2: Add deterministic lightweight Playwright flows

**Files:**
- Create: `apps/web/tests/e2e/service-smoke.spec.ts`
- Create: `apps/web/tests/e2e/student-flow.spec.ts`
- Create: `apps/web/tests/e2e/access-control.spec.ts`
- Modify: `apps/web/playwright.config.ts`
- Modify: `apps/web/package.json`

- [ ] **Step 1: Add tests for the required flows**

Add independent tests that cover:

- backend health and login page reachability;
- student login, dashboard, question-bank filter, question detail, and chapter page;
- student navigation hiding administration links and admin login opening the question-bank administration page.

Each login starts from a fresh browser context. Tests use seeded users (`demo / yanma408` and `root / 0516cyb123`) only in the E2E profile.

- [ ] **Step 2: Run the tests and verify RED**

Run: `npm run test:e2e`

Expected: FAIL because Playwright does not yet start isolated backend/frontend services.

- [ ] **Step 3: Add Playwright service orchestration**

Configure two `webServer` entries:

- backend: `mvn spring-boot:run -Dspring-boot.run.profiles=e2e` in `../server`, `SERVER_PORT=18083`, readiness URL `http://127.0.0.1:18083/api/health`;
- frontend: `npm run dev -- --port 3100`, `NEXT_PUBLIC_API_BASE_URL=http://127.0.0.1:18083/api`, readiness URL `http://127.0.0.1:3100/login`.

Use one Chromium project, `screenshot: "only-on-failure"`, `trace: "retain-on-failure"`, and output under existing ignored Playwright directories. Add `typecheck` and `test:e2e` scripts.

- [ ] **Step 4: Verify GREEN**

Run: `npm run test:e2e`

Expected: all lightweight specs pass against fresh H2 data.

### Task 3: Add the deployment gate and documentation

**Files:**
- Create: `scripts/test-predeploy.sh`
- Modify: `README.md`
- Modify: `apps/web/package.json`

- [ ] **Step 1: Add a failing command contract**

Run: `scripts/test-predeploy.sh`

Expected: FAIL because the script does not exist.

- [ ] **Step 2: Implement the minimal gate**

Create an executable Bash script with `set -euo pipefail` that runs:

```bash
(cd apps/server && mvn test)
(cd apps/web && npm run lint)
(cd apps/web && npm run typecheck)
(cd apps/web && npm run build)
(cd apps/web && npm run test:e2e)
```

Add `test:predeploy` as a convenient frontend script that calls the repository script. Document prerequisites, browser installation, individual commands, and the full gate in README.

- [ ] **Step 3: Verify the full gate**

Run: `scripts/test-predeploy.sh`

Expected: exit 0 after backend tests, lint, typecheck, production build, and Playwright E2E all pass.

### Task 4: Final verification and scope audit

**Files:**
- Review all files changed by Tasks 1-3.

- [ ] **Step 1: Confirm environment isolation**

Search for `e2e` configuration references and verify the profile is only selected by tests and Playwright commands, never by default or production profiles.

- [ ] **Step 2: Confirm no business logic changed**

Run `git diff --stat` and `git diff -- apps/server/src/main/java apps/web/app`.

Expected: no production Java or Next.js application file changes from this testing task.

- [ ] **Step 3: Record coverage and residual risks**

Summarize added/modified tests, exact commands, covered flows, and remaining risks: browser coverage is Chromium-only, production PostgreSQL/Redis/MinIO behavior is outside lightweight E2E, and no load or visual-regression testing is included.
