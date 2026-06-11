#!/usr/bin/env python3
"""Validate dev-Util-skills repository metadata without external packages."""

from __future__ import annotations

import json
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SKILLS_ROOT = ROOT / "skills"
MANIFEST = ROOT / "skills-manifest.json"


def frontmatter(text: str, path: Path) -> dict[str, str]:
    if not text.startswith("---\n"):
        raise ValueError(f"{path}: missing opening frontmatter")
    end = text.find("\n---\n", 4)
    if end == -1:
        raise ValueError(f"{path}: missing closing frontmatter")
    result: dict[str, str] = {}
    for line in text[4:end].splitlines():
        if ":" not in line:
            continue
        key, value = line.split(":", 1)
        result[key.strip()] = value.strip().strip('"')
    return result


def main() -> int:
    errors: list[str] = []
    warnings: list[str] = []

    manifest = json.loads(MANIFEST.read_text(encoding="utf-8-sig"))
    manifest_by_name = {item["name"]: item for item in manifest}
    manifest_names = set(manifest_by_name)
    skill_names: set[str] = set()

    for skill_md in sorted(SKILLS_ROOT.glob("*/*/SKILL.md")):
        text = skill_md.read_text(encoding="utf-8", errors="replace")
        rel_dir = skill_md.parent.relative_to(ROOT).as_posix()
        try:
            meta = frontmatter(text, skill_md)
        except ValueError as exc:
            errors.append(str(exc))
            continue

        name = meta.get("name", "")
        description = meta.get("description", "")
        if not name:
            errors.append(f"{skill_md}: missing name")
            continue
        if not description:
            errors.append(f"{skill_md}: missing description")
        skill_names.add(name)

        manifest_item = manifest_by_name.get(name)
        if not manifest_item:
            errors.append(f"{skill_md}: skill name '{name}' missing from manifest")
        elif manifest_item.get("path") != rel_dir:
            errors.append(
                f"{skill_md}: manifest path mismatch for '{name}': "
                f"{manifest_item.get('path')} != {rel_dir}"
            )

        openai_yaml = skill_md.parent / "agents" / "openai.yaml"
        if not openai_yaml.exists():
            warnings.append(f"{skill_md.parent}: missing agents/openai.yaml")
        else:
            agent_text = openai_yaml.read_text(encoding="utf-8", errors="replace")
            for required in ("display_name:", "short_description:"):
                if required not in agent_text:
                    errors.append(f"{openai_yaml}: missing {required}")

    for extra in sorted(manifest_names - skill_names):
        errors.append(f"manifest contains missing skill '{extra}'")

    print(f"skills: {len(skill_names)}")
    print(f"manifest: {len(manifest)}")
    print(f"warnings: {len(warnings)}")
    print(f"errors: {len(errors)}")
    for warning in warnings:
        print(f"WARNING: {warning}")
    for error in errors:
        print(f"ERROR: {error}")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
