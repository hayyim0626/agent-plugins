# agent-plugins

여러 AI 에이전트에서 공통 문서와 스킬을 재사용할 수 있도록, 설치 가능한 플러그인 형태로 관리하는 저장소입니다.

## 구성

- `roots/root.md`: 공통 루트 템플릿 원본
- `plugins/root/plugin.yaml`: `AGENTS.md`, `.claude/CLAUDE.md` 생성용 플러그인 매니페스트
- `plugins/codex-skill/git-commit-push/plugin.yaml`: Codex skill 설치용 플러그인 매니페스트
- `skills/git-commit-push`: 공유 Codex skill 원본
- `scripts/agent-plugin`: 플러그인 설치 CLI

## 사용법

프로젝트에 공통 루트 문서를 생성:

```bash
/Users/hong-yechan/agent-plugins/scripts/agent-plugin install root /path/to/project --project-name my-project --force
```

공유 Codex skill 설치:

```bash
/Users/hong-yechan/agent-plugins/scripts/agent-plugin install codex-skill git-commit-push
```
