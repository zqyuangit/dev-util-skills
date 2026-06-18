$ErrorActionPreference = 'Stop'

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$skillsRoot = Join-Path $repoRoot 'skills'
$orchestrator = Join-Path $skillsRoot 'project-governance\software-delivery-orchestrator\SKILL.md'

function Get-SkillMeta {
    Get-ChildItem -LiteralPath $skillsRoot -Recurse -Filter SKILL.md -File | ForEach-Object {
        $text = Get-Content -Raw -Encoding UTF8 -LiteralPath $_.FullName
        $front = if ($text -match '(?s)^---\s*(.*?)\s*---') { $Matches[1] } else { '' }
        $name = if ($front -match '(?m)^name:\s*([^\r\n]+)') { $Matches[1].Trim().Trim('"') } else { Split-Path $_.DirectoryName -Leaf }
        $description = if ($front -match '(?ms)^description:\s*(.+?)(?:\r?\n\w[\w-]*:|\z)') { $Matches[1].Trim().Trim('"') -replace '\s+', ' ' } else { '' }
        [PSCustomObject]@{
            Name = $name
            Description = $description
            Folder = Split-Path $_.DirectoryName -Leaf
            Path = $_.FullName
        }
    }
}

function Assert-True {
    param(
        [bool]$Condition,
        [string]$Message
    )
    if (-not $Condition) {
        throw $Message
    }
}

$meta = @(Get-SkillMeta)

Assert-True (Test-Path -LiteralPath $orchestrator) 'Missing software-delivery-orchestrator skill.'

$text = Get-Content -Raw -Encoding UTF8 -LiteralPath $orchestrator
foreach ($required in @(
    'REQUIRED SUB-SKILL: Use superpowers:brainstorming',
    'REQUIRED SUB-SKILL: Use design-from-materials',
    'REQUIRED SUB-SKILL: Use architecture-freeze-check',
    'REQUIRED SUB-SKILL: Use domain-solution-designer',
    'REQUIRED SUB-SKILL: Use api-contract-designer',
    'REQUIRED SUB-SKILL: Use superpowers:writing-plans',
    'REQUIRED SUB-SKILL: Use superpowers:test-driven-development',
    'REQUIRED SUB-SKILL: Use superpowers:dispatching-parallel-agents',
    'REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development',
    'REQUIRED SUB-SKILL: Use superpowers:systematic-debugging',
    'REQUIRED SUB-SKILL: Use superpowers:verification-before-completion',
    'REQUIRED SUB-SKILL: Use frontend-critical-flow-acceptance'
)) {
    Assert-True ($text.Contains($required)) "Missing route marker: $required"
}

foreach ($canonical in @('openai-docs', 'pdf')) {
    $count = @($meta | Where-Object Name -eq $canonical).Count
    Assert-True ($count -eq 1) "Expected exactly one canonical '$canonical' skill, found $count."
}

Assert-True (Test-Path -LiteralPath (Join-Path $skillsRoot 'ai-tooling\openai-api-docs\SKILL.md')) 'Missing collision-resolved openai-api-docs skill.'
Assert-True (Test-Path -LiteralPath (Join-Path $skillsRoot 'docs-delivery\pdf-local-workflow\SKILL.md')) 'Missing collision-resolved pdf-local-workflow skill.'
Assert-True (Test-Path -LiteralPath (Join-Path $skillsRoot 'ai-tooling\context7-cli\SKILL.md')) 'Missing context7-cli folder.'
Assert-True (-not (Test-Path -LiteralPath (Join-Path $skillsRoot 'ai-tooling\context7'))) 'Legacy context7 folder should be renamed to context7-cli.'

$context7 = $meta | Where-Object Name -eq 'context7-cli'
Assert-True (@($context7).Count -eq 1) 'Expected exactly one context7-cli skill.'
Assert-True ($context7.Folder -eq 'context7-cli') 'context7-cli skill name/folder mismatch remains.'

$orchestratorMeta = $meta | Where-Object Name -eq 'software-delivery-orchestrator'
Assert-True ($orchestratorMeta.Description.StartsWith('Use when')) 'Orchestrator description must start with "Use when".'
Assert-True ($text.Contains('The user has explicitly authorized Codex to split suitable tasks and use subagents or parallel agents without asking again.')) 'Missing standing subagent authorization.'
Assert-True ($text.Contains('Do not ask for confirmation merely because subagents would be useful.')) 'Missing no-confirmation delegation rule.'

'Skill orchestration validation passed.'
