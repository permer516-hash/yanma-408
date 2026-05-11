# 架构概览

研码408 采用 `Next.js + Spring Boot 模块化单体`。

## 后端风格

后端采用轻量 DDD：

- `interfaces`：REST 接口、请求和响应 DTO
- `application`：用例编排、事务边界
- `domain`：实体、值对象、领域服务、仓储接口
- `infrastructure`：数据库、缓存和外部服务实现

## 领域模块

- `user`：用户与账号
- `question`：题库
- `practice`：练习记录
- `mistake`：错题本
- `exam`：真题与套卷
- `study`：学习计划和学习分析
- `admin`：管理后台
- `shared`：通用基础设施
