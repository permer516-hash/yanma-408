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
cd apps/web && npm run test:production-smoke
cd apps/web && npm run test:e2e
```

生产启动 smoke 会复用刚刚生成的前端构建产物，默认使用 `18084` 和 `3101`
端口确认后端健康接口和 `next start` 前端都能访问。Playwright 会自动启动
E2E 后端和前端，默认使用 `18083` 和 `3100` 端口。可通过
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

## 单机生产部署

面向 OpenCloudOS 9 的生产配置位于 `deploy/production/`。该配置将前端、后端、PostgreSQL 和 HTTPS 反向代理部署在同一台服务器上；只有 `80/443` 对公网开放，数据库保持在 Docker 内网。

域名的 `@` 与 `www` A 记录解析到服务器公网 IP 后，在服务器执行：

```bash
sudo bash deploy/production/setup-opencloudos.sh
cp deploy/production/.env.example deploy/production/.env
# 编辑 deploy/production/.env，填写域名、数据库强密码和 COS 凭据。
chmod 600 deploy/production/.env
chmod +x deploy/production/deploy.sh
deploy/production/deploy.sh
```

反向代理会自动申请并续期 HTTPS 证书。部署后用 `https://<你的域名>/api/health` 检查后端健康状态。
