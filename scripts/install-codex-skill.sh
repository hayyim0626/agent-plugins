#!/usr/bin/env bash
set -euo pipefail

SKILL_NAME="${1:?skill name required}"
PLUGIN_HOME="${PLUGIN_HOME:-$HOME/agent-plugins}"
SOURCE_DIR="$PLUGIN_HOME/skills/$SKILL_NAME"
TARGET_DIR="$HOME/.codex/skills/$SKILL_NAME"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "missing skill directory: $SOURCE_DIR" >&2
  exit 1
fi

mkdir -p "$HOME/.codex/skills"
ln -sfn "$SOURCE_DIR" "$TARGET_DIR"

echo "installed Codex skill: $SKILL_NAME"
