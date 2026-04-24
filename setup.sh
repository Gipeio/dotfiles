#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

mkdir -p ~/.claude

ln -sf "$DOTFILES/claude/CLAUDE.md" ~/.claude/CLAUDE.md
ln -sf "$DOTFILES/claude/settings.json" ~/.claude/settings.json

echo "dotfiles linked"
