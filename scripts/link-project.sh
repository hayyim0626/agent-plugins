#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="${1:?project path required}"
ROOT_NAME="${2:?root name required}"
PLUGIN_HOME="${PLUGIN_HOME:-$HOME/agent-plugins}"
ROOT_DIR="$PLUGIN_HOME/roots/$ROOT_NAME"

if [ ! -d "$ROOT_DIR" ]; then
  echo "missing root directory: $ROOT_DIR" >&2
  exit 1
fi

mkdir -p "$PROJECT_ROOT/.claude"
ln -sfn "$ROOT_DIR/AGENTS.md" "$PROJECT_ROOT/AGENTS.md"
ln -sfn "$ROOT_DIR/CLAUDE.md" "$PROJECT_ROOT/.claude/CLAUDE.md"

if [ -f "$ROOT_DIR/SKILLS.md" ]; then
  ln -sfn "$ROOT_DIR/SKILLS.md" "$PROJECT_ROOT/.claude/SKILLS.md"
fi

echo "linked $PROJECT_ROOT to $ROOT_DIR"
