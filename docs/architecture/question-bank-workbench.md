# 题库生产工作台设计

## 系统定位

题库生产工作台是独立于研码408学生端的新系统。它负责把教材、真题卷、模拟卷、原创草稿等原始资料采集为可追踪资产，后续再经过结构化、去重、审核和发布，最终供研码408学生端消费。

研码408学生端只读取已审核、已发布的题目；工作台负责题库资产生产过程。

```txt
本机 408资料
  -> 题库生产工作台
  -> MinIO 原始文件
  -> PostgreSQL 资料资产元数据
  -> 结构化题目、审核、去重
  -> 发布到研码408题库
```

## 当前 MVP 能力

- 本地 Docker Compose 增加 MinIO：
  - S3 API：`http://localhost:9000`
  - 控制台：`http://localhost:9001`
  - 默认 bucket：`yanma408-materials`
- 后端新增工作台接口：
  - `GET /api/workbench/materials`
  - `POST /api/workbench/materials/upload`
  - `POST /api/workbench/materials/scan-local`
  - `GET /api/workbench/materials/{id}/download-url`
  - `GET /api/workbench/materials/{id}/copyright-audits`
  - `POST /api/workbench/materials/{id}/copyright-audits`
  - `GET /api/workbench/materials/{id}/authorization-attachments`
  - `POST /api/workbench/materials/{id}/authorization-attachments`
  - `GET /api/workbench/content-quotas`
  - `GET /api/workbench/question-drafts`
  - `POST /api/workbench/question-drafts`
  - `POST /api/workbench/question-drafts/{id}/submit-review`
  - `PATCH /api/workbench/question-drafts/{id}/review`
  - `GET /api/workbench/question-drafts/{id}/duplicates`
  - `POST /api/workbench/question-drafts/{id}/publish`
  - `POST /api/workbench/materials/{id}/extract-candidates`
  - `GET /api/workbench/materials/{id}/extract-candidates`
  - `POST /api/workbench/extraction-candidates/{id}/run-ocr`
  - `PATCH /api/workbench/extraction-candidates/{id}/review`
  - `POST /api/workbench/extraction-candidates/batch-create-drafts`
- 新增资料资产表 `material_assets`，保存文件元数据和对象存储定位。
- 新增内容生产表：`question_content_quotas`、`question_drafts`、草稿选项/知识点/标签表、`question_draft_review_tasks`。
- 新增版权审计表 `material_copyright_audits`，记录资料来源、年份、授权边界、风险等级和是否允许抽题。
- 正式系统角色统一保存在 `app_user_roles`，仅保留三类：
  - `STUDENT`：学生端学习用户。
  - `TEACHER`：教师端学情管理用户。
  - `ADMIN`：系统管理员，拥有题库生产工作台、题库管理、教师绑定和账号维护等全部管理权限。
- 新增拆题和引用表：
  - `material_extraction_candidates`：保存 PDF 文本抽取、OCR 结果、人工校对字段、页码、置信度和候选题干。
  - `question_draft_references`：保存草稿到资料页码的引用关系，记录资料、候选、页码、摘录和备注。
- 新增相似度向量表 `question_text_vectors`，保存草稿/正式题的归一化文本和 token-vector，用于指纹查重之外的相似度预警。
- 新增授权附件表 `material_authorization_attachments`，用于把授权证明文件归档到对象存储并关联资料/审计记录。
- 新增独立简易前端：
  - `apps/workbench/index.html`
  - 可登录、显示角色、上传资料、扫描本机目录、筛选资料资产、登记版权审计、归档授权附件、生成 PDF/OCR 拆题候选、运行 OCR 或录入识别文本、人工校对候选、批量候选转草稿、查看配额、创建选择题/大题草稿、送审、审核、相似度查重、发布、生成 10 分钟下载链接。

## 题型策略

| 类型 | 系统值 | 选项要求 | 说明 |
| --- | --- | --- | --- |
| 单选题 | `SINGLE_CHOICE` | 至少 2 个选项 | MVP 主要客观题题型 |
| 多选题 | `MULTIPLE_CHOICE` | 至少 2 个选项 | 答案可用多个标签表达 |
| 综合题 | `COMPREHENSIVE` | 无需选项 | 大题，答案和评分要点写入解析 |
| 算法题 | `ALGORITHM` | 无需选项 | 题干、算法思路、伪代码、复杂度 |
| 计算题 | `CALCULATION` | 无需选项 | 过程性计算题 |

## 存储原则

数据库只保存稳定定位和元数据：

```txt
bucket
objectKey
originalFileName
contentType
sizeBytes
sha256
sourceType
sourceYear
subjectCode
status
```

数据库不保存 `http://localhost:9000/...` 这类环境相关 URL。下载和预览时由后端根据当前对象存储配置生成预签名 URL。

## 资料类型

| 类型 | 系统值 | 说明 |
| --- | --- | --- |
| 教材 | `TEXTBOOK` | 例如 2026 版四科教材 |
| 真题卷 | `PAST_EXAM` | 历年真题或授权真题资料 |
| 模拟卷 | `MOCK_EXAM` | 模拟卷、冲刺卷、预测卷 |
| 原创草稿 | `ORIGINAL_DRAFT` | 自编题、AI 辅助后待审核题 |
| 其他 | `OTHER` | 暂未分类资料 |

## 后续演进

下一阶段应在工作台继续增加：

- 云端 OCR 适配器：当前支持本机 `tesseract` OCR 和人工 OCR 文本覆盖，后续可接入云端 OCR 以提高中文扫描件识别率。
- 更强向量去重：当前为本地 token-vector 余弦相似度，后续可接入 embedding 向量库做跨题型语义查重。
- 版本管理：题目修改保留版本历史，便于回溯。
- 主观题评分：大题已支持入库，后续需要人工评分/AI 辅助评分和评分 rubric。

## 当前本机资料登记

已扫描 `/Users/permer/Documents/408资料`，登记 9 份 PDF：

- 2026 四科教材：4 份，`TEXTBOOK`
- 2026 模拟卷/解析：4 份，`MOCK_EXAM`
- 2023 真题解析：1 份，`PAST_EXAM`

真题解析资料当前审计决策为 `NEEDS_PERMISSION`，仅允许作为内部参考资料登记；未获得明确授权前，不抽取或发布真题原文。

## 本地运行

启动基础设施：

```bash
docker compose -f deploy/docker-compose.yml up -d postgres redis minio
```

启动后端：

```bash
cd apps/server
mvn spring-boot:run -Dspring-boot.run.arguments=--server.port=18082
```

启动工作台前端：

```bash
cd apps/workbench
python3 -m http.server 3001
```

访问：

- 工作台：`http://localhost:3001`
- MinIO 控制台：`http://localhost:9001`
- 后端 API：`http://localhost:18082/api`
