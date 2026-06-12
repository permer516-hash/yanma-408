# 真题版权审计流程

## 目标

真题资料可以作为题库建设的重要来源，但不能在来源、年份、授权边界不清楚时直接抽题或发布。系统只允许先登记资料元数据和审计结论；只有审计结论为 `APPROVED_FOR_EXTRACTION` 的资料，后续才进入拆题和发布流程。

## 审计字段

| 字段 | 说明 |
| --- | --- |
| `sourceName` | 资料来源名称，例如某年真题解析、授权资料包名称 |
| `sourceYear` | 真题年份，真题资料必须明确 |
| `authorizationScope` | 授权边界：自有、已授权、公有领域、仅内部参考、未知 |
| `riskLevel` | 版权风险：低、中、高 |
| `decision` | 审计决策：可抽题、需补授权、拒绝使用 |
| `notes` | 来源说明、授权依据、禁止事项和后续处理建议 |
| `auditedBy` | 审计人或流程标识 |

## 授权附件归档

工作台已提供授权附件归档能力：

- `POST /api/workbench/materials/{id}/authorization-attachments` 上传授权证明文件。
- `GET /api/workbench/materials/{id}/authorization-attachments` 查看资料下已归档附件。
- 附件可以关联 `material_copyright_audits.id`，用于保留授权邮件、合同、采购证明、许可截图等证据。
- 上传附件需要 `REVIEWER` 或 `ADMIN` 角色；查看附件需要 `AUTHOR`、`REVIEWER` 或 `ADMIN` 角色。
- 数据库保存对象存储位置、原始文件名、内容类型、大小、SHA-256、上传人和备注，不保存环境相关下载 URL。

## 决策规则

- `UNKNOWN` 授权边界不能标记为可抽题。
- `HIGH` 风险资料不能标记为可抽题。
- 真题资料缺少年份时不能通过审计。
- `NEEDS_PERMISSION` 表示只完成资料登记，不能抽取或发布原题。
- `REJECTED` 表示该资料不进入题库生产流程。

## 当前实际记录

`/Users/permer/Documents/408资料/【王道】2023年计算机专业基础综合考试历年真题解析.pdf` 已登记为真题资料，并记录审计结论：

- 授权边界：`INTERNAL_REFERENCE`
- 风险等级：`MEDIUM`
- 决策：`NEEDS_PERMISSION`
- 处理原则：未获得明确授权前，不抽取或发布真题原文。
