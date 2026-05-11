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
admin       管理后台
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

题型需要支持：

- 单选题
- 多选题
- 综合应用题
- 算法设计题
- 计算题

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
GET    /api/questions/search
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
GET    /api/questions/search
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
```

## 数据库核心表

第一阶段建议：

```txt
app_users
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
