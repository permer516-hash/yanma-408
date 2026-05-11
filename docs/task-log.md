# 任务日志

以后每次开始和完成重要任务，都在这里追加记录。用户不需要一直盯着过程，可以通过本文件快速恢复上下文。

## 日志格式

```txt
### YYYY-MM-DD HH:mm 任务名称

- 状态：进行中 / 已完成 / 阻塞
- 目标：
- 已做：
- 验证：
- 遗留问题：
- 下一步：
```

## 2026-05-11 09:00 本地首版提交与 GitHub 推送尝试

- 状态：阻塞
- 目标：按用户确认，将本地 MVP 项目直接推送到 GitHub 远端 `main`。
- 已做：
  - 已将本地分支从 `master` 改为 `main`。
  - 已检查 `.gitignore`，确认 `.env`、构建产物、`node_modules`、`target`、备份目录等不会进入提交。
  - 发现 Playwright 本地测试结果 `apps/web/test-results/.last-run.json` 被暂存，已从暂存区移除，并在根 `.gitignore` 中补充 `test-results/` 与 `playwright-report/`。
  - 已暂存 169 个项目文件并创建本地首个提交：`Initial MVP implementation`。
  - 已使用 `--force-with-lease=main:660bf841f2de8bb56ec534d63ff950e337dcf50f` 尝试推送，避免误覆盖远端非预期更新。
  - 推送失败原因已确认：本机没有可用 GitHub HTTPS 凭据；`gh` 命令不存在；SSH 也未配置 GitHub public key。
- 验证：
  - `git log --oneline -1` 显示本地提交 `Initial MVP implementation`。
  - `git status --short --branch` 显示当前分支为 `main`，提交后工作区干净。
  - HTTPS 推送明确报错：`fatal: could not read Username for 'https://github.com': terminal prompts disabled`。
  - SSH 检查明确报错：`git@github.com: Permission denied (publickey)`。
- 遗留问题：
  - 尚未推送到 GitHub，阻塞于本机 GitHub 认证。
- 下一步：
  - 配置 GitHub HTTPS token、Git Credential Manager、GitHub CLI 登录，或添加 GitHub SSH key 后重新执行推送。

## 2026-05-11 09:20 GitHub 推送认证修复尝试

- 状态：阻塞
- 目标：解决本机无法推送 GitHub 的认证问题，并完成本地 `main` 到远端 `main` 的推送。
- 已做：
  - 已通过 Homebrew 安装 GitHub CLI：`gh 2.92.0`。
  - 尝试使用 `gh auth login --web --scopes repo,workflow` 走浏览器授权；因当前网络访问 GitHub OAuth API 超时，流程未完成。
  - 已生成本机专用 SSH key：`~/.ssh/id_ed25519_yanma408_github`，公钥文件为 `~/.ssh/id_ed25519_yanma408_github.pub`。
  - 已将 SSH host alias 写入 `~/.ssh/config`：`github.com-yanma408`，指向 `github.com` 并固定使用该 key。
  - 已将公钥复制到剪贴板，等待用户登录 GitHub 后添加到账号 SSH keys。
  - 已将仓库 remote 改为 SSH：`git@github.com-yanma408:permer516-hash/yanma-408.git`。
  - 已在 Safari 打开 GitHub SSH key 添加页，但 Safari 需要用户登录 GitHub；登录和 2FA/passkey 属于敏感账户操作，已交给用户完成。
- 验证：
  - `gh --version` 可用。
  - `git remote -v` 已显示 SSH remote。
  - 在 GitHub 账号尚未添加公钥前，`ssh -T github.com-yanma408` 仍返回 `Permission denied (publickey)`，符合预期。
- 遗留问题：
  - 尚未完成 GitHub 账号侧 SSH public key 添加。
  - 尚未推送本地 `main` 到远端。
- 下一步：
  - 用户在 GitHub 中添加剪贴板内的 SSH public key 后，执行 SSH 连通性验证与 `git push -u origin main --force-with-lease`。

## 2026-05-11 09:35 SSH key 拒绝原因复核

- 状态：阻塞
- 目标：在用户表示已添加 SSH key 后，复核本机 SSH 配置并继续推送。
- 已做：
  - 执行 `ssh -T -o BatchMode=yes github.com-yanma408`，GitHub 仍返回 `Permission denied (publickey)`。
  - 执行 `ssh -G github.com-yanma408`，确认 host alias 生效，使用 `IdentityFile /Users/permer/.ssh/id_ed25519_yanma408_github` 且 `IdentitiesOnly yes`。
  - 执行 `ssh -vvv -T -i ~/.ssh/id_ed25519_yanma408_github git@github.com`，确认客户端已向 GitHub 提交 public key：`SHA256:5SQcVnK80PygsOG3EL2u6iMLV8CKm3BqV4Ix7SivbVg`，但 GitHub 拒绝该 key。
  - 已重新将正确 public key 复制到剪贴板，并提示用户确认 GitHub 侧添加的是 Authentication Key，且 fingerprint 匹配。
- 验证：
  - 本机 SSH 配置无误，问题定位到 GitHub 账号侧尚未接受该 public key。
- 遗留问题：
  - 等待用户在 GitHub 账号 SSH keys 中添加并确认 fingerprint：`SHA256:5SQcVnK80PygsOG3EL2u6iMLV8CKm3BqV4Ix7SivbVg`。
- 下一步：
  - GitHub 侧 key 生效后重新验证 SSH，并推送 `main`。

## 2026-05-11 08:48 配置 GitHub 远端仓库

- 状态：已完成
- 目标：将用户提供的 GitHub 仓库 `https://github.com/permer516-hash/yanma-408.git` 配置为本地项目远端，为后续 CI 触发和发布流程做准备。
- 已做：
  - 检查本地 git 状态：当前仓库尚无提交，当前分支为 `master`，项目文件均为未跟踪状态。
  - 检查本地 remote：此前未配置任何远端。
  - 已执行 `git remote add origin https://github.com/permer516-hash/yanma-408.git`。
  - 已通过 `git remote -v` 确认 fetch/push remote 均指向该 GitHub 仓库。
  - 已通过 `git ls-remote` 验证远端可访问，远端 HEAD 指向 `refs/heads/main`，commit 为 `660bf841f2de8bb56ec534d63ff950e337dcf50f`。
- 验证：
  - `git remote -v` 显示 `origin` 配置成功。
  - `git ls-remote origin HEAD refs/heads/main refs/heads/master` 返回远端 `HEAD` 和 `main`。
- 遗留问题：
  - 本地仓库仍无提交且默认分支为 `master`；远端已有 `main` 分支历史。后续提交/推送前需要决定是否先拉取并合并远端历史，或将本地项目整理为首个正式提交后推送到 `main`。
  - 尚未触发 GitHub Actions `Preflight` 工作流。
- 下一步：
  - 检查远端 `main` 当前内容，与本地项目对齐后再进行首个提交、推送和 CI 验证。

## 2026-05-08 17:25 MVP 本机端口清理与应用启动

- 状态：已完成
- 目标：根据 `task-log.md`、`project-status.md` 和 `system-design.md` 梳理当前 MVP 进展，检查本机与研码408相关的端口和进程，释放旧的相关服务占用后重新启动项目，并验证核心功能可用性和健壮性。
- 已做：
  - 已读取核心项目文档，确认项目为“研码408”计算机考研 408 刷题、复盘、套卷模拟与学习分析平台。
  - 检查本机相关端口：`3000` 和 `18082` 原本空闲，`5432` 和 `6380` 由本项目 Docker Compose 的 PostgreSQL/Redis 占用且运行正常；`8080/8081` 为其他本机服务占用，未处理。
  - 检查项目 Docker 容器：`yanma408-postgres` healthy，`yanma408-redis` running；内存占用较低，且本次使用真实 PostgreSQL 启动后端，因此保留。
  - 尝试用后台 `nohup` 启动前后端，但该执行环境中进程立即退出且未写日志；随后改用持续终端会话启动。
  - 已启动后端：`http://localhost:18082/api`，连接真实 PostgreSQL，Flyway 校验 8 个迁移且 schema 已是 version 8。
  - 已启动前端：`http://localhost:3000`，API 指向 `http://localhost:18082/api`。
  - 记录 zsh smoke 脚本变量名问题：使用 `path` 作为循环变量会覆盖 zsh 命令搜索路径，已改为 `route` 后通过。
  - 已梳理当前未完成项：远端 CI 首次确认、真实外部通知网关、正式 RBAC、完整富文本编辑器、深度套卷报告中心、完整在线判题和 AI 主观题批改等。
- 验证：
  - 后端 `mvn -q test` 通过。
  - 前端 `npm run lint` 通过。
  - `GET /api/health` 通过。
  - `POST /api/auth/login` 使用 `demo / yanma408` 通过并返回 token。
  - `GET /api/questions/search?page=0&size=5` 通过。
  - `GET /api/study/dashboard`、`GET /api/mistakes/review-queue`、`GET /api/exams`、`GET /api/exams/reports/overview` 携带 Bearer token 均通过。
  - 前端 `/`、`/login`、`/question-bank`、`/mistakes`、`/exams`、`/analysis`、`/admin`、`/account/security` 均返回 200。
- 遗留问题：
  - `8080` 和 `8081` 被其他服务占用，但项目默认使用 `18082`，不影响本项目。
  - 本机仓库仍未配置 Git remote，远端 CI 尚未真实触发确认。
  - 当前终端会话中前后端服务保持运行；如需释放内存，可停止前端 Node、后端 Java 以及按需停止 Docker Compose。
- 下一步：
  - 继续以 MVP 验收为主线，优先完成远端 CI 确认、生产环境变量配置和上线前演示策略。

## 2026-05-08 09:40 CI、账号安全与 MVP 后增强收口

- 状态：已完成
- 目标：将 PostgreSQL 回归脚本和 E2E 接入 CI/发布前检查，补齐密码重置、登录限流、审计日志和 token 管理可观测性，并推进套卷趋势图表、外部通知渠道、审核权限和富文本编辑器的 MVP 后增强。
- 已做：
  - 新增 `scripts/preflight.sh`，串联 PostgreSQL 回归、前端依赖安全扫描、本地 H2 后端、前端服务和 Playwright E2E。
  - 新增 `.github/workflows/preflight.yml`，在 push/PR 上执行发布前检查。
  - 补齐密码重置、密码强度策略、登录失败限流、认证审计日志、Token 列表和指定 Token 失效接口。
  - 新增账号安全页 `/account/security`，接入密码重置、Token 管理、审计日志和通知渠道偏好。
  - 新增通知渠道偏好表和接口，通知调度可按启用渠道生成站内、浏览器、邮件类型通知记录。
  - 管理后台题目审核支持审核备注和基础角色约束，题干编辑补充 Markdown/HTML 快捷编辑与预览。
  - 套卷报告总览补充趋势分析图表，保留错题回灌接口。
  - 修复通知偏好保存的 H2/PostgreSQL SQL 兼容问题。
  - 修复账号安全页 hydration mismatch。
- 验证：
  - 后端 `mvn test` 通过，30 个测试全部通过。
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
  - 前端 `npm audit --omit=dev` 通过，0 vulnerabilities。
  - `scripts/preflight.sh` 完整通过，包含 PostgreSQL 回归、前端构建、依赖安全扫描和 Playwright E2E。
- 遗留问题：
  - GitHub Actions 需在远端仓库首次触发确认 runner 环境。
  - 通知渠道当前完成偏好和通知记录，真实邮件/浏览器 Push/微信网关还需接入第三方服务。
  - 审核权限当前为基础接口角色约束，后续应接入正式 RBAC。
  - 富文本编辑当前为轻量工具，后续可替换为完整编辑器。
- 下一步：
  - 准备 MVP 发布验收清单、演示数据重置、数据库备份恢复和最小运维手册。

## 2026-05-08 09:55 MVP 发布验收与运维脚本

- 状态：已完成
- 目标：补齐 MVP 发布验收清单、演示数据重置、数据库备份恢复和最小运维手册。
- 已做：
  - 新增 `scripts/backup-postgres.sh`，使用 Docker Compose 中的 PostgreSQL 容器生成 custom-format 备份。
  - 新增 `scripts/restore-postgres.sh`，通过 `CONFIRM_RESTORE=restore-demo` 显式确认后删除并恢复 `public` schema。
  - 新增 `scripts/reset-demo-data.sh`，通过 `CONFIRM_RESET=reset-demo` 显式确认后重置 demo 账号、种子题、套卷、今日任务，并清理练习、错题、套卷作答、通知、token 和审计日志；支持 `DRY_RUN=true`。
  - 新增 `docs/deployment/mvp-release-checklist.md`，覆盖发布前检查、环境变量、演示数据重置、备份、恢复和发布判定。
  - 新增 `docs/deployment/operations-runbook.md`，覆盖本地服务、发布前、回滚和常见故障。
  - README 与本地运行手册补充发布验收和运维脚本入口。
- 验证：
  - `bash -n scripts/backup-postgres.sh scripts/restore-postgres.sh scripts/reset-demo-data.sh` 通过。
  - `scripts/backup-postgres.sh` 成功生成 `/tmp/yanma408-validation.dump`。
  - `CONFIRM_RESET=reset-demo DRY_RUN=true scripts/reset-demo-data.sh` 通过且回滚。
  - `CONFIRM_RESTORE=restore-demo scripts/restore-postgres.sh /tmp/yanma408-validation.dump` 恢复成功。
  - 恢复后 `scripts/regression-postgres.sh` 通过，包含后端 30 个测试、前端 lint/build 和 PostgreSQL smoke API。
- 遗留问题：
  - 当前本机仓库未配置 Git remote，无法直接触发远端 GitHub Actions；配置 remote 后需要首次确认 `Preflight` 工作流通过。
- 下一步：
  - 配置远端仓库并触发 CI。
  - 准备生产环境变量和默认 demo 账号处理策略。

## 2026-05-08 10:05 生产环境变量与 demo 账号发布护栏

- 状态：已完成
- 目标：补齐生产环境变量样例、默认 demo 账号处理策略和发布 readiness 检查。
- 已做：
  - 后端 `application.yml` 同时兼容 `YANMA408_DB_*` 和 `SPRING_DATASOURCE_*` 环境变量。
  - 新增 `application-prod.yml`，生产 profile 关闭 H2 console，并要求数据库连接变量由环境提供。
  - 新增 `.env.production.example`，列出生产 API、数据库、Redis、备份和 demo 账号处理变量。
  - 新增 `scripts/production-readiness-check.sh`，检查 Git remote、Preflight workflow、发布文档、生产 API 地址、数据库地址、默认密码、生产 profile 和 demo 账号处理策略。
  - 新增 `scripts/lock-demo-account.sh`，通过 `CONFIRM_LOCK_DEMO=lock-demo` 显式确认后为 demo 账号设置随机不可见密码并撤销 token；支持 `DRY_RUN=true`。
  - README、运行手册、发布验收清单和运维手册已补充新脚本入口。
- 验证：
  - `bash -n` 校验新增脚本通过。
  - 使用临时生产 env 执行 `SKIP_REMOTE_CHECK=true scripts/production-readiness-check.sh` 通过。
  - `CONFIRM_LOCK_DEMO=lock-demo DRY_RUN=true scripts/lock-demo-account.sh` 通过且回滚。
- 遗留问题：
  - 当前仍没有 Git remote，真实远端 CI 触发需要配置 `origin` 后执行。
- 下一步：
  - 配置 GitHub remote 并触发 `Preflight` workflow。

## 2026-04-30 14:15 项目骨架初始化

- 状态：已完成
- 目标：初始化研码408项目基础架构，包含 Next.js 前端、Spring Boot 后端、DDD 包结构、本地基础设施配置和基础文档。
- 已做：
  - 创建根目录 README。
  - 创建 `apps/web` Next.js 项目。
  - 创建“研码408”学习仪表盘原型页面。
  - 创建 `apps/server` Spring Boot 项目。
  - 创建后端轻量 DDD 初始包结构。
  - 创建 `GET /api/health` 健康检查接口。
  - 创建题库领域初始模型。
  - 创建练习领域初始模型。
  - 创建 Docker Compose 配置，包含 PostgreSQL 和 Redis。
  - 创建 `.gitignore`。
  - 创建系统设计文档和项目状态文档。
- 验证：
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
  - 后端 `mvn test` 通过。
  - 前端开发服务器已启动，`http://localhost:3000` 返回 200。
- 遗留问题：
  - Docker Desktop 当前配置的镜像源 `docker.m.daocloud.io` 无法 DNS 解析，导致 PostgreSQL/Redis 镜像拉取失败。
  - 后端健康检查当时尚未在真实 PostgreSQL 环境下验证。
  - 当前前端只有仪表盘原型，尚未拆分业务路由。
- 下一步：
  - 修复 Docker 镜像源或改用可访问 registry。
  - 引入 Flyway 并创建第一版数据库迁移。
  - 实现题库领域持久化和基础查询 API。
  - 前端拆分 dashboard、question-bank、practice、mistakes、exams、analysis、admin 页面。

## 2026-04-30 14:20 题库基础 API

- 状态：已完成
- 目标：建立题库领域第一版数据库结构、种子数据和查询接口，让前端后续可以从真实 API 获取题目列表和题目详情。
- 已做：
  - 引入 Flyway。
  - 创建第一版题库数据库迁移和种子数据。
  - 创建题库查询 DTO、查询服务、JDBC 仓储和 REST Controller。
  - 创建 `GET /api/questions`。
  - 创建 `GET /api/questions/{id}`。
  - 创建统一 404 错误响应。
  - 增加 `local-h2` profile，便于在 Docker/PostgreSQL 暂不可用时运行后端。
- 验证：
  - `mvn test` 已通过。
  - `GET /api/health` 已通过，使用 `local-h2` profile 在 8081 端口验证。
  - `GET /api/questions` 已通过，返回 2 道种子题。
  - `GET /api/questions/00000000-0000-0000-0000-000000000401` 已通过，返回题目详情、选项和知识点。
- 遗留问题：
  - Docker 镜像源仍未修复，真实 PostgreSQL 环境还未验证。
  - 8080 端口已被本机另一个 Java 进程占用，本次后端 HTTP 验证使用 8081。
- 下一步：
  - 前端题库页和做题页接入题库 API。

## 2026-04-30 16:15 前端题库页面接入 API

- 状态：已完成
- 目标：创建 `/question-bank` 和 `/practice/[id]` 页面，并从后端题库 API 获取题目列表和详情。
- 已做：
  - 创建前端 API client。
  - 创建题库标签映射。
  - 创建 `/question-bank` 页面，支持科目筛选、题目列表、题量和分值统计。
  - 创建 `/practice/[id]` 页面，支持加载题目详情、选择选项、提交答案和显示解析。
  - 仪表盘导航和“开始刷题”按钮已链接到题库页。
  - 后端增加 CORS 配置，允许 `http://localhost:3000` 访问 API。
- 验证：
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
  - 后端 `mvn test` 通过。
  - CORS 验证通过，响应包含 `Access-Control-Allow-Origin: http://localhost:3000`。
  - `http://localhost:3000/question-bank` 返回 200。
  - 重启前端 dev server 后，`http://localhost:3000/practice/00000000-0000-0000-0000-000000000401` 返回 200。
- 遗留问题：
  - 当前前端 API 地址默认指向 `http://localhost:8081/api`，后续接正式环境时需要配置 `.env`。
  - 尚未做浏览器视觉截图验证。
- 下一步：
  - 做练习提交接口，把前端“提交答案”从本地判断升级为后端判题。
  - 实现错题自动归档。

## 2026-04-30 16:22 修复 Docker 镜像源

- 状态：已完成
- 目标：配置可用 Docker registry mirror，使 PostgreSQL/Redis 镜像可以正常拉取并启动本地基础设施。
- 已做：
  - 检查 `docker info`，确认原配置包含 `docker.m.daocloud.io` 等多个镜像源。
  - 确认失败原因是 `docker.m.daocloud.io` DNS 无法解析。
  - 测试候选源，`https://docker.1panel.live/v2/` 当前可访问。
  - 更新 `~/.docker/daemon.json`，将 registry mirror 收敛为 `https://docker.1panel.live`。
  - 重启 Docker Desktop 后确认配置生效。
  - 验证发现 `docker.1panel.live` 对 `postgres:17-alpine` manifest 返回 403，不能作为可用 mirror。
  - 已改为移除 registry mirror，准备验证 Docker Hub 官方 registry 直连。
  - 官方 registry 可拉取小镜像 `hello-world`，但拉取 PostgreSQL/Redis 时出现 EOF。
  - 测试 `docker.xuanyuan.me`，确认它对 `postgres:17-alpine` 和 `redis:7-alpine` manifest 返回 200。
  - 已将 registry mirror 改为 `https://docker.xuanyuan.me`。
  - 验证发现 `docker.xuanyuan.me` 对 Redis 返回异常 descriptor，不能稳定使用。
  - 宿主机重新测试 `docker.m.daocloud.io` 已恢复标准鉴权响应，已切回 DaoCloud 单源继续验证。
  - PostgreSQL/Redis 镜像已通过 DaoCloud 成功拉取。
  - PostgreSQL 容器已启动并处于 healthy。
  - 发现本机 6379 端口被已有 Docker 进程占用。
  - 将项目 Redis 端口映射从 `6379:6379` 改为 `6380:6379`。
  - 使用真实 PostgreSQL 启动后端，Flyway 迁移成功。
  - 发现题库列表 SQL 在 PostgreSQL 下对空筛选参数无法推断类型，已改为动态拼接筛选条件。
- 验证：
  - `docker info` 确认当前 registry mirror 为 `https://docker.m.daocloud.io/`。
  - `docker compose -f deploy/docker-compose.yml up -d` 已成功启动 PostgreSQL 和 Redis。
  - `docker compose -f deploy/docker-compose.yml ps` 显示 PostgreSQL healthy，Redis running。
  - `docker exec yanma408-postgres pg_isready -U yanma408 -d yanma408` 通过。
  - `docker exec yanma408-redis redis-cli ping` 返回 `PONG`。
  - 后端连接真实 PostgreSQL 启动成功，Flyway 显示 schema version 1。
  - `GET /api/questions` 在真实 PostgreSQL 下返回 2 道题。
  - `GET /api/questions?subject=DATA_STRUCTURE` 在真实 PostgreSQL 下返回 1 道题。
  - 数据库查询 `select count(*) from questions;` 返回 2。
- 遗留问题：
  - 本机 8080 已被另一个 Java 进程占用，后端验证使用 8081。
  - 本机 6379 已被已有 Docker 进程占用，项目 Redis 对外端口使用 6380。
- 下一步：
  - 后续将后端默认开发端口策略和 Redis 配置写入 `.env.example`。

## 2026-04-30 16:36 练习提交与错题归档

- 状态：已完成
- 目标：实现练习提交接口、后端判题和答错自动归档错题，并让前端做题页调用真实提交接口。
- 已做：
  - 创建第二版 Flyway 迁移 `V2__practice_attempts_and_mistakes.sql`。
  - 新增 `practice_attempts` 表，用于记录用户每次提交、用时、正误和提交时间。
  - 新增 `mistakes` 表，用于记录错题归档、错误次数、最近一次提交和掌握状态。
  - 新增 `POST /api/practice/attempts` 提交接口。
  - 新增后端判题用例：提交答案后读取题目标准答案，生成提交记录。
  - 新增错题自动归档用例：答错时写入或更新错题本，答对时不归档。
  - 前端做题页已从本地判题改为调用真实提交接口。
  - 前端 API client 新增 `submitAnswer`。
- 验证：
  - 后端 `mvn test` 通过。
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
  - 后端已连接真实 PostgreSQL 在 8081 端口启动，Flyway schema version 2。
  - 错答提交验证通过：`POST /api/practice/attempts` 返回 `correct=false`、`enteredMistakeBook=true`、`wrongCount=1`。
  - 正答提交验证通过：`POST /api/practice/attempts` 返回 `correct=true`、`enteredMistakeBook=false`。
  - 数据库验证：`practice_attempts` 有 3 条联调提交记录，`mistakes` 仅归档错题 `00000000-0000-0000-0000-000000000401`。
- 遗留问题：
  - 当前接口使用固定开发用户 ID，后续接入登录后需要替换为认证用户。
  - 错题本列表页和复习状态更新接口尚未实现。
- 下一步：
  - 实现 `GET /api/mistakes` 错题本查询接口。
  - 创建前端 `/mistakes` 页面，展示错题、错误次数、知识点和复习入口。

## 2026-05-02 23:29 错题本查询与页面

- 状态：已完成
- 目标：实现 `GET /api/mistakes` 错题本查询接口，并创建前端 `/mistakes` 页面展示错题、错误次数、知识点和复习入口。
- 已做：
  - 后端新增错题查询 DTO：`MistakeSummary`。
  - 后端新增错题查询仓储接口和 JDBC 查询实现。
  - 后端新增错题查询应用服务。
  - 后端新增 `GET /api/mistakes` 接口，当前使用固定开发用户 ID，支持可选 `userId` 查询参数。
  - 前端 API client 新增 `fetchMistakes` 和 `MistakeSummary` 类型。
  - 新增前端 `/mistakes` 页面，展示错题、错次、掌握状态、最近出错时间、知识点和复习入口。
  - 首页侧边栏“错题本”已链接到 `/mistakes`。
- 验证：
  - 后端 `mvn test` 通过。
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
  - 后端已用最新代码在 8081 端口重启，连接真实 PostgreSQL 成功。
  - `GET /api/mistakes` 联调通过，返回 1 条错题，包含错次、掌握状态、最近出错时间和知识点。
  - `http://localhost:3000/mistakes` 返回 200。
  - Browser Use 打开 `/mistakes` 后确认页面可见，展示 1 条错题和“开始复习”入口。
- 遗留问题：
  - 当前仍使用固定开发用户 ID，接入登录后需要改为认证用户。
  - 错题本页面暂未支持筛选、排序和标记掌握操作。
- 下一步：
  - 将仪表盘“最近错题”接入 `GET /api/mistakes`。
  - 实现错题本筛选和掌握状态更新接口。

## 2026-05-02 23:35 仪表盘错题接入与错题本增强

- 状态：已完成
- 目标：将仪表盘“最近错题”接入 `GET /api/mistakes`，并实现错题本筛选和掌握状态更新接口。
- 已做：
  - `GET /api/mistakes` 新增 `subject` 和 `mastered` 查询参数。
  - 新增 `PATCH /api/mistakes/{id}/mastery`，支持将错题切换为已掌握或待复习。
  - 后端新增 `MistakeFilter` 查询对象。
  - 错题 JDBC 查询实现改为按筛选条件动态拼接 SQL。
  - 前端 API client 新增错题筛选参数和 `updateMistakeMastery`。
  - 前端 `/mistakes` 页面新增科目筛选、掌握状态筛选和掌握状态切换按钮。
  - 仪表盘“最近错题”接入 `GET /api/mistakes`，展示最近 3 条真实错题，并链接到错题本和做题页。
- 验证：
  - 后端 `mvn test` 通过。
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
  - 后端已用最新代码在 8081 端口重启，连接真实 PostgreSQL 成功。
  - `GET /api/mistakes?subject=DATA_STRUCTURE` 联调通过。
  - `PATCH /api/mistakes/{id}/mastery` 联调通过，已验证切换为待复习和恢复为已掌握。
  - `GET /api/mistakes?mastered=false` 和 `GET /api/mistakes?mastered=true` 联调通过。
  - Browser Use 验证首页“最近错题”和 `/mistakes` 筛选/切换入口均已渲染。
- 遗留问题：
  - 当前仍使用固定开发用户 ID，接入登录后需要改为认证用户。
  - 错题本筛选当前支持科目和掌握状态，尚未支持知识点、难度、错次区间和全文搜索。
- 下一步：
  - 将仪表盘“薄弱知识点”接入真实统计。
  - 实现学习分析聚合接口。

## 2026-05-02 23:42 完整代码审查

- 状态：已完成
- 目标：结合任务日志和项目状态，审查当前前后端实现，识别可能导致运行时异常、数据状态错乱、前后端不一致或后续难以处理的问题。
- 已做：
  - 阅读任务日志、项目状态和系统设计文档，确认当前已实现范围。
  - 审查后端题库、练习提交、错题查询和掌握状态更新链路。
  - 审查前端 API client、仪表盘、题库页、做题页和错题本页。
  - 审查数据库迁移、本地 Docker Compose、CORS 和测试配置。
  - 使用异常参数验证边界行为。
- 验证：
  - 后端 `mvn test` 通过。
  - 前端 `npm run lint` 通过。
  - Docker PostgreSQL/Redis 容器运行正常。
  - 后端 `GET /api/health` 通过。
  - 验证发现：不存在的错题 ID 调用 `PATCH /api/mistakes/{id}/mastery` 当前返回 200。
  - 验证发现：超大 `elapsedSeconds` 提交练习会触发 500。
  - 验证发现：当前环境下 `npm run build` 因 `next/font/google` 无法拉取 Google Fonts 失败。
- 遗留问题：
  - 需要修复本次审查发现的问题后，再重新跑完整验证。
- 下一步：
  - 优先修复构建失败、请求用户 ID 可覆盖、错题状态更新无 404、用时溢出 500、筛选视图状态更新不一致等问题。

## 2026-05-02 23:50 审查问题优先修复

- 状态：已完成
- 目标：修复完整代码审查中发现的优先问题，包括构建依赖外网字体、客户端覆盖用户 ID、错题状态更新无 404、用时溢出 500、筛选视图状态不一致。
- 已做：
  - 前端移除 `next/font/google`，改用系统字体和 Tailwind 字体变量，生产构建不再依赖 Google Fonts。
  - 后端练习提交接口移除外部 `userId` 入参，当前统一使用固定开发用户 ID。
  - 后端错题查询和掌握状态更新接口移除外部 `userId` 入参，当前统一使用固定开发用户 ID。
  - 错题掌握状态更新检查数据库更新行数，找不到错题时返回 404。
  - 练习提交 `elapsedSeconds` 增加最大值校验，超出 `Integer.MAX_VALUE` 时返回 400。
  - 全局异常处理补充请求体验证错误响应。
  - 前端错题本掌握状态切换后按当前筛选条件更新列表，避免筛选视图状态不一致。
  - 后端测试补充 userId 忽略、错题更新 404、用时溢出 400 三个回归用例。
- 验证：
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
  - 后端 `mvn test` 通过，当前 4 个测试全部通过。
  - 后端已用最新代码在 8081 端口重启，连接真实 PostgreSQL 成功。
  - `PATCH /api/mistakes/{id}/mastery` 对不存在 ID 返回 404。
  - `POST /api/practice/attempts` 对超大 `elapsedSeconds` 返回 400。
  - `GET /api/mistakes?userId=...` 不再按客户端 userId 切换用户数据。
  - 数据库确认没有写入负数或空用时记录。
  - Browser Use 验证 `/mistakes` 页面仍可正常渲染。
- 遗留问题：
  - 当前仍是固定开发用户 ID，后续接入登录后需要从认证上下文获取用户。
  - 测试已覆盖本次优先修复边界，但题库查询、错题归档和前端交互仍可继续补更完整的自动化测试。
- 下一步：
  - 接入登录注册前，提取统一的当前用户提供器，避免多个 Controller 重复硬编码开发用户。
  - 继续实现仪表盘薄弱知识点真实统计和学习分析聚合接口。

## 2026-05-03 00:00 当前用户提供器与学习分析聚合

- 状态：已完成
- 目标：提取统一当前用户提供器，避免 Controller 重复硬编码开发用户；实现学习分析聚合接口，并让仪表盘“薄弱知识点”接入真实数据。
- 已做：
  - 新增 `CurrentUserProvider` 接口和 `DevCurrentUserProvider` 实现。
  - `PracticeController`、`MistakeController` 改为通过 `CurrentUserProvider` 获取当前用户。
  - 新增学习分析聚合接口 `GET /api/study/dashboard`。
  - 新增 `StudyDashboardQueryService`、`StudyDashboardRepository` 和 JDBC 查询实现。
  - 聚合接口当前返回薄弱知识点列表，按未掌握错题数、累计错次和最近出错时间排序。
  - 前端 API client 新增 `fetchStudyDashboard` 和 `StudyDashboard` 类型。
  - 仪表盘“薄弱知识点”已从静态数组改为读取 `GET /api/study/dashboard`。
  - 后端测试补充 `GET /study/dashboard` 聚合接口回归用例。
- 验证：
  - 后端 `mvn test` 通过，当前 5 个测试全部通过。
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
  - 后端已用最新代码在 8081 端口重启，连接真实 PostgreSQL 成功。
  - `GET /api/study/dashboard` 真实联调通过，返回 `二叉树遍历` 薄弱知识点。
  - Browser Use 验证首页“薄弱知识点”展示真实聚合结果。
- 遗留问题：
  - 当前用户提供器仍是开发实现，后续接入登录后需要替换为认证上下文实现。
  - 学习分析当前只聚合薄弱知识点，四科掌握度、今日目标和本周正确率仍是静态数据。
- 下一步：
  - 接入登录注册或至少预留 Spring Security 当前用户实现。
  - 继续将四科掌握度、今日目标、本周正确率接入真实聚合。

## 2026-05-03 00:05 Spring Security 预留与仪表盘聚合增强

- 状态：已完成
- 目标：预留 Spring Security 当前用户实现，并将仪表盘四科掌握度、今日目标、本周正确率接入真实学习分析聚合。
- 已做：
  - 引入 `spring-boot-starter-security`。
  - 新增 `SecurityConfig`，当前阶段放行所有请求并关闭 CSRF，避免影响前端开发联调。
  - 将 `DevCurrentUserProvider` 替换为 `SpringSecurityCurrentUserProvider`，优先从 Spring Security 上下文读取 UUID，未登录或非 UUID 时回退开发用户。
  - `GET /api/study/dashboard` 扩展返回今日目标、本周正确率、四科掌握度和薄弱知识点。
  - 学习分析 JDBC 查询新增今日完成数、近 7 天正确率、上周环比、四科练习数、正确数、掌握百分比和每科最弱知识点。
  - 前端 `StudyDashboard` 类型同步扩展。
  - 仪表盘今日目标、本周正确率、四科掌握度从静态展示改为真实聚合数据。
  - 四科掌握度文案改为“按当前练习记录计算”，与当前聚合口径保持一致。
  - 后端测试增强 `/study/dashboard` 断言，覆盖今日目标、周正确率和四科掌握度。
- 验证：
  - 后端 `mvn test` 通过，当前 5 个测试全部通过。
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
  - 后端已用最新代码在 8081 端口重启，连接真实 PostgreSQL 成功。
  - `GET /api/study/dashboard` 真实联调通过，返回今日目标、本周正确率、四科掌握度和薄弱知识点。
  - Browser Use 验证首页已展示真实聚合结果：今日目标 `0 / 60`、本周正确率 `67%`、数据结构掌握度 `50%`、计组掌握度 `100%`。
- 遗留问题：
  - 目前 Spring Security 只是预留骨架，尚未实现注册、登录、密码存储、会话或 JWT。
  - 连续学习和今日任务仍是静态数据。
- 下一步：
  - 实现用户注册/登录，替换当前开发用户回退逻辑。
  - 将连续学习、今日任务和学习计划接入真实数据。

## 2026-05-03 00:16 用户认证与学习计划聚合

- 状态：已完成
- 目标：实现用户注册/登录，替换当前开发用户回退逻辑；将连续学习、今日任务和学习计划接入真实数据。
- 已做：
  - 新增 Flyway 迁移 `V3__users_auth_and_study_tasks.sql`。
  - 新增 `app_users`、`auth_tokens`、`study_plan_tasks` 表。
  - 初始化演示账号 `demo / yanma408`，并绑定历史练习与错题数据使用的用户 ID。
  - 新增用户认证领域与应用服务：注册、登录、当前用户查询、token 生成与哈希存储。
  - 新增认证接口：`POST /api/auth/register`、`POST /api/auth/login`、`GET /api/auth/me`。
  - 新增 `AuthTokenFilter`，通过 `Authorization: Bearer <token>` 将用户写入 Spring Security 上下文。
  - `SpringSecurityCurrentUserProvider` 移除开发用户回退逻辑，受保护接口统一从认证上下文获取当前用户。
  - 更新 Spring Security 配置：登录、注册、健康检查和题目查询放行，其余业务接口需要认证。
  - `GET /api/study/dashboard` 扩展返回连续学习天数和今日学习任务。
  - 今日目标、连续学习、本周正确率、四科掌握度、今日任务、薄弱知识点均接入真实聚合数据。
  - 前端新增 `/login` 页面，支持登录和注册，登录后保存 token 并跳转仪表盘。
  - 前端 API client 统一为练习提交、错题本和学习分析请求附加 Bearer token。
  - 首页刷新后会在客户端读取本地登录态，再加载真实仪表盘数据。
- 验证：
  - 后端 `mvn test` 通过，当前 5 个测试全部通过。
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
  - 后端已用最新代码在 8081 端口重启，连接真实 PostgreSQL 成功。
  - Flyway 已在真实 PostgreSQL 从 schema version 2 迁移到 version 3。
  - `POST /api/auth/login` 使用 `demo / yanma408` 登录成功，返回 token。
  - 不带 token 访问 `GET /api/study/dashboard` 被 Spring Security 拦截。
  - 带 token 访问 `GET /api/auth/me` 返回当前 demo 用户。
  - 带 token 访问 `GET /api/study/dashboard` 返回今日目标、连续学习、周正确率、四科掌握度、今日任务和薄弱知识点。
  - Browser Use 验证 `/login` 登录后跳转首页，刷新后仍能读取 token 并展示真实仪表盘数据。
- 遗留问题：
  - 当前 token 是自建持久 token，适合 MVP 联调；后续可升级为 JWT、刷新 token、退出登录服务端失效和更完整的账号安全策略。
  - 学习计划任务当前只有初始化种子数据，还没有创建、编辑、完成任务接口。
  - 自动化测试已覆盖后端核心回归，前端登录流程暂为 Browser Use 手工验证，后续可补 Playwright/E2E。
- 下一步：
  - 实现学习计划任务的完成状态更新接口。
  - 将做题提交后对今日任务和连续学习的影响做页面内即时刷新。
  - 继续扩展题库 CRUD、套卷和学习分析页面。

## 2026-05-03 00:36 学习任务状态更新

- 状态：已完成
- 目标：实现学习计划任务完成状态更新接口，并让首页今日任务可以标记完成或恢复待开始。
- 已做：
  - 新增 `StudyTaskCommandService`，封装学习任务状态更新用例。
  - 新增 `StudyTaskRepository` 和 `JdbcStudyTaskRepository`，按 `task_id + user_id` 更新任务状态，避免越权修改他人任务。
  - 新增 `PATCH /api/study/tasks/{id}/status` 接口，支持 `PENDING` 和 `DONE`。
  - 不存在或不属于当前用户的任务更新返回 404。
  - 不支持的任务状态返回 400。
  - 后端测试新增学习任务更新成功、任务不存在 404、非法状态 400 三个回归用例。
  - 前端 API client 新增 `updateStudyTaskStatus`。
  - 首页“今日任务”新增“完成/恢复”按钮，更新成功后重新拉取学习仪表盘聚合数据。
  - 已完成任务在首页展示为“已完成”，标题置灰并加删除线。
- 验证：
  - 后端 `mvn test` 通过，当前 8 个测试全部通过。
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
  - 后端已用最新代码在 8081 端口重启，真实 PostgreSQL schema version 3 无需额外迁移。
  - 真实接口联调通过：`PATCH /api/study/tasks/{id}/status` 可将任务改为 `DONE` 并在 `GET /api/study/dashboard` 中返回已完成状态。
  - 真实接口联调通过：任务可从 `DONE` 恢复为 `PENDING`。
  - Browser Use 验证首页任务按钮可完成和恢复，页面状态同步刷新，无错误提示。
- 遗留问题：
  - 任务当前只支持状态更新，尚未支持创建、编辑、删除、按计划日期查询。
  - 今日任务完成后暂未计入今日目标；当前今日目标仍按真实做题提交数统计。
- 下一步：
  - 实现学习计划任务 CRUD 或至少任务创建接口。
  - 做题提交成功后增加“返回仪表盘/继续下一题”的学习流转，并让仪表盘重新进入时展示最新今日目标和连续学习。
  - 开始扩展题库管理能力或套卷模块。

## 2026-05-03 00:48 学习任务创建与套卷入口

- 状态：已完成
- 目标：实现学习计划任务创建接口；做题提交后补齐返回仪表盘和继续下一题流转；启动套卷模块最小可用列表。
- 已做：
  - 新增 `CreateStudyTaskCommand`，学习任务命令服务支持创建任务。
  - 新增 `POST /api/study/tasks`，支持创建当前用户的学习任务，默认任务状态为 `PENDING`。
  - 学习任务创建校验科目、任务类型、优先级、题量和预计用时。
  - 前端首页“今日任务”新增创建表单，创建成功后重新拉取仪表盘聚合。
  - 做题页提交成功后新增“返回仪表盘”和“继续下一题”入口。
  - 做题页通过题库列表计算下一题，若已到最后一题则回到题库。
  - 新增 Flyway 迁移 `V4__exam_papers.sql`，创建 `exam_papers` 和 `exam_paper_questions`。
  - 初始化套卷种子数据 `408 迷你模拟卷 A`，关联当前两道题。
  - 新增 `GET /api/exams` 套卷列表接口。
  - 新增前端 `/exams` 页面，展示套卷数、题目数、分值、时长和练习入口。
  - 首页侧边栏“真题套卷”已链接到 `/exams`。
- 验证：
  - 后端 `mvn test` 通过，当前 11 个测试全部通过。
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过，`/exams` 已进入生产构建路由。
  - 后端已用最新代码在 8081 端口重启，真实 PostgreSQL 已从 schema version 3 迁移到 version 4。
  - 真实接口联调通过：`POST /api/study/tasks` 创建任务后，`GET /api/study/dashboard` 的今日任务数量增加。
  - 真实接口联调通过：`GET /api/exams` 返回 `408 迷你模拟卷 A`。
  - Browser Use 验证首页可创建任务，创建后任务即时出现在今日任务列表。
  - Browser Use 验证 `/exams` 页面展示真实套卷数据。
  - Browser Use 验证做题提交成功后显示“返回仪表盘”和“继续下一题”，返回仪表盘后今日目标与连续学习展示最新数据。
- 遗留问题：
  - 学习任务尚未支持编辑、删除和按日期查看。
  - 套卷模块当前只有列表，没有详情、计时作答、交卷和报告。
  - 题库管理仍未实现题目创建、编辑和上下架。
- 下一步：
  - 实现套卷详情与套卷作答入口。
  - 扩展题库管理能力，优先做题目创建接口或管理后台题目列表。
  - 为学习任务补充编辑、删除和按日期查询。

## 2026-05-03 18:32 套卷详情、题库管理与学习任务 CRUD

- 状态：已完成
- 目标：实现套卷详情与作答入口；扩展题库管理能力；为学习任务补充编辑、删除和按日期查询。
- 已做：
  - 后端新增 `GET /api/exams/{id}`，返回套卷详情和题目列表。
  - 前端新增 `/exams/[id]`，展示套卷信息、题目列表、“开始作答”和单题练习入口。
  - 套卷列表页“查看套卷”已链接到套卷详情页。
  - 后端新增题目创建能力 `POST /api/questions`，按当前登录用户保护写入。
  - 后端新增后台题目列表 `GET /api/admin/questions`，支持按科目筛选。
  - 前端新增 `/admin` 管理后台页，支持创建单选题和查看题目列表。
  - 后端学习任务扩展 `GET /api/study/tasks?date=YYYY-MM-DD`、`PUT /api/study/tasks/{id}`、`DELETE /api/study/tasks/{id}`。
  - 首页今日任务改为按日期查询，支持选择日期、新增、编辑、删除、完成和恢复待开始。
  - 学习仪表盘任务 DTO 补充 `taskDate`，方便前端展示和编辑。
  - 后端回归测试补充学习任务查询/编辑/删除、套卷详情、题目创建和后台列表。
  - 项目状态文档和系统设计文档已同步更新。
- 验证：
  - 后端 `mvn test` 通过，当前 14 个测试全部通过。
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
  - 后端已用最新代码在 8081 端口重启，真实 PostgreSQL schema version 4 正常。
  - 真实接口联调通过：`GET /api/study/tasks?date=当前日期` 返回当前用户任务列表。
  - 真实接口联调通过：`GET /api/exams/00000000-0000-0000-0000-000000000801` 返回套卷和 2 道题。
  - 真实接口联调通过：`GET /api/admin/questions` 返回后台题目列表。
  - Browser Use 验证 `/exams/[id]` 展示套卷详情和作答入口。
  - Browser Use 验证 `/admin` 展示题目创建表单和后台题目列表。
  - Browser Use 验证首页今日任务存在日期选择、编辑和删除入口。
- 遗留问题：
  - 套卷当前仍复用单题 `/practice/[id]` 作答入口，尚未实现整卷计时、交卷和考试报告。
  - 题库管理当前支持创建和列表，尚未实现题目编辑、删除、上下架和批量导入。
  - 首页任务删除按钮未在真实浏览器里执行破坏性点击，删除能力通过后端测试和接口逻辑覆盖。
- 下一步：
  - 实现套卷整卷计时作答、交卷和报告。
  - 扩展题库管理：题目编辑、删除、上下架和批量导入。
  - 为学习计划增加周期任务、提醒和按周/月视图。

## 2026-05-06 14:01 套卷作答、题库管理增强与学习计划视图

- 状态：已完成
- 目标：实现套卷整卷计时作答、交卷和报告；扩展题库管理编辑、删除、上下架和批量导入；为学习计划增加周期任务、提醒和按周/月视图。
- 已做：
  - 新增 Flyway 迁移 `V5__exam_attempts_and_study_task_recurrence.sql`。
  - 新增 `exam_attempts` 和 `exam_attempt_answers`，记录套卷作答、每题答案、得分和报告数据。
  - `study_plan_tasks` 新增 `recurrence_rule` 和 `reminder_time`，支持周期任务和提醒时间。
  - 后端新增套卷作答接口：`POST /api/exams/{id}/attempts`、`POST /api/exams/attempts/{id}/submit`、`GET /api/exams/attempts/{id}/report`。
  - 前端新增 `/exams/[id]/attempt`，支持整卷倒计时、答题卡、选项作答、交卷和报告展示。
  - 套卷详情页“开始作答”已进入整卷计时作答页。
  - 后端题库管理扩展 `GET /api/admin/questions/{id}`、`PUT /api/admin/questions/{id}`、`PATCH /api/admin/questions/{id}/status`、`DELETE /api/admin/questions/{id}`、`POST /api/admin/questions/import`。
  - 题目删除采用软删除，避免与套卷引用产生外键冲突；公开题库仍只展示 `PUBLISHED` 题目。
  - 前端 `/admin` 支持题目创建、编辑、上下架、软删除、JSON 批量导入和科目筛选列表。
  - 后端学习任务扩展 `GET /api/study/tasks/range`，并支持 `NONE/DAILY/WEEKLY/MONTHLY` 周期规则和提醒时间。
  - 首页学习任务表单新增周期和提醒时间，底部新增周/月计划视图。
  - 前端默认 API 地址从 `http://localhost:8081/api` 调整为 `http://localhost:8082/api`，避开本机 8081 的 nginx 占用。
  - 项目状态文档和系统设计文档已同步更新。
- 验证：
  - 后端 `mvn test` 通过，当前 17 个测试全部通过。
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
  - Docker PostgreSQL/Redis 运行正常。
  - 后端已在 8082 端口启动，真实 PostgreSQL schema 已迁移到 version 5。
  - 真实接口联调通过：登录 demo 后创建套卷 attempt，提交 2 题答案，报告返回 `SUBMITTED 1/2 50%`。
  - 真实接口联调通过：`GET /api/study/tasks/range`、`GET /api/admin/questions` 可访问。
  - Browser Use 验证 `/exams/[id]/attempt` 可完成整卷作答并展示 50% 报告。
  - Browser Use 验证 `/admin` 展示批量导入、题目表单、题目列表和编辑/上下架/删除入口。
  - Browser Use 验证首页展示学习任务周/月计划视图和周期/提醒信息。
- 遗留问题：
  - 套卷报告当前只展示本次交卷结果，尚未提供历史报告列表和多次重做对比。
  - 周期任务状态当前按任务模板共享，尚未支持某个周期实例单独跳过或单独完成。
  - 提醒时间当前只在计划中展示，尚未接入服务端提醒推送。
  - 题库批量导入当前使用 JSON 文本，尚未支持 Excel/CSV 文件上传和导入预校验。
- 下一步：
  - 增加套卷历史记录、报告列表和重做对比。
  - 扩展题库管理：题目审核、批量编辑、标签体系和富文本/图片题干。
  - 为学习计划增加单次跳过周期实例、服务端提醒推送和周/月计划编辑体验。

## 2026-05-06 14:46 套卷历史、题库审核标签与学习计划实例

- 状态：已完成
- 目标：增加套卷历史记录、报告列表和重做对比；扩展题库管理审核、批量编辑、标签体系和富文本/图片题干；为学习计划增加单次跳过周期实例、服务端提醒推送和周/月计划编辑体验。
- 已做：
  - 新增 Flyway 迁移 `V6__question_review_tags_and_study_occurrences.sql`。
  - `questions` 新增 `review_status`、`stem_format`、`stem_image_url` 字段。
  - 新增 `question_tags` 和 `question_tag_relations`，支持题目标签。
  - 新增 `study_task_occurrences`，支持周期任务某一天实例独立完成、跳过或恢复待开始。
  - 后端套卷模块新增历史和对比接口：`GET /api/exams/attempts`、`GET /api/exams/{id}/attempts`、`GET /api/exams/{id}/attempts/compare`。
  - 前端套卷详情页展示作答历史，历史记录可打开报告；最近两次交卷可展示得分、正确率和逐题变化对比。
  - 后端题库管理新增审核接口 `PATCH /api/admin/questions/{id}/review` 和批量更新接口 `PATCH /api/admin/questions/bulk`。
  - 题目创建、编辑、列表和详情已携带审核状态、题干格式、题图地址和标签。
  - 公开题库查询只展示 `PUBLISHED + APPROVED` 题目，未审核或驳回题目不会进入学生刷题入口。
  - 前端管理后台支持题目审核状态切换、标签编辑、批量审核和批量打标签。
  - 后端学习计划新增 `PATCH /api/study/tasks/{id}/occurrences/{date}/status`，支持周期实例单独状态。
  - 后端学习计划新增 `GET /api/study/reminders` 和 `GET /api/study/reminders/stream`，当前返回当天未完成且未跳过的提醒任务。
  - 首页接入提醒列表，并在任务状态更新后同步刷新计划和提醒。
  - 补强后端测试基线，重置种子题的审核状态、题干格式、题图、选项、知识点和标签，避免测试互相污染。
  - 后端新增 V6 回归测试：周期实例跳过与提醒过滤、套卷历史与重做对比、题目审核标签与批量更新。
- 验证：
  - 后端 `mvn test` 通过，当前 20 个测试全部通过。
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
- 遗留问题：
  - 学习提醒当前是查询接口和 SSE 快照，不是真正的服务端定时推送或多渠道通知。
  - 题库批量导入仍是 JSON 文本，尚未支持 Excel/CSV 文件上传、导入预校验和错误行反馈。
  - 管理后台有审核状态与标签能力，但还没有更完整的审核工作流权限、审核备注和富文本编辑器。
  - 套卷对比当前聚焦最近两次提交，尚未提供跨套卷历史中心、长期趋势图和错题回灌策略。
- 下一步：
  - 为题库导入增加 Excel/CSV 文件上传、导入预校验和错误行反馈。
  - 将学习计划提醒从查询/SSE 快照升级为真实定时推送，并补充通知渠道。
  - 扩展套卷报告：跨套卷历史中心、趋势分析和错题回灌策略。

## 2026-05-07 11:25 导入预校验、学习通知与套卷报告收口

- 状态：已完成
- 目标：为题库导入增加 Excel/CSV 文件上传、导入预校验和错误行反馈；将学习计划提醒升级为定时站内通知；扩展套卷报告总览、趋势和错题回灌。
- 已做：
  - 新增 Flyway 迁移 `V7__study_notifications.sql`，创建 `study_notifications` 站内通知表。
  - 后端启用 Spring 定时任务，学习通知每分钟扫描到期且未完成/未跳过的提醒任务。
  - 新增学习通知接口：`POST /api/study/notifications/dispatch`、`GET /api/study/notifications`、`PATCH /api/study/notifications/{id}/read`。
  - 新增题库导入预校验接口 `POST /api/admin/questions/import/preview`，返回总行数、有效行数、无效行数和行级错误。
  - 前端管理后台接入 `.xlsx/.xls/.csv` 文件读取，自动转换为导入 JSON，并调用预校验展示错误行反馈。
  - 新增套卷报告总览接口 `GET /api/exams/reports/overview`，返回交卷次数、平均正确率、最高分、最近正确率、趋势和薄弱题目。
  - 新增套卷错题回灌接口 `POST /api/exams/attempts/{id}/mistakes/backfill`，将套卷错题以练习提交记录形式回灌到错题本，并做重复回灌保护。
  - 前端套卷列表页展示报告总览和薄弱题目。
  - 前端套卷报告页新增“回灌错题本”操作。
  - 前端 API client 补齐导入预校验、学习通知、套卷报告总览和错题回灌方法。
- 验证：
  - 后端 `mvn test` 通过，当前 23 个测试全部通过。
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
- 遗留问题：
  - `xlsx` 依赖安装后 `npm` 报告 3 个安全告警，MVP 内部管理后台可先接受，但发布前需要评估或替换解析方案。
  - 学习通知当前为站内通知，尚未接入浏览器推送、邮件、微信等外部渠道。
  - 套卷报告趋势目前是基础数据接口和列表展示，尚未做图表化报告中心。
- 下一步：
  - 补齐学习分析独立页和错题复习队列，形成更完整的学生端 MVP 验收路径。
  - 强化发布准备：环境变量样例、一键启动脚本、真实 PostgreSQL 回归和基础 E2E。

## 2026-05-07 13:42 MVP 收口：分析页、复习队列、题库增强、发布准备、E2E 与账号安全

- 状态：已完成
- 目标：按第一版 MVP 缺口依次补齐学生端学习分析独立页、错题复习队列、题库搜索分页筛选、发布准备、基础 E2E 和服务端退出登录。
- 已做：
  - 新增 `/analysis` 学习分析独立页，复用真实 `GET /api/study/dashboard` 聚合数据展示今日完成、连续学习、本周正确率、最弱科目、四科掌握度和薄弱知识点。
  - 新增题库搜索分页接口 `GET /api/questions/search`，支持 `subject`、`keyword`、`difficulty`、`knowledgePoint`、`page`、`size`，前端题库页已接入关键词、难度、知识点和分页控件。
  - 新增错题复习队列接口 `GET /api/mistakes/review-queue`，按未掌握优先、错次更多优先、越早出错优先组织复习；前端错题本新增“复习队列”模式。
  - 新增服务端退出登录接口 `POST /api/auth/logout`，当前 token 会被服务端失效；新增过期 token 定时清理。
  - 前端退出登录改为调用服务端 logout，并在失败时仍安全清理本地认证信息。
  - 新增 `.env.example`、`scripts/dev-local.sh`、`scripts/regression-postgres.sh` 和 `docs/development/runbook.md`。
  - PostgreSQL 回归脚本现在会启动 Docker 依赖、运行后端测试、前端 lint/build、拉起后端并用真实 PostgreSQL smoke 检查健康、登录、题库搜索、学习仪表盘、错题队列和套卷报告总览。
  - 新增 Playwright 基础 E2E：登录、题库搜索、错题队列、学习分析、套卷报告总览和管理后台预校验入口。
  - Playwright 配置支持 `PLAYWRIGHT_CHANNEL=chrome` 复用本机 Chrome，避免首次运行必须下载 bundled Chromium。
  - 项目状态文档、运行手册和系统设计 API 清单已同步更新。
- 验证：
  - 后端 `mvn test` 通过，当前 26 个测试全部通过。
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
  - 后端以 `local-h2` 在 8083 端口启动成功，Flyway 7 个迁移全部应用。
  - 前端以 `NEXT_PUBLIC_API_BASE_URL=http://localhost:8083/api` 在 3000 端口启动成功。
  - `PLAYWRIGHT_CHANNEL=chrome E2E_BASE_URL=http://localhost:3000 npm run e2e` 通过，1 个 MVP smoke 用例通过。
  - `SERVER_PORT=8084 scripts/regression-postgres.sh` 通过，真实 PostgreSQL 从 schema version 5 迁移到 version 7，并完成健康检查、登录、题库搜索、学习仪表盘、错题队列和套卷报告总览 smoke 检查。
- 遗留问题：
  - 本机 8082 当前被 nginx 占用，本次 E2E 使用 8083 验证；脚本和运行手册已支持通过 `SERVER_PORT`/`NEXT_PUBLIC_API_BASE_URL` 改端口。
  - `npx playwright install chromium` 下载 bundled Chromium 时网络长时间无进展，本次改用本机 Google Chrome 通道验证通过。
  - `xlsx` 依赖仍有 `npm audit` 安全告警，发布前建议替换解析方案或明确风险接受。
- 下一步：
  - 将 PostgreSQL 回归脚本和 E2E 接入 CI/发布前检查。
  - 补齐账号安全发布项：密码重置、登录限流、审计日志和 token 管理可观测性。
  - 对套卷趋势图表、外部通知渠道、审核权限和富文本编辑器做 MVP 后增强。

## 2026-05-07 14:26 发布遗留问题收口

- 状态：已完成
- 目标：解决 8082 端口占用、Playwright bundled Chromium 下载不稳定、`xlsx` 安全告警三个发布遗留问题。
- 已做：
  - 确认 8082/8083/8084 被本机另一个 nginx 项目占用；本项目默认后端端口改为 `18082`，并同步 `.env.example`、前端默认 API、运行脚本、回归脚本、README 和运行手册。
  - Playwright 默认使用本机 Chrome channel，可通过 `PLAYWRIGHT_CHANNEL` 覆盖，避免首次运行必须下载 bundled Chromium。
  - 前端移除 `xlsx` 依赖，不再在浏览器端解析 Excel。
  - 后端新增 `org.apache.poi:poi-ooxml`，提供 Excel/CSV multipart 上传解析能力。
  - 新增题库文件导入接口：`POST /api/admin/questions/import/file`。
  - 新增题库文件预校验接口：`POST /api/admin/questions/import/preview-file`。
  - 管理后台文件选择后直接调用后端预校验，导入时走后端文件导入接口。
  - `npm` overrides 将 transitive `postcss` 提升到安全版本，`npm install` 后报告 `found 0 vulnerabilities`。
- 验证：
  - 后端 `mvn test` 通过。
  - 前端 `npm run lint` 通过。
  - 前端 `npm run build` 通过。
  - 前端 `npm audit --omit=dev` 通过，0 vulnerabilities。
  - Playwright E2E 通过。
  - PostgreSQL 回归脚本通过。
- 遗留问题：
  - 无阻塞项；本机后端默认端口已统一改为 `18082`。
- 下一步：
  - 将 PostgreSQL 回归脚本和 E2E 接入 CI/发布前检查。
  - 补齐账号安全发布项：密码重置、登录限流、审计日志和 token 管理可观测性。
  - 对套卷趋势图表、外部通知渠道、审核权限和富文本编辑器做 MVP 后增强。
