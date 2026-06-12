# 题目采编与审核流程

## 目标

建立一条可重复执行的题库生产流程，让模拟题和原创题从资料、草稿、审核到发布都有明确责任和质量标准。真题只在来源、年份、授权边界确认后进入相同流程。

## 角色分工

| 角色 | 责任 |
| --- | --- |
| 采编者 | 编写题干、选项、答案、解析、知识点、来源和难度 |
| 初审者 | 校验知识点、答案、解析、难度和题面表达 |
| 终审者 | 校验版权风险、可发布状态和题库一致性 |
| 发布者 | 将审核通过题目发布到研码408题库 |

MVP 阶段可以由同一个人兼任多个角色，但操作记录和审核标准要保留。系统侧已用 `app_user_roles` 落地工作台 RBAC：`AUTHOR` 负责采编和送审，`REVIEWER` 负责审核与版权材料归档，`ADMIN` 负责发布。

## 标准流程

```txt
资料资产登记
  -> PDF/OCR 拆题候选
  -> OCR 执行或人工录入识别文本
  -> 候选题人工校对
  -> 题目草稿采编
  -> 批量候选转草稿
  -> 页码级引用绑定
  -> 结构校验
  -> 指纹/向量相似度查重
  -> 初审
  -> 终审
  -> 发布
  -> 上线抽检
```

## 采编要求

每道题必须填写：

- `subjectCode`：408 科目
- `chapterCode`：章节
- `knowledgePointCodes`：至少一个知识点
- `type`：`SINGLE_CHOICE/MULTIPLE_CHOICE/COMPREHENSIVE/ALGORITHM/CALCULATION`
- `difficulty`：`BASIC/MEDIUM/HARD`，展示为简单、中等、困难
- `source`：`PAST_EXAM/MOCK/ORIGINAL`
- `sourceYear`：真题必填，模拟题可填，原创题通常为空
- `pageReferences`：从资料拆题或人工采编时建议填写，至少记录资料 ID、页码、摘录和备注
- `stem`：题干，不能依赖外部上下文
- `options`：选择题至少 2 个选项，单选题建议 4 个选项；综合题、算法题、计算题可以为空
- `answer`：选择题填写答案标签；大题可填写“参考答案见解析”并把评分要点写入解析
- `explanation`：解析必须说明关键推理步骤
- `tags`：建议包含题型、知识点或训练意图

## 审核标准

通过审核的题目必须满足：

- 题干无歧义，不出现“如上图”但缺图、缺条件、缺单位等问题。
- 单选题只有一个明确正确答案。
- 多选题答案标签必须能与选项对应；大题必须有明确评分要点、关键步骤或复杂度说明。
- 解析能够独立解释为什么正确，以及常见错误选项的陷阱。
- 难度分级与实际解题步骤匹配。
- 知识点归属准确，不把跨科题误放到单一无关知识点。
- 模拟题和原创题不得复制外部受版权保护题干。
- 真题必须保留年份、来源说明和授权边界。
- 来自教材、模拟卷或授权资料的题目，应保留页码级引用，方便复核题干改写程度和解析依据。
- 由图片型 PDF 页产生的候选，如果状态为 `OCR_REQUIRED`，必须先完成 OCR 和人工校对后才能进入发布审核。
- 发布前必须执行查重；`FINGERPRINT` 命中或 token-vector 高相似命中需要人工确认是否改写不足、重复入库或知识点重复。

## 发布规则

- 只有 `status = PUBLISHED` 且 `reviewStatus = APPROVED` 的题目会出现在学生端题库。
- 初稿不确定时使用 `DRAFT` 或 `reviewStatus = PENDING`。
- 被拒绝题目使用 `reviewStatus = REJECTED`，保留 `reviewNote` 说明原因。
- 批量导入只能降低录入成本，不能跳过审核。
- 只有 `ADMIN` 可以执行发布接口；审核通过但未发布的草稿不会进入学生端题库。

## 文件模板

- CSV 导入模板：`docs/templates/question-authoring-template.csv`
- JSON 导入模板：`docs/templates/question-authoring-template.json`
- 审核清单：`docs/templates/question-review-checklist.md`
