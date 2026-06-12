# 系统设计方案

## 产品定位

研码408 是一个面向计算机考研 408 学生的专业课练习平台。核心目标不是单纯模拟 LeetCode，而是围绕 408 考试特点提供题库练习、错题复盘、真题训练和学习分析。

408 涵盖四门专业课：

- 数据结构
- 计算机组成原理
- 操作系统
- 计算机网络

平台第一阶段重点服务以下学习流程：

```txt
看知识点 -> 刷章节题 -> 提交答案 -> 查看解析 -> 自动归档错题 -> 周期复习 -> 套卷模拟 -> 分析薄弱点
```

## 总体架构

项目采用前后端分离：

```txt
Next.js Web
   |
   | HTTP API
   v
Spring Boot Backend
   |
   +-- PostgreSQL
   +-- Redis
   +-- Object Storage, later
```

后端当前采用模块化单体。后续如果业务复杂度上升，可以按领域拆分为 Spring Cloud 服务。

## 技术栈

### 前端

- Next.js 16
- React 19
- TypeScript
- Tailwind CSS
- 后续建议引入：
  - shadcn/ui
  - lucide-react
  - TanStack Table
  - React Hook Form
  - Zod
  - Recharts

### 后端

- Java 17
- Spring Boot 3.4
- Spring Web
- Spring Validation
- Spring Data JPA
- Spring Actuator
- Spring Security
- 后续建议引入：
  - Flyway
  - Redis
  - MapStruct
  - OpenAPI/Swagger

### 数据与基础设施

- PostgreSQL：主数据库
- Redis：缓存、排行榜、异步任务辅助
- Docker Compose：本地开发基础设施
- H2：后端测试环境内存数据库

## 后端 DDD 分层

后端采用轻量 DDD，避免早期过度设计，但保留清晰边界。

每个核心领域建议分为四层：

```txt
interfaces       REST Controller、Request、Response
application      用例编排、事务控制
domain           实体、值对象、领域服务、仓储接口
infrastructure   数据库、缓存、第三方服务实现
```

## 领域模块

```txt
shared      通用能力、异常、响应包装、基础设施
user        用户与账号
question    题库领域
practice    刷题与提交记录
mistake     错题本
exam        真题与套卷
study       学习计划与学习分析
teacher     教师端班级、学情、任务下发和报表导出
admin       管理后台
workbench   题库生产工作台，负责资料采集、对象存储、结构化、审核和发布
```

## 核心领域说明

### question 题库领域

负责题目、选项、解析、知识点、章节和题目来源。

核心对象：

- Question
- QuestionOption
- QuestionExplanation
- Subject
- Chapter
- KnowledgePoint
- QuestionTag

来源策略：

- `PAST_EXAM`：真题，必须记录年份 `sourceYear`，发布前需要确认来源和授权边界。
- `MOCK`：模拟题，服务模拟训练和套卷，需人工审校。
- `ORIGINAL`：原创题，包含教研自编或 AI 辅助后人工审核的题目。

难度策略：

- `BASIC`：简单
- `MEDIUM`：中等
- `HARD`：困难

题型需要支持：

- 单选题
- 多选题
- 综合应用题
- 算法设计题
- 计算题

### workbench 题库生产工作台

负责教材、真题卷、模拟卷、原创草稿等原始资料的采集、对象存储和入库前管理。工作台与研码408学生端分离，学生端只消费已发布题目。

核心对象：

- MaterialAsset
- ObjectStorageObject
- QuestionDraft
- ReviewTask
- PublishJob
- ContentQuota
- CopyrightAudit
- MaterialExtractionCandidate
- QuestionDraftReference
- AuthorizationAttachment
- QuestionTextVector

当前 MVP 已实现资料资产上传、MinIO 存储、资料资产列表、预签名下载链接、本机资料扫描登记、题库内容配额、题目草稿、审核任务、指纹和 token-vector 相似度查重、发布接口、版权审计记录、PDF 文本拆题候选、OCR 执行/人工 OCR 文本覆盖、候选人工校对、批量候选转草稿、页码级引用、授权附件归档、正式 RBAC、选择题/大题区分、主观题导入、题干图片/结构图表展示、首批题目采编模板和审核清单。详细设计见 `docs/architecture/question-bank-workbench.md`，采编流程见 `docs/product/question-authoring-review-flow.md`，真题版权审计见 `docs/product/past-exam-copyright-audit.md`。

当前题库扩容策略：MVP 练习量优先。`V18__rapid_question_bank_expansion.sql` 已直接发布一批真题、模拟题和原创题，`V19__choice_question_expansion.sql` 继续专项扩充选择题，`V20__document_based_single_choice_expansion.sql` 开始基于 `/Users/permer/Documents/408资料` 中的王道八套卷文档改写单选题，`V21__ds_2027_single_choice_import.sql` 至 `V28__ds_2027_single_choice_eighth_batch.sql` 已基于 2027 数据结构教材累计导入 288 道单选题，`V33__ds_2027_section_selected_single_choice_ninth_batch.sql` 已切换为贴近数据结构各节“本节试题精选/单项选择题”题区的页码级改写，使 2027 数据结构累计达到 328 道；用户确认获得授权后，`V34__ds_2027_authorized_original_linear_list_sequence.sql` 已开始导入 2027 数据结构原题原解析，首批覆盖 2.2 顺序表单选题 01-12，`V36__ds_2027_authorized_original_chapter1.sql` 已按章节顺序补入第 1 章原题原解析 23 道；`V35__normalize_legacy_question_difficulty.sql` 已将非“本节试题精选/授权原题”的历史题统一降级为简单题；`V38__normalize_question_text_escapes.sql` 已清理题干、解析和选项中的字面量换行/转义引号，前端统一按真实换行渲染代码片段；`V39__ds_2027_authorized_original_chapter2_linear_and_linked.sql` 和 `V40__ds_2027_authorized_original_chapter2_linked_second.sql` 已继续补入第 2 章 2.1 与 2.3 可直接作答的授权单选原题 34 道；`V29__co_2027_single_choice_first_batch.sql` 至 `V32__co_2027_single_choice_fourth_batch.sql` 已基于 2027 计算机组成原理教材累计导入 160 道单选题；后续补题统一按“授权原题 + 原答案解析”路线执行，审核流和版权审计仍可作为生产治理能力保留。

### practice 练习领域

负责用户刷题、提交答案、记录用时和判定结果。

核心对象：

- PracticeSession
- PracticeAttempt
- AnswerJudgement

### mistake 错题领域

负责错题自动归档、错因标记、复习队列和掌握状态。

核心对象：

- Mistake
- MistakeReason
- ReviewSchedule

### exam 套卷领域

负责真题卷、模拟卷、计时考试和考试报告。

核心对象：

- ExamPaper
- ExamPaperQuestion
- ExamAttempt
- ExamReport

### study 学习分析领域

负责学习计划、每日记录、知识点掌握度和薄弱项分析。

核心对象：

- StudyPlan
- DailyStudyRecord
- KnowledgeMastery
- WeakPoint

### teacher 教师端学情领域

负责老师按班级查看学生学习情况、导出学情报表和给学生下发学习任务。MVP 阶段由管理员统一维护教师班级与学生归属，一个学生可加入多位老师的班级；老师只能访问自己班级内的学生，聚合展示学生做题数、正确率、错题数、待掌握错题、最近活跃、四科掌握度和优先关注错题；下发任务会写入学生各自的学习计划。

核心对象：

- TeacherClass
- TeacherClassStudent
- TeacherTaskAssignment
- StudentLearningSummary
- StudentLearningDetail

权限策略：

- `STUDENT`：学生端个人学习数据，只能访问自己的练习、错题、计划和分析。
- `TEACHER`：老师端学情管理，只能查看自己班级内的学生、导出学情和下发任务，不能查询全量学生或修改师生绑定。
- `ADMIN`：唯一系统管理员，可查看全部老师和班级，创建指定老师的班级，并维护学生绑定/解绑关系。

## MVP 页面

第一阶段前端页面：

```txt
/dashboard           学习仪表盘
/question-bank       题库
/practice/[id]       做题页
/mistakes            错题本
/exams               真题/套卷
/exams/[id]          套卷做题页
/exams/[id]/attempt  套卷整卷计时作答
/analysis            学习分析
/teacher/students    教师端学生学情
/admin               管理后台
/login               登录
```

## API 初步规划

```txt
GET    /api/health

POST   /api/auth/register
POST   /api/auth/login
GET    /api/auth/me
POST   /api/auth/logout
POST   /api/auth/password-reset/request
POST   /api/auth/password-reset/confirm
GET    /api/auth/tokens
PATCH  /api/auth/tokens/{id}/revoke
GET    /api/auth/audit-logs

GET    /api/questions
GET    /api/questions/search        支持 subject、keyword、difficulty、source、knowledgePoint、page、size
GET    /api/questions/{id}
POST   /api/questions
PUT    /api/questions/{id}
GET    /api/admin/questions
GET    /api/admin/questions/{id}
PUT    /api/admin/questions/{id}
PATCH  /api/admin/questions/{id}/status
PATCH  /api/admin/questions/{id}/review
PATCH  /api/admin/questions/bulk
DELETE /api/admin/questions/{id}
POST   /api/admin/questions/import
POST   /api/admin/questions/import/preview
POST   /api/admin/questions/import/file
POST   /api/admin/questions/import/preview-file

POST   /api/practice/attempts
GET    /api/practice/attempts

GET    /api/mistakes
GET    /api/mistakes/review-queue
PUT    /api/mistakes/{id}

GET    /api/exams
GET    /api/exams/{id}
POST   /api/exams/{id}/attempts
POST   /api/exams/attempts/{id}/submit
GET    /api/exams/attempts/{id}/report
GET    /api/exams/attempts
GET    /api/exams/reports/overview
GET    /api/exams/{id}/attempts
GET    /api/exams/{id}/attempts/compare
POST   /api/exams/attempts/{id}/mistakes/backfill

GET    /api/study/dashboard
GET    /api/study/tasks
GET    /api/study/tasks/range
POST   /api/study/tasks
PUT    /api/study/tasks/{id}
PATCH  /api/study/tasks/{id}/status
PATCH  /api/study/tasks/{id}/occurrences/{date}/status
DELETE /api/study/tasks/{id}
GET    /api/study/reminders
GET    /api/study/reminders/stream
POST   /api/study/notifications/dispatch
GET    /api/study/notifications
PATCH  /api/study/notifications/{id}/read
GET    /api/study/notifications/preferences
PUT    /api/study/notifications/preferences/{channel}
GET    /api/study/analysis

GET    /api/teacher/students
GET    /api/teacher/students/candidates
GET    /api/teacher/teachers
GET    /api/teacher/students/export.csv
GET    /api/teacher/students/{studentId}
GET    /api/teacher/classes
POST   /api/teacher/classes
PATCH  /api/teacher/classes/{classId}
DELETE /api/teacher/classes/{classId}
POST   /api/teacher/classes/{classId}/students
DELETE /api/teacher/classes/{classId}/students/{studentId}
GET    /api/teacher/classes/{classId}/assignments
POST   /api/teacher/classes/{classId}/assignments
```

当前已实现：

```txt
GET    /api/health
POST   /api/auth/register
POST   /api/auth/login
GET    /api/auth/me
POST   /api/auth/logout
POST   /api/auth/password-reset/request
POST   /api/auth/password-reset/confirm
GET    /api/auth/tokens
PATCH  /api/auth/tokens/{id}/revoke
GET    /api/auth/audit-logs
GET    /api/questions
GET    /api/questions/search        支持来源筛选 source
GET    /api/questions/{id}
POST   /api/questions
GET    /api/admin/questions
GET    /api/admin/questions/{id}
PUT    /api/admin/questions/{id}
PATCH  /api/admin/questions/{id}/status
PATCH  /api/admin/questions/{id}/review
PATCH  /api/admin/questions/bulk
DELETE /api/admin/questions/{id}
POST   /api/admin/questions/import
POST   /api/admin/questions/import/preview
POST   /api/admin/questions/import/file
POST   /api/admin/questions/import/preview-file
POST   /api/practice/attempts
GET    /api/mistakes
GET    /api/mistakes/review-queue
PATCH  /api/mistakes/{id}/mastery
GET    /api/study/dashboard
GET    /api/study/tasks
GET    /api/study/tasks/range
POST   /api/study/tasks
PUT    /api/study/tasks/{id}
PATCH  /api/study/tasks/{id}/status
DELETE /api/study/tasks/{id}
GET    /api/exams
GET    /api/exams/{id}
POST   /api/exams/{id}/attempts
POST   /api/exams/attempts/{id}/submit
GET    /api/exams/attempts/{id}/report
GET    /api/exams/attempts
GET    /api/exams/reports/overview
GET    /api/exams/{id}/attempts
GET    /api/exams/{id}/attempts/compare
POST   /api/exams/attempts/{id}/mistakes/backfill
PATCH  /api/study/tasks/{id}/occurrences/{date}/status
GET    /api/study/reminders
GET    /api/study/reminders/stream
POST   /api/study/notifications/dispatch
GET    /api/study/notifications
PATCH  /api/study/notifications/{id}/read
GET    /api/study/notifications/preferences
PUT    /api/study/notifications/preferences/{channel}
GET    /api/teacher/students
GET    /api/teacher/students/candidates
GET    /api/teacher/students/export.csv
GET    /api/teacher/students/{studentId}
GET    /api/teacher/classes
POST   /api/teacher/classes
PATCH  /api/teacher/classes/{classId}
DELETE /api/teacher/classes/{classId}
POST   /api/teacher/classes/{classId}/students
DELETE /api/teacher/classes/{classId}/students/{studentId}
GET    /api/teacher/classes/{classId}/assignments
POST   /api/teacher/classes/{classId}/assignments
```

## 数据库核心表

第一阶段建议：

```txt
app_users
app_user_roles
auth_tokens
auth_audit_logs
subjects
chapters
knowledge_points
questions
question_options
question_explanations
question_knowledge_points
question_tags
question_tag_relations
practice_attempts
mistakes
study_plan_tasks
study_task_occurrences
study_notifications
study_notification_preferences
teacher_classes
teacher_class_students
teacher_task_assignments
exam_papers
exam_paper_questions
exam_attempts
exam_attempt_answers
daily_study_records
```

## 架构演进

第一阶段：

```txt
Next.js + Spring Boot 模块化单体 + PostgreSQL + Redis
```

第二阶段：

```txt
独立搜索服务
独立判题服务
AI 批改服务
消息队列
对象存储
```

第三阶段：

```txt
Spring Cloud Gateway
用户服务
题库服务
练习服务
考试服务
学习分析服务
判题服务
AI 服务
```

## 设计原则

- 第一阶段优先把学习闭环做通。
- 不在 MVP 阶段引入复杂微服务。
- 后端领域模型承载核心规则，Controller 不写业务。
- 前端按业务 feature 组织，不做单纯页面堆砌。
- 所有任务需要记录开始、完成、验证结果和遗留问题。
