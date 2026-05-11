# 研码408项目当前状态

更新时间：2026-05-08 09:55 Asia/Shanghai

## 已完成

### 产品方向

- 产品名称确定为：研码408。
- 产品定位：面向计算机考研 408 学生的刷题、复盘与学习分析平台。
- 目标用户：备考 408 的计算机专业考研学生。
- 覆盖科目：
  - 数据结构
  - 计算机组成原理
  - 操作系统
  - 计算机网络

### 技术选型

- 前端：Next.js 16 + React 19 + TypeScript + Tailwind CSS
- 后端：Spring Boot 3.4 + Java 17
- 后端架构：模块化单体 + 轻量 DDD
- 数据库：PostgreSQL
- 缓存：Redis
- 本地基础设施：Docker Compose
- 测试：
  - 前端：ESLint、Next build
  - 后端：JUnit + Spring Boot Test，测试环境使用 H2 内存数据库

### 仓库结构

```txt
yanma408/
├─ apps/
│  ├─ web/       Next.js 前端
│  └─ server/    Spring Boot 后端
├─ deploy/       Docker Compose 与部署配置
├─ docs/         产品、架构、任务日志与接口文档
└─ README.md
```

### 前端进展

- 已创建 `apps/web`。
- 已将默认 Next.js 首页替换为“研码408”学习仪表盘原型。
- 已创建题库页：
  - `/question-bank`
- 已创建做题页：
  - `/practice/[id]`
- 已创建错题本页：
  - `/mistakes`
- 已创建学生端学习分析独立页：
  - `/analysis`
- 已创建登录注册页：
  - `/login`
- 已创建套卷列表页：
  - `/exams`
- 已创建套卷详情与作答入口页：
  - `/exams/[id]`
- 已创建套卷整卷计时作答页：
  - `/exams/[id]/attempt`
- 已创建管理后台题目管理页：
  - `/admin`
- 已创建账号安全页：
  - `/account/security`
- 题库页已接入后端 `GET /api/questions`。
- 题库页已接入后端 `GET /api/questions/search`，支持关键词、分页、难度和知识点筛选。
- 做题页已接入后端 `GET /api/questions/{id}`。
- 做题页已接入后端 `POST /api/practice/attempts`，提交后展示后端判题结果和解析。
- 做题提交成功后已支持“返回仪表盘”和“继续下一题”。
- 错题本页已接入后端 `GET /api/mistakes`，展示错题、错次、知识点和复习入口。
- 错题本页已支持科目筛选、掌握状态筛选和掌握状态切换。
- 错题本页已支持“复习队列”，按未掌握优先、错次更多优先、越早出错优先组织复习。
- 仪表盘“最近错题”已接入真实错题接口。
- 仪表盘“薄弱知识点”已接入真实学习分析聚合接口。
- 仪表盘“今日目标”“连续学习”“本周正确率”“四科掌握度”“今日任务”已接入真实学习分析聚合接口。
- 仪表盘“今日任务”已支持按日期查询、新增、编辑、删除、标记完成、恢复待开始、周期规则、提醒时间和周/月计划视图。
- 前端登录后会保存 Bearer token，练习提交、错题本和学习分析请求会自动附带认证信息。
- 前端退出登录已调用服务端 `POST /api/auth/logout`，并在本地清理认证信息。
- 套卷页已接入后端 `GET /api/exams`，展示真实套卷列表。
- 套卷详情页已接入后端 `GET /api/exams/{id}`，展示套卷题目并提供整卷作答入口。
- 套卷作答页已接入开始 attempt、倒计时、答题卡、交卷和报告。
- 套卷详情页已展示作答历史，历史记录可进入报告查看，并展示最近两次重做对比。
- 管理后台已接入后端题库管理能力，支持创建、编辑、上下架、软删除、题目审核、审核备注、基础角色约束、标签、批量更新、Markdown/HTML/图片题干字段、轻量富文本快捷编辑与预览、JSON 批量导入、Excel/CSV 文件上传预校验/导入和后台题目列表。
- 学习计划已支持周期任务的单次实例状态更新，可单独完成、跳过或恢复某一天的周期任务。
- 首页已接入提醒列表，展示带提醒时间且尚未完成/跳过的学习任务。
- 账号安全页已接入密码重置、Token 管理、审计日志和通知渠道偏好。
- 套卷页报告总览已补充趋势分析图表。
- 前端生产构建已移除 Google Fonts 外网依赖，改用系统字体。
- 当前页面包含：
  - 左侧导航
  - 今日学习仪表盘
  - 考研倒计时
  - 今日目标
  - 四科掌握度
  - 今日任务
  - 薄弱知识点
  - 最近错题
- 前端开发服务器已启动：
  - http://localhost:3000
- 已通过：
  - `npm run lint`
  - `npm run build`
  - `npm audit --omit=dev`
  - `E2E_BASE_URL=http://localhost:3000 npm run e2e`

### 后端进展

- 已创建 `apps/server`。
- 已创建 Spring Boot 启动类。
- 已创建健康检查接口：
  - `GET /api/health`
- 已创建题库查询接口：
  - `GET /api/questions`
  - `GET /api/questions/search`
  - `GET /api/questions/{id}`
- 已创建练习提交接口：
  - `POST /api/practice/attempts`
- 已创建错题本查询接口：
  - `GET /api/mistakes`
  - `GET /api/mistakes/review-queue`
- 已创建错题掌握状态更新接口：
  - `PATCH /api/mistakes/{id}/mastery`
- 已创建学习分析聚合接口：
  - `GET /api/study/dashboard`
- 已创建学习任务接口：
  - `GET /api/study/tasks`
  - `GET /api/study/tasks/range`
  - `POST /api/study/tasks`
  - `PUT /api/study/tasks/{id}`
  - `PATCH /api/study/tasks/{id}/status`
  - `PATCH /api/study/tasks/{id}/occurrences/{date}/status`
  - `GET /api/study/reminders`
  - `GET /api/study/reminders/stream`
  - `DELETE /api/study/tasks/{id}`
- 已创建学习通知接口：
  - `POST /api/study/notifications/dispatch`
  - `GET /api/study/notifications`
  - `PATCH /api/study/notifications/{id}/read`
  - `GET /api/study/notifications/preferences`
  - `PUT /api/study/notifications/preferences/{channel}`
- 已创建套卷查询接口：
  - `GET /api/exams`
  - `GET /api/exams/{id}`
- 已创建套卷作答接口：
  - `POST /api/exams/{id}/attempts`
  - `POST /api/exams/attempts/{id}/submit`
  - `GET /api/exams/attempts/{id}/report`
  - `GET /api/exams/attempts`
  - `GET /api/exams/{id}/attempts`
  - `GET /api/exams/{id}/attempts/compare`
- 已创建题库管理接口：
  - `POST /api/questions`
  - `GET /api/admin/questions`
  - `GET /api/admin/questions/{id}`
  - `PUT /api/admin/questions/{id}`
  - `PATCH /api/admin/questions/{id}/status`
  - `PATCH /api/admin/questions/{id}/review`
  - `PATCH /api/admin/questions/bulk`
  - `DELETE /api/admin/questions/{id}`
  - `POST /api/admin/questions/import`
  - `POST /api/admin/questions/import/preview`
  - `POST /api/admin/questions/import/file`
  - `POST /api/admin/questions/import/preview-file`
- 已创建认证接口：
  - `POST /api/auth/register`
  - `POST /api/auth/login`
  - `GET /api/auth/me`
  - `POST /api/auth/logout`
  - `POST /api/auth/password-reset/request`
  - `POST /api/auth/password-reset/confirm`
  - `GET /api/auth/tokens`
  - `PATCH /api/auth/tokens/{id}/revoke`
  - `GET /api/auth/audit-logs`
- 已提取统一当前用户提供器：
  - `CurrentUserProvider`
  - `SpringSecurityCurrentUserProvider`
- 已接入 Spring Security：
  - `spring-boot-starter-security`
  - `SecurityConfig`
  - `AuthTokenFilter`
  - 登录、注册、健康检查和题目查询放行，其余业务接口需要认证。
- 当前练习提交、错题查询、错题状态更新和学习分析均不再接受客户端传入的用户 ID，统一使用 Spring Security 当前用户。
- 退出登录会将当前 Bearer token 在服务端失效，并通过定时任务清理过期 token。
- 账号安全已支持密码强度检查、密码重置 token、登录失败限流、登录/注册/重置/token 操作审计、Token 列表和指定 Token 失效。
- 学习任务按日期查询、范围查询、创建、编辑、删除、模板状态更新和单次周期实例状态更新均按 Spring Security 当前用户读写。
- 错题状态更新找不到记录时返回 404。
- 练习提交用时超出整型范围时返回 400。
- 已创建 Flyway 迁移：
  - `V1__init_question_bank.sql`
  - `V2__practice_attempts_and_mistakes.sql`
  - `V3__users_auth_and_study_tasks.sql`
  - `V4__exam_papers.sql`
  - `V5__exam_attempts_and_study_task_recurrence.sql`
  - `V6__question_review_tags_and_study_occurrences.sql`
  - `V7__study_notifications.sql`
  - `V8__security_review_and_notifications.sql`
- 已创建题库种子数据：
  - 数据结构二叉树遍历选择题
  - 计组 Cache 映射选择题
- 已创建演示账号和今日任务种子数据：
  - `demo / yanma408`
  - 网络层选择题
  - Cache 映射专题
  - 错题回炉
- 已创建套卷种子数据：
  - 408 迷你模拟卷 A
- 已创建本地 H2 运行 profile：
  - `local-h2`
- 已创建 CORS 配置，允许前端开发地址 `http://localhost:3000` 访问后端。
- 已创建轻量 DDD 初始包结构。
- 已创建题库领域初始模型：
  - `Question`
  - `QuestionId`
  - `Subject`
  - `QuestionType`
  - `Difficulty`
  - `KnowledgePoint`
  - `QuestionRepository`
- 已创建练习领域初始模型：
  - `PracticeAttempt`
- 已创建练习提交应用服务：
  - 后端判题
  - 提交记录落库
  - 答错自动归档错题
- 已创建错题本查询应用服务和 JDBC 查询实现。
- 已创建学习分析聚合查询服务和 JDBC 查询实现。
- 学习分析聚合当前包含：
  - 今日目标完成数
  - 连续学习天数
  - 本周正确率与上周环比
  - 四科掌握度
  - 今日学习任务
  - 薄弱知识点
- 已配置测试 profile，使用 H2 内存数据库，避免测试依赖本地 PostgreSQL。
- 已配置 `local-h2` profile，方便 Docker/PostgreSQL 暂不可用时本地演示后端接口。
- 已通过：
  - `mvn test`
- 当前后端测试包含启动、客户端 userId 忽略、错题更新 404、用时溢出 400、学习仪表盘聚合、学习任务创建/查询/编辑/删除/状态更新/周期范围/周期实例跳过/提醒过滤/通知渠道偏好/通知调度与已读、套卷列表/详情/整卷交卷报告/历史记录/重做对比/报告总览/错题回灌、题目搜索分页筛选、错题复习队列、退出登录 token 失效、密码重置、登录限流、Token 管理、题目创建/编辑/上下架/审核备注/标签/批量更新/软删除/批量导入/导入预校验、CSV 文件上传预校验/导入和后台题目列表。

### 基础设施进展

- 已创建 `deploy/docker-compose.yml`，包含：
  - PostgreSQL 17
  - Redis 7
- 已创建 `.env.example`，覆盖前端 API、E2E、后端端口、PostgreSQL 和 Redis 基础变量。
- 已创建一键本地启动脚本：
  - `scripts/dev-local.sh`
- 已创建 PostgreSQL 回归脚本：
  - `scripts/regression-postgres.sh`
- 已创建发布前检查脚本：
  - `scripts/preflight.sh`
- 已创建数据库备份脚本：
  - `scripts/backup-postgres.sh`
- 已创建数据库恢复脚本：
  - `scripts/restore-postgres.sh`
- 已创建演示数据重置脚本：
  - `scripts/reset-demo-data.sh`
- 已创建生产环境 readiness 检查脚本：
  - `scripts/production-readiness-check.sh`
- 已创建 demo 账号锁定脚本：
  - `scripts/lock-demo-account.sh`
- 已创建生产环境变量模板：
  - `.env.production.example`
- 已创建 GitHub Actions 发布前检查：
  - `.github/workflows/preflight.yml`
- 已创建本地运行手册：
  - `docs/development/runbook.md`
- 已创建发布验收清单和最小运维手册：
  - `docs/deployment/mvp-release-checklist.md`
  - `docs/deployment/operations-runbook.md`
- Docker Desktop registry mirror 已切换为 `https://docker.m.daocloud.io` 单源。
- PostgreSQL/Redis 镜像已成功拉取。
- PostgreSQL 已成功启动并通过 healthcheck。
- Redis 对外端口改为 `6380`，避免与本机已有 `6379` 占用冲突。
- 后端当前使用真实 PostgreSQL 在 18082 端口验证通过：
  - `GET /api/health`
  - `GET /api/questions`
  - `GET /api/questions/search`
  - `GET /api/questions?subject=DATA_STRUCTURE`
  - `POST /api/practice/attempts`
  - `GET /api/mistakes`
  - `GET /api/mistakes/review-queue`
  - `GET /api/study/dashboard`
  - `POST /api/study/tasks`
  - `POST /api/auth/login`
  - `GET /api/auth/me`
  - `POST /api/auth/logout`
  - `GET /api/exams`
  - `GET /api/exams/{id}`
  - `POST /api/exams/{id}/attempts`
  - `POST /api/exams/attempts/{id}/submit`
  - `GET /api/exams/attempts/{id}/report`
  - `GET /api/exams/attempts`
  - `GET /api/exams/{id}/attempts`
  - `GET /api/exams/{id}/attempts/compare`
  - `GET /api/study/tasks`
  - `GET /api/study/tasks/range`
  - `PUT /api/study/tasks/{id}`
  - `PATCH /api/study/tasks/{id}/occurrences/{date}/status`
  - `DELETE /api/study/tasks/{id}`
  - `GET /api/study/reminders`
  - `POST /api/questions`
  - `GET /api/admin/questions`
  - `GET /api/admin/questions/{id}`
  - `PUT /api/admin/questions/{id}`
  - `PATCH /api/admin/questions/{id}/status`
  - `PATCH /api/admin/questions/{id}/review`
  - `PATCH /api/admin/questions/bulk`
  - `DELETE /api/admin/questions/{id}`
  - `POST /api/admin/questions/import`
- 本次发布回归脚本已使用真实 PostgreSQL 在 18082 端口验证通过：
  - Flyway 当前 schema version 8
  - `GET /api/health`
  - `POST /api/auth/login`
  - `GET /api/questions/search`
  - `GET /api/study/dashboard`
  - `GET /api/mistakes/review-queue`
  - `GET /api/exams/reports/overview`
- 完整发布前检查已通过：
  - PostgreSQL 回归
  - 后端 `mvn test`，30 个测试通过
  - 前端 `npm run lint`
  - 前端 `npm run build`
  - 前端 `npm audit --omit=dev`
  - Playwright E2E，登录、题库、错题、学习分析、套卷、管理后台和账号安全页 smoke 通过
- 发布验收补充验证已通过：
  - `bash -n` 校验备份、恢复、演示数据重置脚本通过
  - `scripts/backup-postgres.sh` 成功生成 `/tmp/yanma408-validation.dump`
  - `CONFIRM_RESET=reset-demo DRY_RUN=true scripts/reset-demo-data.sh` 通过且回滚
  - `CONFIRM_RESTORE=restore-demo scripts/restore-postgres.sh /tmp/yanma408-validation.dump` 恢复成功
  - 恢复后 `scripts/regression-postgres.sh` 通过
- 生产发布护栏验证已通过：
  - `SKIP_REMOTE_CHECK=true ENV_FILE=<临时生产 env> scripts/production-readiness-check.sh` 通过
  - `CONFIRM_LOCK_DEMO=lock-demo DRY_RUN=true scripts/lock-demo-account.sh` 通过且回滚
- 当前可使用 H2 内存库运行后端进行演示：
  - `mvn spring-boot:run -Dspring-boot.run.profiles=local-h2 -Dspring-boot.run.arguments=--server.port=18082`

## 当前未完成

- 第一版 MVP 主流程已闭环：登录、题库、刷题、错题、学习计划、学习分析、套卷、管理后台、导入预校验、通知、账号安全、E2E、PostgreSQL 回归和发布前检查均已有可验证实现。
- 距离“可发布第一版 MVP”主要剩余远端与生产集成项，而不是核心功能缺口：
  - CI 需要配置 Git remote 后在真实远端仓库首次运行确认，并按团队习惯保留 artifacts/trace。
  - 外部通知渠道目前完成偏好和多渠道落库，真实邮件/浏览器 Push/微信网关仍需接入第三方凭证。
  - 富文本编辑器当前为轻量 Markdown/HTML 工具，后续可替换为 TipTap/MDX 等完整编辑器。
  - 审核权限当前为接口角色参数约束，后续应接入正式 RBAC/管理员角色模型。
  - 套卷趋势当前为基础趋势图，后续可扩展为更细的知识点趋势、时间分布和策略化错题回灌。

## 最近下一步

1. 配置 Git remote 并在 GitHub 远端触发 `.github/workflows/preflight.yml`，确认 CI runner 可安装 Playwright Chromium 与 Docker 服务。
2. 按上线环境复制 `.env.production.example` 为真实 `.env.production`，替换生产数据库密码、API 域名和 Redis 地址。
3. 按上线优先级接入真实外部通知渠道、正式 RBAC 和完整富文本编辑器。
