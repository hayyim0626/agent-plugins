# AGENTS.md

Repository-level instructions for coding agents working in this project.

## 1. Scope and Goal

- Scope: this file applies to the entire repository.
- Goal: deliver safe, minimal, testable changes for the asset management app.

## 2. Project Snapshot

- Framework: Next.js App Router (`src/app`)
- Language: TypeScript (`strict: true`)
- UI: React 19 + Tailwind CSS 4
- Data/Auth: Supabase REST + OAuth cookie session
- Test layers: Jest (unit/functional) + Playwright (e2e)

## 3. Key Commands

- Install deps: `yarn`
- Dev server: `yarn dev`
- Lint: `yarn lint`
- Unit tests: `yarn test:unit`
- Functional tests: `yarn test:functional`
- E2E tests: `yarn test:e2e`
- First-time E2E browser install: `yarn test:e2e:install`

## 4. Environment Requirements

Expected in `.env.local`:

- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- `NEXT_PUBLIC_APP_URL`

Never commit real secrets or tokens.

## 5. Architecture Boundaries

- `src/app`: routes, page-level composition, server/client entry points.
- `src/entities`: domain data access and domain UI building blocks.
- `src/features`: user actions and workflows (forms, mutations, server actions).
- `src/widgets`: page-level reusable compositions (for example navbar).
- `src/shared`: cross-cutting utilities, API helpers, hooks, shared UI.

Guardrails:

- Keep changes in the existing layer where possible.
- Avoid moving logic across layers unless required by the task.
- Prefer `@/` import alias over deep relative paths.

## 6. Critical Flows

When changing auth/session behavior, validate these files together:

- `src/shared/api/auth/functions.ts`
- `src/app/api/auth/route.ts`
- `src/shared/api/supabase/cookie.ts`
- `src/middleware.ts`
- `src/app/auth/callback/page.tsx`

When changing asset mutation behavior, validate these together:

- `src/features/assets/model/functions/*`
- `src/features/assets/api/*`
- `src/entities/assets/api/*`
- `src/app/assets/page.tsx`
- `src/app/assets/client.tsx`

## 7. Change Policy

- Prefer small, focused patches.
- Do not perform unrelated refactors.
- Preserve existing UX/copy unless requested.
- Add or update tests for behavior changes.
- Revalidate cache/routes where needed (for example `/assets` after mutations).

## 8. Testing Policy

Minimum validation by change type:

- Pure utility logic: run related unit tests.
- API/data transformation changes: run functional tests.
- User flow or routing/auth changes: run relevant e2e tests.

If full test execution is not possible, explicitly state what was not run.

## 9. Definition of Done

Before finishing:

- Code compiles and lints for touched files.
- Relevant tests pass.
- No secret leakage.
- Final summary includes changed files and verification commands run.
