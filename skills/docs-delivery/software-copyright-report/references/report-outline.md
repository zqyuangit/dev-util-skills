# 软著说明书推荐结构

Use this outline when the user does not provide a required template. Adjust section names to match the software type, but keep the document objective and submission-oriented.

## 1. 软件概述

Include:

- 软件名称
- 软件简称, if available
- 软件版本, if available
- 软件类型: desktop, Web, mobile, backend service, embedded, AI-assisted system, etc.
- 面向用户
- 核心用途

Avoid broad marketing claims. Describe what the software does and what problem it solves.

## 2. 开发背景与目标

Explain:

- The usage scenario that motivates the software
- User pain points or operational needs
- The concrete design goals of the software

For soft-copyright manuals, keep this section concise. Do not use competition-defense language.

## 3. 运行环境

Use a table when possible:

| 类别 | 说明 |
| --- | --- |
| 操作系统 | 待补充 / Windows / Linux / macOS / Android / iOS |
| 运行方式 | 桌面程序 / 浏览器访问 / 服务部署 / 移动端安装 |
| 前端环境 | 待补充 |
| 后端环境 | 待补充 |
| 数据库/存储 | 待补充 |
| 第三方依赖 | 待补充 |

Only include facts supported by materials. Mark unknown items as `待补充`.

## 4. 系统功能结构

Describe the module organization. Common formats:

- Module table
- Hierarchical bullet list
- Architecture or flow summary

Recommended module table:

| 模块名称 | 功能说明 | 主要输入 | 主要输出 |
| --- | --- | --- | --- |
| 待补充 | 待补充 | 待补充 | 待补充 |

## 5. 功能模块说明

For each major module, write:

- 功能用途
- 操作入口
- 操作步骤
- 处理结果
- Related data/configuration if relevant

Keep function descriptions concrete. Example pattern:

```markdown
### 5.1 用户管理模块

用户管理模块用于维护系统用户信息和访问权限。用户进入管理页面后，可以新增、编辑、查询或停用用户记录。系统保存用户基础信息，并根据角色配置控制可访问功能范围。
```

## 6. 操作流程说明

Describe end-to-end user operation flows. Use numbered steps.

Typical flows:

- 初次启动/登录
- 创建或导入数据
- 使用核心功能
- 查看结果
- 导出、保存或提交
- 退出或清理

If screenshots are available, add captions:

```markdown
图 1 系统主界面
图 2 功能配置页面
图 3 结果展示页面
```

## 7. 数据与配置说明

Include:

- Key data files or database tables
- User configuration
- Model/API configuration
- Storage paths
- Import/export formats

Do not expose secrets, tokens, passwords, or real private credentials.

## 8. 异常处理与注意事项

Describe practical conditions:

- Network failure
- Missing configuration
- Invalid input
- Permission limitations
- Unsupported file formats
- Model/API unavailable, if applicable

Use neutral wording. Avoid overpromising availability or security if not verified.

## 9. 技术特点

Describe technical characteristics supported by evidence:

- Architecture pattern
- Frontend/backend separation
- Local packaging
- Data processing method
- AI-assisted generation
- Search/retrieval mechanism
- Extensibility

Do not include unsupported novelty claims.

## 10. 总结

Summarize:

- What the software provides
- What main workflows are supported
- What users can accomplish with it

If necessary, include a short `待补充信息` section after the summary.

## 待补充信息

Use this section whenever required facts are missing:

- 软件著作权人
- 作者/开发者
- 版本号
- 开发完成日期
- 首次发表日期
- 运行环境细节
- 数据库或部署信息
- Required screenshots
