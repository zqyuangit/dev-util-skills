# 正式软著说明书写作规范

Use this guide when writing or revising software copyright manuals and operation instructions.

## Voice

- Use objective third-person Chinese prose.
- Prefer `本软件`, `系统`, `用户`, `管理员`, `操作人员`.
- Avoid first-person wording such as `我们`, `我方`, `本小组`, unless the user explicitly requests a team report.
- Write for documentation reviewers and future users, not for a live defense audience.

## Tone

Use:

- `本软件用于...`
- `系统提供...`
- `用户可通过...完成...`
- `该模块支持...`
- `系统处理完成后...`
- `如配置缺失，系统应提示用户补充相关信息。`

Avoid:

- `各位评委老师`
- `本次汇报`
- `请看这一页`
- `答辩主线`
- `评委可以看到`
- `比赛/赛题要求`
- `PPT 中展示`
- `完成度 85%`
- `我们小组已经完成`
- `为了拿到更高分`

## Converting PPT Language

| PPT/答辩表达 | 报告表达 |
| --- | --- |
| 本次展示围绕四个方面展开 | 本文档从功能、运行环境和操作流程等方面说明软件情况 |
| 评委可以看到 | 系统界面展示 |
| 功能已经落地到可运行产品 | 软件已具备相应功能流程 |
| 后续需补齐 | 待补充信息 / 后续维护中可继续完善 |
| 完成度 78% | 已实现基础能力 / 已具备主要流程 |
| 真实程序界面证明 | 相关界面如图所示 |

## Claims

- Only state a capability as implemented when supported by materials.
- Use `支持`, `提供`, `可完成`, `可查看` for supported functions.
- Use `待补充`, `后续可完善`, or `当前材料未体现` for missing or uncertain functions.
- Do not invent legal facts, release history, dates, owners, or registration data.

## Structure

- Use numbered headings for formal reports.
- Keep paragraphs concise: usually 2-4 sentences.
- Use tables for environment, modules, and configuration.
- Use numbered lists for operation steps.
- Add figure captions when screenshots are included.

## Screenshot Captions

Use neutral captions:

- `图 1 系统主界面`
- `图 2 用户登录界面`
- `图 3 数据管理界面`
- `图 4 结果展示界面`

Avoid captions such as:

- `答辩展示页面`
- `评委关注截图`
- `PPT 原型图`
- `比赛功能证明`

## Missing Information Format

When information is not found, add a concise section:

```markdown
## 待补充信息

| 信息项 | 当前状态 |
| --- | --- |
| 软件著作权人 | 待补充 |
| 软件版本号 | 待补充 |
| 开发完成日期 | 待补充 |
```

Do not hide missing information inside confident prose.
