# 最小运维手册

更新时间：2026-05-08 09:55 Asia/Shanghai

## 本地服务

启动 PostgreSQL/Redis：

```bash
docker compose -f deploy/docker-compose.yml up -d
```

查看状态：

```bash
docker compose -f deploy/docker-compose.yml ps
```

查看后端健康：

```bash
curl -fsS http://localhost:18082/api/health
```

## 发布前

```bash
scripts/preflight.sh
scripts/backup-postgres.sh
```

## 回滚

如果发布后需要恢复数据库：

```bash
CONFIRM_RESTORE=restore-demo scripts/restore-postgres.sh backups/<backup-file>.dump
scripts/regression-postgres.sh
```

如果只需要恢复演示环境：

```bash
CONFIRM_RESET=reset-demo scripts/reset-demo-data.sh
scripts/regression-postgres.sh
```

生产发布前锁定 demo 账号：

```bash
CONFIRM_LOCK_DEMO=lock-demo scripts/lock-demo-account.sh
```

如需改成指定强密码：

```bash
CONFIRM_LOCK_DEMO=lock-demo DEMO_NEW_PASSWORD='<strong-password>' scripts/lock-demo-account.sh
```

## 常见故障

端口占用：

```bash
lsof -nP -iTCP:18082 -iTCP:18083 -iTCP:3000 -sTCP:LISTEN
```

临时改端口：

```bash
SERVER_PORT=18084 WEB_PORT=3001 scripts/dev-local.sh
```

PostgreSQL 未就绪：

```bash
docker compose -f deploy/docker-compose.yml exec postgres pg_isready -U yanma408 -d yanma408
```

重新查看后端日志：

```bash
cd apps/server
mvn spring-boot:run -Dspring-boot.run.arguments=--server.port=18082
```

前端 E2E 浏览器下载慢：

```bash
PLAYWRIGHT_CHANNEL=chrome E2E_BASE_URL=http://localhost:3000 npm --prefix apps/web run e2e
```

## 账号

本地演示账号：

```txt
demo / yanma408
```

生产环境上线后必须禁用默认弱密码或立即重置演示账号密码。

推荐发布前执行：

```bash
ENV_FILE=.env.production scripts/production-readiness-check.sh
CONFIRM_LOCK_DEMO=lock-demo DRY_RUN=true scripts/lock-demo-account.sh
```
