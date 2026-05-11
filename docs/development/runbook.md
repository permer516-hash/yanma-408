# 本地运行手册

## 端口

- 前端：`http://localhost:3000`
- 后端：`http://localhost:18082`
- PostgreSQL：`localhost:5432`
- Redis：`localhost:6380`

如果 `18082` 被本机服务占用，可临时指定：

```bash
SERVER_PORT=18083 NEXT_PUBLIC_API_BASE_URL=http://localhost:18083/api scripts/dev-local.sh
```

## 快速启动

H2 演示环境：

```bash
scripts/dev-local.sh
```

PostgreSQL/Redis：

```bash
docker compose -f deploy/docker-compose.yml up -d
cd apps/server
mvn spring-boot:run -Dspring-boot.run.arguments=--server.port=18082
```

前端：

```bash
cd apps/web
NEXT_PUBLIC_API_BASE_URL=http://localhost:18082/api npm run dev
```

## 回归验证

```bash
scripts/regression-postgres.sh
scripts/preflight.sh
```

当前标准验证：

```bash
cd apps/server && mvn test
cd apps/web && npm run lint && npm run build
cd apps/web && PLAYWRIGHT_CHANNEL=chrome E2E_BASE_URL=http://localhost:3000 npm run e2e
```

## 发布与运维

发布验收：

```bash
scripts/preflight.sh
```

数据库备份：

```bash
scripts/backup-postgres.sh
```

数据库恢复：

```bash
CONFIRM_RESTORE=restore-demo scripts/restore-postgres.sh backups/<backup-file>.dump
```

演示数据重置 dry-run：

```bash
CONFIRM_RESET=reset-demo DRY_RUN=true scripts/reset-demo-data.sh
```

生产环境变量检查：

```bash
ENV_FILE=.env.production scripts/production-readiness-check.sh
```

demo 账号锁定 dry-run：

```bash
CONFIRM_LOCK_DEMO=lock-demo DRY_RUN=true scripts/lock-demo-account.sh
```

更多细节：

- `docs/deployment/mvp-release-checklist.md`
- `docs/deployment/operations-runbook.md`
