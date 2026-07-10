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

## 单机生产环境（OpenCloudOS 9）

生产配置使用 `deploy/production/docker-compose.yml`：Caddy 负责同域名 HTTPS 和反向代理，Next.js 前端与 Spring Boot API 使用同一个域名，PostgreSQL 只在 Docker 内网可见。

首次部署：

```bash
sudo bash deploy/production/setup-opencloudos.sh
cp deploy/production/.env.example deploy/production/.env
chmod 600 deploy/production/.env
chmod +x deploy/production/deploy.sh
deploy/production/deploy.sh
```

部署前要求：

- 域名的 `@` 和 `www` A 记录都已指向服务器公网 IP。
- 腾讯云轻量服务器防火墙和系统 firewalld 已放行 TCP `80`、`443`；不要对公网放行 PostgreSQL 或 Spring Boot 端口。
- `.env` 中已替换数据库强密码、COS SecretId 和 SecretKey；`.env` 不提交 Git。

验证：

```bash
curl -fsS https://<你的域名>/api/health
docker compose --env-file deploy/production/.env -f deploy/production/docker-compose.yml ps
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
