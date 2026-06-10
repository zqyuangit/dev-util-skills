---
name: redesign-risk-check-zh
description: Use when a Chinese-language request asks to avoid later large-scale redesign, check rework risk before implementation, freeze project structure before coding, or review whether roles, workflows, and boundaries are stable enough to start building.
---

# Redesign Risk Check ZH

## Overview

This is a Chinese-friendly companion to `architecture-freeze-check`.

Use it when the user is asking in Chinese about:

- 如何避免后期大改
- 如何减少返工
- 开工前要不要先把架构或页面结构定住
- 现在是否需要做重构风险检查
- 为什么项目总是做到一半要 redesign

This skill does not replace:

- `brainstorming` for early fuzzy idea exploration
- `writing-plans` for implementation planning
- `test-driven-development` for coding work

It adds a structural checkpoint between design clarification and implementation.

## When to Use

Use this skill when the user is effectively asking any of these questions in Chinese:

- “这个项目后面会不会大改？”
- “现在开工会不会返工很多？”
- “前后台这样分对吗？”
- “首页、工作台、管理端是不是混了？”
- “如何在开发前把结构冻结住？”
- “怎样避免后面推倒重来？”

Do not use this skill when:

- the task is already narrowed to a concrete implementation step
- the request is just a bugfix or small UI tweak
- the idea is still too vague and needs `brainstorming` first

## Core Output

The output of this skill should answer five things clearly:

1. 谁在用这个系统
2. 默认主流程是什么
3. 哪些能力属于用户端
4. 哪些能力属于管理端或治理端
5. 哪些地方如果现在不定，后面最容易引发大规模 redesign

## Workflow

1. 用一屏表格画出项目结构
2. 检查六类重构风险
3. 冻结最少但关键的结构决策
4. 明确哪些问题不解决就不该开工
5. 再转入 `writing-plans`

## Step 1: 一屏结构图

先整理一个简表，只保留这些字段：

- 角色
- 核心页面或入口
- 主流程
- 前端边界
- 后端边界
- 数据归属
- 内容发布或治理链路
- 评分点或验收证据落点

如果这些内容无法被压缩到一页，通常说明项目还不够稳定。

## Step 2: 六类重构风险检查

### 1. 角色混乱

检查：

- 学生、管理员、运营、教师等角色是否边界清楚
- 是否把“给用户用的内容”和“给管理者操作的内容”混到一个界面
- 是否存在一个页面同时承担两个相冲突的目标

### 2. 主流程混乱

检查：

- 新用户进入后第一步是否明确
- 是否存在多个并列的“主入口”
- 是否把次要功能堆到了主流程页面

### 3. 页面分层混乱

检查：

- 首页是不是引导页，而不是功能堆叠页
- 工作台是不是围绕一个主任务，而不是所有模块平铺
- 管理端是否保持治理属性，而不是和用户端体验混杂

### 4. 前后端边界混乱

检查：

- 哪个服务拥有画像、路径、资源、练习、反馈的最终状态
- 是否存在多个入口调用同一能力但规则不一致
- legacy 和新栈是否同时在线却没有明确迁移边界

### 5. 治理链路缺失

检查：

- 知识库、题库、公告、反馈由谁创建和发布
- 用户端是否只消费已发布内容
- 用户反馈是否能回流到正确的管理端

### 6. 验收与答辩映射不清

检查：

- 每个赛题要求是否有对应页面和证据
- 页面是否更像产品，而不是开发演示台
- 是否能走通一条稳定的答辩演示路径

## Step 3: 冻结这些关键决策

在正式编码前，至少要冻结：

- 角色边界
- 默认入口
- 默认主流程
- 用户端与管理端分工
- 关键状态归属
- 内容治理链路
- 评分点到页面的映射关系

这些没有定下来，就不算真正适合进入大规模实现。

## Step 4: 形成冻结结论

输出一份短结论，至少包含：

- 当前结构是否适合开工
- 哪些地方已经稳定
- 哪些地方如果现在不改，后面会造成大改
- 建议先冻结的 3 到 7 个关键决策

## Common Mistakes

- 把视觉美化误当成 redesign 的核心原因
- 功能已经写了很多，才回头想角色边界
- 页面信息架构没有冻结，就开始大面积写前端
- 管理功能和用户主流程混在一起
- 只写功能，不写“这个功能在哪个页面作为证据出现”
- 觉得“先做，后面再整理”不会出问题

## Quick Reference

如果用户在中文里表达的是这些意思，就适合触发本 skill：

- “先帮我看下后面会不会大改”
- “先别开发，先检查架构是否合理”
- “我怕做到后面又要重构”
- “按赛题要求，先帮我定住前后台结构”

结束后：

- 需求还模糊：转 `brainstorming`
- 结构已稳定：转 `writing-plans`
- 已经开始编码但结构明显错了：先修边界，再继续实现
