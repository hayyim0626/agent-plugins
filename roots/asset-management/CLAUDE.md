# CLAUDE.md

Claude-specific operating guide for this repository.

## 1. Purpose

Use this file with `AGENTS.md`:

- `AGENTS.md`: repository-wide agent rules (source of truth for shared policy).
- `.claude/CLAUDE.md`: Claude-focused workflow and execution details.

If instructions overlap, follow `AGENTS.md` first, then this file.

## 2. Local Working Style

- Keep edits minimal and task-scoped.
- Match existing patterns before introducing new abstractions.
- Prefer incremental verification over large untested changes.
- When behavior changes, explain impact in terms of user flow.

## 3. Project Workflow

1. Read relevant route/domain files before editing.
2. Confirm server vs client boundaries:
   - `page.tsx` and server actions on server side.
   - `"use client"` components on client side.
3. Apply focused patch.
4. Run the smallest relevant tests first, then broader checks as needed.
5. Report:
   - Files changed
   - Why changed
   - What was verified
   - What was not verified

## 4. Skills Available in `.claude/skills`

- `run-test`: use for test execution workflows.
- `write-test`: use for test authoring workflows.
- `create-prd`: use for PRD drafting flow.

Use the minimum relevant skill set per task.

## 5. Commands Reference

- `yarn dev`
- `yarn lint`
- `yarn test:unit`
- `yarn test:functional`
- `yarn test:e2e`

For first Playwright setup:

- `yarn test:e2e:install`

## 6. High-Risk Areas

Auth/session:

- `src/shared/api/auth/functions.ts`
- `src/app/api/auth/route.ts`
- `src/shared/api/supabase/cookie.ts`
- `src/middleware.ts`
- `src/app/auth/callback/page.tsx`

Asset data + mutations:

- `src/entities/assets/api/*`
- `src/features/assets/api/*`
- `src/features/assets/model/functions/*`
- `src/app/assets/page.tsx`
- `src/app/assets/client.tsx`

Any change in these areas should include explicit validation notes.

## 7. Testing Expectations

- Utility/math logic: unit tests required.
- API handler/data adaptation: functional tests recommended.
- Routing/auth/login flow: e2e coverage recommended.

If a test is skipped due to environment/runtime limits, state it clearly.

## 8. Safety Rules

- Never commit secrets in code, logs, or docs.
- Do not introduce unrelated formatting-only churn.
- Avoid dependency upgrades unless requested.
- Keep user-visible copy changes intentional and requested.
