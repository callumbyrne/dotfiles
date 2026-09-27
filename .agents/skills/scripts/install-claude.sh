#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="${1:-$HOME/.claude/skills}"

SKILLS=(
  deliver
  explore
  handoff
  implement
  bugfix
  review
  architect
  create-verification
)

mkdir -p "$DEST"

for skill in "${SKILLS[@]}"; do
  src="$ROOT_DIR/$skill"
  dst="$DEST/$skill"
  rm -rf "$dst"
  cp -R "$src" "$dst"
  echo "installed $skill -> $dst"
done

echo "Installed ${#SKILLS[@]} skills into $DEST"
