---
name: software-copyright-report
description: Generate formal Chinese software copyright manuals and software operation instructions from PPT/PPTX decks, source code, screenshots, README files, requirements documents, or existing notes. Use for 软件著作权说明书, 软件操作说明书, user manuals, and report-style software documentation. Default workflow is Markdown first, then DOCX export when requested.
---

# Software Copyright Report

## Purpose

Use this skill to turn mixed project materials into a formal Chinese software copyright manual or software operation instruction document. The output should read like a submission-ready software document, not a defense script, sales deck, or competition presentation.

Default deliverables:

- `软件名称-软著说明书.md`
- `软件名称-软著说明书.docx` when the user asks for Word/DOCX or a deliverable file

## Source Priority

Inspect available materials before drafting. Prefer evidence in this order:

1. User-provided PPT/PPTX, screenshots, product demos, or UI prototypes
2. README, requirements docs, existing manuals, release notes, or design docs
3. Source tree structure, package manifests, routes, API files, UI entry points, and config files
4. Database schemas, sample data, tests, and deployment files
5. User notes in the conversation

Never invent sensitive or registration-specific fields. If a field is missing, list it under `待补充信息`. Examples: copyright owner, author, version number, completion date, first publication date, registration category, contact information, exact deployment address.

## Workflow

1. **Collect facts**
   - Identify software name, software type, platform, intended users, main modules, operation flow, runtime environment, and technical stack.
   - If a PPT is provided, extract product structure and screenshots, then rewrite it as report prose.
   - If source code is provided, inspect top-level directories and likely entry points instead of relying only on marketing text.

2. **Choose report structure**
   - Read `references/report-outline.md` when drafting the section hierarchy.
   - Use the default soft-copyright structure unless the user provides a required template.
   - Keep the report general enough for desktop, Web, mobile, backend service, or AI-assisted software.

3. **Apply formal style**
   - Read `references/style-guide.md` before final writing.
   - Use objective third-person Chinese prose.
   - Remove presentation language such as `各位评委`, `本次汇报`, `我们小组`, `答辩`, `PPT`, `完成度检查`, and slide/page references.
   - Replace completion percentages with factual status when writing a soft-copyright manual.

4. **Draft Markdown first**
   - Produce a complete Markdown document with a title, table-friendly sections, and `待补充信息` if needed.
   - Use tables for runtime environment, module list, and data/configuration items when they improve readability.
   - Add screenshot placeholders or captions if screenshots are available, for example `图 1 系统登录界面`.

5. **Export DOCX when requested**
   - If the user asks for DOCX, use the available document-generation capability or the `documents` skill.
   - Keep headings, numbered sections, tables, and captions editable.
   - Verify the DOCX opens, Chinese renders normally, and section hierarchy is intact.

## Report Transformation Rules

When converting from PPT or defense materials:

- Preserve: software functions, module relationships, page flows, runtime evidence, architecture, input/output behavior, and known limitations.
- Remove: judge-facing claims, defense tips, slide narration, competition ranking language, repeated value statements, and unsupported completion claims.
- Rephrase:
  - `评委可以看到...` -> `系统界面展示...`
  - `本次展示...` -> `本文档说明...`
  - `后续需补齐...` -> `待补充信息：...` or `后续维护中可继续完善...`
  - `完成度 85%` -> `已具备基础运行能力` or `已实现主要流程`

## Quality Gate

Before delivering:

- The report has a clear software name or explicitly marks it as `待补充`.
- Every major function is described with purpose, operation entry, main steps, and result.
- Runtime environment and technical stack are present or marked as missing.
- No unsupported legal/registration facts are fabricated.
- No defense/PPT/评委 language remains.
- Markdown is complete; DOCX is generated only if requested and verified.

## References

- For the default section structure, read `references/report-outline.md`.
- For formal wording and prohibited phrases, read `references/style-guide.md`.
