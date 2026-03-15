---
name: git-commit-push
description: Inspect the current repository changes, group modified files by feature or context, propose one or more commit messages using the custom types `chore`, `add`, `fix`, and `hotfix`, ask the user to confirm the commit plan, then create commits and push the current branch. Use when users want Codex to review an in-progress git worktree, split work into sensible commits, confirm the commit messages before writing history, and push to GitHub.
---

# Git Commit Push

## Goal

Turn a dirty git worktree into a reviewed commit plan, get explicit user confirmation on commit messages and grouping, then commit and push without rewriting unrelated work.

## Workflow

1. Inspect the repository state before proposing anything:
   - Run `git status --short`
   - Run `git branch --show-current`
   - Run `git remote -v`
   - Review `git diff --stat`, `git diff --cached --stat`, and file-level diffs for touched files
2. Group changes by feature or context rather than by file extension.
3. Draft commit messages with one of the allowed types:
   - `chore`: dependency install/update or repo maintenance not directly tied to product behavior
   - `add`: new feature or newly introduced user-facing capability
   - `fix`: targeted bug fix or small module/UI adjustment
   - `hotfix`: urgent production-oriented repair that should be called out as exceptional
4. Present the proposed commit plan to the user before staging or committing anything.
5. After the user confirms, stage only the files for the approved group, create the commit, and repeat for additional groups.
6. Push only after commits are complete and the user confirmation covers push as part of the plan.

## Commit Message Rules

- Use the format `<type>: <summary>`.
- Keep the summary short, concrete, and behavior-oriented.
- Prefer one coherent commit per feature or context.
- Split into multiple commits when a single message would hide separate concerns.
- Do not force splitting if the diff is tightly coupled and should land atomically.
- If there are unrelated local changes, call them out and exclude them from staging unless the user explicitly wants them included.

## Confirmation Contract

Before any `git add`, `git commit`, or `git push`:

1. Show the proposed commit groups.
2. Show the exact commit message for each group.
3. Ask the user to confirm whether to proceed as proposed or adjust the messages/grouping.

Treat user confirmation as mandatory. Do not create commits from inferred approval.

## Push Rules

- Confirm the current branch and tracked remote before pushing.
- If the branch has no upstream, explain the intended push command before running it.
- Check how the repository authenticates to GitHub before pushing:
  - For SSH remotes, verify SSH-based GitHub authentication is available.
  - For HTTPS remotes, verify credential helper or `gh` authentication is available.
- If GitHub authentication is missing or insufficient for write access, stop and tell the user that authentication must be completed before push can continue.
- Request escalated permissions when networked git/GitHub operations are needed.
- Prefer `git push` for an existing tracked branch.
- Use `git push --set-upstream <remote> <branch>` only when no upstream exists and the user-approved plan requires it.

## Safety Rules

- Never rewrite history as part of this skill unless the user explicitly asks.
- Never stage all files blindly with `git add .` when unrelated changes are present.
- Never discard user changes.
- If the worktree mixes generated files, dependency bumps, and feature edits, separate them only when the diff supports a clear review boundary.
- If a commit type is ambiguous between `fix` and `hotfix`, default to `fix` unless the user or context indicates urgency.

## Output Shape

When reporting the plan to the user, provide:

1. A short summary of the change groups
2. The proposed commit message for each group
3. Any risky assumptions or unclear file ownership
4. The planned push target

When execution finishes, report:

1. The commits created
2. The branch and remote pushed
3. Any remaining uncommitted files
