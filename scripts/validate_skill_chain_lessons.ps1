$ErrorActionPreference = 'Stop'

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')

function Assert-Contains {
    param(
        [string]$RelativePath,
        [string[]]$Needles
    )

    $path = Join-Path $repoRoot $RelativePath
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Missing file: $path"
    }

    $text = Get-Content -Raw -Encoding UTF8 -LiteralPath $path
    foreach ($needle in $Needles) {
        if ($text.IndexOf($needle, [StringComparison]::OrdinalIgnoreCase) -lt 0) {
            throw "Missing expected lesson marker in $RelativePath`: $needle"
        }
    }
}

Assert-Contains 'skills\project-governance\software-delivery-orchestrator\SKILL.md' @(
    'user path, permission gate, state closure, and report reality'
)

Assert-Contains 'skills\requirements-api-design\api-contract-designer\SKILL.md' @(
    'Security allowlist check',
    'public recovery or session endpoints'
)

Assert-Contains 'skills\requirements-api-design\domain-solution-designer\SKILL.md' @(
    'single authoritative source',
    'worker absent'
)

Assert-Contains 'skills\frontend-ui-quality\frontend-critical-flow-acceptance\SKILL.md' @(
    'Account recovery flows',
    'worker absent'
)

Assert-Contains 'skills\project-governance\autonomous-development-governor\SKILL.md' @(
    'after a fix, reports must be updated',
    'Reality Drift'
)

'Chain-to-usable lesson validation passed.'
