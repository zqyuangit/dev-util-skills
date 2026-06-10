# 安装说明

## 安装全部 skills

```powershell
git clone https://github.com/wxb250/dev-Util-skills.git
$repo = Resolve-Path .\dev-Util-skills
$dest = Join-Path $env:USERPROFILE ".codex\skills"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Get-ChildItem -Path (Join-Path $repo "skills") -Directory | ForEach-Object {
  Get-ChildItem -Path $_.FullName -Directory | ForEach-Object {
    Copy-Item -Recurse -Force $_.FullName (Join-Path $dest $_.Name)
  }
}
```

## 只安装某个分类

```powershell
$repo = Resolve-Path .\dev-Util-skills
$dest = Join-Path $env:USERPROFILE ".codex\skills"
Copy-Item -Recurse -Force (Join-Path $repo "skills\frontend-ui-quality\*") $dest
```

## 只安装单个 skill

```powershell
$repo = Resolve-Path .\dev-Util-skills
$dest = Join-Path $env:USERPROFILE ".codex\skills"
Copy-Item -Recurse -Force (Join-Path $repo "skills\frontend-ui-quality\frontend-critical-flow-acceptance") $dest
```

安装后建议开启新的 Codex 会话，让技能列表重新加载。

