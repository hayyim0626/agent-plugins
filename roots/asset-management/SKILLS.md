# SKILLS.md

Shared skill and prompt entrypoints for the asset management repository.

## Project-local Claude skills

- `.claude/skills/run-test`: focused test execution workflow.
- `.claude/skills/write-test`: test authoring workflow.
- `.claude/skills/create-prd.md/SKILL.md`: PRD drafting workflow.

## Shared Codex skills

Install shared Codex skills from the plugin repository into `~/.codex/skills` with:

```bash
~/agent-plugins/scripts/install-codex-skill.sh git-commit-push
```

Currently managed shared skill:

- `git-commit-push`: inspect worktree, propose grouped commits, require confirmation, then commit and push.

## Linking this project

To link this repository to the shared root documents:

```bash
~/agent-plugins/scripts/link-project.sh /Users/hong-yechan/asset_management asset-management
```
