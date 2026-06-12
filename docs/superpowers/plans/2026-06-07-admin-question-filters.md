# Admin Question Filters Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add difficulty and source-type filters to the admin question list, with real backend filtering and URL-persisted frontend state.

**Architecture:** Extend the existing `/api/admin/questions` filter chain from the controller through the query service and JDBC repository. Reuse the admin page's existing URL-backed filter state, adding canonical difficulty and source enum values without changing unrelated question-list behavior.

**Tech Stack:** Java 17, Spring Boot, JDBC, JUnit/MockMvc, Next.js, React, TypeScript.

---

### Task 1: Backend Filter Contract

**Files:**
- Modify: `apps/server/src/test/java/com/yanma408/Yanma408ApplicationTests.java`
- Modify: `apps/server/src/main/java/com/yanma408/question/interfaces/rest/AdminQuestionController.java`
- Modify: `apps/server/src/main/java/com/yanma408/question/application/query/QuestionQueryService.java`
- Modify: `apps/server/src/main/java/com/yanma408/question/domain/repository/QuestionQueryRepository.java`
- Modify: `apps/server/src/main/java/com/yanma408/question/infrastructure/persistence/JdbcQuestionQueryRepository.java`

- [ ] Add a MockMvc test that requests admin questions with `subject`, `difficulty`, and `source`.
- [ ] Run the focused test and confirm it fails before implementation.
- [ ] Thread `difficulty` and `source` through controller, service, repository, and SQL predicates.
- [ ] Run the focused test and confirm every returned item matches all selected filters.

### Task 2: Admin Page Controls

**Files:**
- Modify: `apps/web/app/lib/api.ts`
- Modify: `apps/web/app/admin/page.tsx`

- [ ] Extend `fetchAdminQuestions` with canonical difficulty and source query parameters.
- [ ] Initialize both filter values from the current URL.
- [ ] Add “全部难度/简单/中等/困难” and “全部来源/真题/模拟题/原创题” controls.
- [ ] Keep all five filters synchronized through `router.replace`.
- [ ] Run frontend lint/type checks.

### Task 3: End-to-End Verification

**Files:**
- No additional files.

- [ ] Restart the backend and confirm its health endpoint is up.
- [ ] Verify the admin API returns only matching rows for combined filters.
- [ ] Use the in-app browser to select difficulty and source filters.
- [ ] Confirm the URL retains both values and the rendered rows match them.
