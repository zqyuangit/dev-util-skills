# Real Prototype Quality Gate

Use this checklist before delivering a software demo PPT that claims to use real product pages.

## Prototype Authenticity

Pass conditions:

- Screenshots come from one of:
  - a locally run application
  - a deployed application opened in a browser
  - an Electron/mobile/desktop packaged program
  - screenshots explicitly provided and accepted by the user as real
  - source-code-rendered UI using the project bundle and realistic demo data
- Captions or surrounding text do not imply implementation beyond what the UI/source supports.
- UI labels, navigation, colors, layout, and controls match the source program.

Fail conditions:

- Hand-drawn UI is presented as the real program.
- Generic dashboard mockups replace product-specific pages.
- Screenshots are invented from requirements text alone.
- Program pages are visually inconsistent with the source application.
- A screenshot is too blurry to support inspection.

If authenticity cannot be verified, label the page or asset `界面待验证`.

## Screenshot Quality

Minimum expectations:

- Capture at native app size or browser viewport suitable for 16:9 slides.
- Prefer device scale factor 2 or equivalent high-DPI capture.
- Avoid repeated lossy compression.
- Crop only when it improves readability and does not hide important context.
- Keep screenshot aspect ratio intact.
- Do not stretch screenshots horizontally or vertically.

## Editable PPT Requirements

The final PPTX must not be a stack of full-slide images.

Required editable elements:

- Slide titles
- Body text
- Requirement tables
- Progress bars
- Flow diagrams
- Status labels
- Captions
- Architecture diagrams

Allowed bitmap elements:

- Real UI screenshots
- Product images
- Logos
- Icons when not available as editable symbols
- Background photos only when genuinely needed

## Verification Checks

Before final response, verify:

- Slide count matches the user request.
- `ppt/media/*` contains real non-empty media files.
- The number of full-slide screenshots is zero unless explicitly requested.
- The PPTX contains editable text nodes.
- A preview/contact sheet has been reviewed.
- Representative screenshots match the real application.
- Old obsolete versions are not presented as the final deliverable.

## Wording Checks

Remove visible slide text containing:

- `答辩技巧`
- `自己看的`
- `这一页要说`
- `主讲提醒`
- `评委老师请看`
- `为了得分`

Allowed audience-facing wording:

- `评审要点`
- `验证路径`
- `功能对照`
- `工程交付`
- `待完善`
- `后续增强`

## Handling Missing or Unverified UI

Use one of these treatments:

- `界面待验证：当前材料未提供可运行页面`
- `功能待验证：源码中存在入口，但未完成运行截图`
- `后续增强：当前版本未实现该能力`

Do not hide missing UI behind conceptual illustrations.
