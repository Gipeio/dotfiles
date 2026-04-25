#!/usr/bin/env bash
# Auto-commit and push the dotfiles repo when a tracked file is modified.
# Triggered by Claude Code PostToolUse hook (Edit / Write).

DOTFILES="$HOME/.dotfiles"

# Read the tool payload and extract the modified file path
FILE=$(cat | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null)

[[ -z "$FILE" ]] && exit 0

# Resolve symlinks so we can compare against the dotfiles directory
REAL=$(realpath "$FILE" 2>/dev/null)
[[ -z "$REAL" ]] && exit 0

# Only act if the file is inside the dotfiles repo
[[ "$REAL" != "$DOTFILES"/* ]] && exit 0

cd "$DOTFILES" || exit 0

git add "$REAL"

# Derive a short relative path for the commit message
REL="${REAL#$DOTFILES/}"

git commit -m "chore(dotfiles): update $REL" --quiet
git push --quiet
