# 研码408

面向计算机考研 408 的刷题、复盘与学习分析平台。

## 项目结构

```txt
yanma408/
├─ apps/
│  ├─ web/       Next.js 前端
│  └─ server/    Spring Boot 后端
├─ docs/         产品、架构与接口文档
└─ deploy/       本地与生产部署配置
```

## 本地开发

启动基础设施：

```bash
docker compose -f deploy/docker-compose.yml up -d
```

启动后端：

```bash
cd apps/server
mvn spring-boot:run
```

项目默认后端开发端口为 18082，避开常见的 8080/8081/8082 本机服务占用：

```bash
mvn spring-boot:run -Dspring-boot.run.arguments=--server.port=18082
```

如果本地 PostgreSQL 暂时不可用，可以使用 H2 内存库启动后端：

```bash
cd apps/server
mvn spring-boot:run -Dspring-boot.run.profiles=local-h2
```

启动前端：

```bash
cd apps/web
npm run dev
```

默认地址：

- 前端：http://localhost:3000
- 后端：http://localhost:18082
- 健康检查：http://localhost:18082/api/health
- PostgreSQL：localhost:5432
- Redis：localhost:6380

## 发布前检查

首次运行浏览器测试前安装 Chromium：

```bash
cd apps/web
npx playwright install chromium
```

轻量发布前测试会使用隔离的 H2 内存库和独立端口，不依赖本地 PostgreSQL：

```bash
scripts/test-predeploy.sh
```

也可以分层运行：

```bash
cd apps/server && mvn test
cd apps/web && npm run lint
cd apps/web && npm run typecheck
cd apps/web && npm run build
cd apps/web && npm run test:e2e
```

Playwright 会自动启动 E2E 后端和前端，默认使用 `18083` 和 `3100` 端口。可通过
`E2E_SERVER_PORT`、`E2E_WEB_PORT`、`E2E_API_BASE_URL` 和 `E2E_BASE_URL` 覆盖。
当前轻量 E2E 覆盖服务冒烟、学生浏览题库与章节、学生/管理员入口权限、题库筛选性能，以及题库管理后台的搜索、筛选、详情弹窗和来源/难度行内编辑。

需要连 PostgreSQL、依赖审计和更完整环境检查时，继续使用原有检查：

```bash
scripts/preflight.sh
```

数据库备份、恢复和演示数据重置：

```bash
scripts/backup-postgres.sh
CONFIRM_RESTORE=restore-demo scripts/restore-postgres.sh backups/<backup-file>.dump
CONFIRM_RESET=reset-demo DRY_RUN=true scripts/reset-demo-data.sh
SKIP_REMOTE_CHECK=true ENV_FILE=.env.production.example scripts/production-readiness-check.sh
CONFIRM_LOCK_DEMO=lock-demo DRY_RUN=true scripts/lock-demo-account.sh
```

发布验收细节见：

- `docs/deployment/mvp-release-checklist.md`
- `docs/deployment/operations-runbook.md`
