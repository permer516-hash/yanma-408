# MVP 发布验收清单

更新时间：2026-05-08 09:55 Asia/Shanghai

## 目标

第一版 MVP 发布前必须确认：

- 代码质量检查通过。
- PostgreSQL 迁移和真实数据库 smoke 检查通过。
- 前端核心路径 E2E 通过。
- 演示数据可重置。
- 数据库可备份、可恢复。
- 关键环境变量、端口和运维命令有文档可查。

## 发布前检查

本地发布前执行：

```bash
scripts/preflight.sh
```

该脚本会串联：

- `scripts/regression-postgres.sh`
- 后端 `mvn test`
- 前端 `npm run lint`
- 前端 `npm run build`
- 前端 `npm audit --omit=dev`
- 本地 H2 后端 + Next.js 前端 + Playwright E2E

远端仓库发布前检查：

```bash
git remote -v
git push origin <branch>
```

确认 GitHub Actions 中 `Preflight` 工作流通过。当前本机仓库未配置 remote，因此远端首次触发需要在配置 remote 后执行。

## 环境变量

前端：

- `NEXT_PUBLIC_API_BASE_URL`：浏览器访问的后端 API 地址，例如 `https://api.example.com/api`。
- `E2E_BASE_URL`：E2E 访问的前端地址。
- `PLAYWRIGHT_CHANNEL`：本地可设置为 `chrome`；CI 默认使用 Playwright bundled Chromium。

后端：

- `SERVER_PORT`：后端端口，本地默认 `18082`。
- `SPRING_PROFILES_ACTIVE`：生产环境使用 `prod`。
- `YANMA408_DB_URL` 或 `SPRING_DATASOURCE_URL`：PostgreSQL JDBC URL。
- `YANMA408_DB_USERNAME` 或 `SPRING_DATASOURCE_USERNAME`：PostgreSQL 用户名。
- `YANMA408_DB_PASSWORD` 或 `SPRING_DATASOURCE_PASSWORD`：PostgreSQL 密码。

基础设施：

- `POSTGRES_DB`：默认 `yanma408`。
- `POSTGRES_USER`：默认 `yanma408`。
- `POSTGRES_PASSWORD`：本地默认 `yanma408`，生产必须替换。
- `REDIS_HOST`：Redis 地址。
- `REDIS_PORT`：本地默认 `6380`。
- `BACKUP_DIR`：本地数据库备份输出目录，默认 `./backups`。
- `DEMO_ACCOUNT_ACTION`：生产发布前必须显式设置为 `locked`、`removed` 或 `password-rotated`。

生产环境变量模板：

```bash
.env.production.example
```

生产环境变量检查：

```bash
ENV_FILE=.env.production scripts/production-readiness-check.sh
```

## 演示数据重置

重置前建议先备份：

```bash
scripts/backup-postgres.sh
```

演示数据 dry-run：

```bash
CONFIRM_RESET=reset-demo DRY_RUN=true scripts/reset-demo-data.sh
```

真实重置：

```bash
CONFIRM_RESET=reset-demo scripts/reset-demo-data.sh
```

重置后状态：

- 保留 demo 账号：`demo / yanma408`
- 保留两道种子题。
- 保留 `408 迷你模拟卷 A`。
- 重置今日学习任务。
- 清空练习记录、错题、套卷作答、通知、token 和审计日志。

## 数据库备份

```bash
scripts/backup-postgres.sh
```

默认输出到：

```txt
backups/yanma408-YYYYMMDD-HHMMSS.dump
```

可指定输出：

```bash
BACKUP_FILE=/tmp/yanma408-pre-release.dump scripts/backup-postgres.sh
```

## 数据库恢复

恢复会删除并重建 `public` schema，必须显式确认：

```bash
CONFIRM_RESTORE=restore-demo scripts/restore-postgres.sh backups/yanma408-YYYYMMDD-HHMMSS.dump
```

恢复后执行：

```bash
scripts/regression-postgres.sh
```

## 发布判定

可以进入 MVP 发布候选的最低条件：

- `scripts/preflight.sh` 通过。
- GitHub Actions `Preflight` 通过。
- `scripts/backup-postgres.sh` 成功生成备份。
- `CONFIRM_RESET=reset-demo DRY_RUN=true scripts/reset-demo-data.sh` 通过。
- `ENV_FILE=.env.production scripts/production-readiness-check.sh` 通过。
- `CONFIRM_LOCK_DEMO=lock-demo DRY_RUN=true scripts/lock-demo-account.sh` 通过。
- 生产环境变量不使用本地默认密码。
- 登录、刷题、错题、套卷、管理后台、账号安全页核心路径可访问。
