# agent-plugins

여러 AI 에이전트에서 공통 문서와 스킬을 재사용할 수 있도록, symlink 중심으로 관리하는 shared plugin 저장소입니다.

## 핵심 방식

- `install root`를 실행하면 프로젝트 안에 `root.md`가 생성됩니다.
- 생성된 `root.md`가 해당 프로젝트의 SSOT가 되고, `AGENTS.md`와 `.claude/CLAUDE.md`는 이 로컬 `root.md`를 가리키는 symlink가 됩니다.
- 공유 스킬은 하나의 source를 두고, 필요한 사용자나 프로젝트에 선택 설치합니다.
- 스킬을 `symlink` 모드로 설치하면 shared repo 업데이트가 각 사용자 환경에도 즉시 반영됩니다.
- 버전 고정이 필요하면 `--mode copy`를 사용할 수 있습니다.

## 구조

- `roots/root.md`: 프로젝트 local root.md를 처음 만들 때 사용하는 shared template
- `skills/*`: 공유 skill 원본
- `plugins/root/plugin.yaml`: root 설치 매니페스트
- `plugins/skill/*/plugin.yaml`: 스킬 설치 매니페스트
- `scripts/agent-plugin`: 플러그인 설치 CLI

## 사용법

프로젝트에 local root.md를 만들고 AGENTS.md, .claude/CLAUDE.md를 연결:

```bash
python3 ~/agent-plugins/scripts/agent-plugin install root /path/to/project
```

프로젝트에 shared skill 설치:

```bash
python3 ~/agent-plugins/scripts/agent-plugin install skill run-test --project-root /path/to/project
python3 ~/agent-plugins/scripts/agent-plugin install skill write-test --project-root /path/to/project
python3 ~/agent-plugins/scripts/agent-plugin install skill create-prd --project-root /path/to/project
```

사용자 전역 skill 설치:

```bash
python3 ~/agent-plugins/scripts/agent-plugin install skill git-commit-push
```

이미 같은 경로에 파일이나 디렉토리가 있으면 기본값으로 중단합니다. 기존 symlink를 교체할 때만 `--force`를 사용합니다.

```bash
python3 ~/agent-plugins/scripts/agent-plugin install root /path/to/project --force
python3 ~/agent-plugins/scripts/agent-plugin install skill run-test --project-root /path/to/project --force
python3 ~/agent-plugins/scripts/agent-plugin install skill git-commit-push --force
```

현재 설치 가능한 플러그인 목록 보기:

```bash
python3 ~/agent-plugins/scripts/agent-plugin list
```
