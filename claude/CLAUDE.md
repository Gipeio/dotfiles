# Global CLAUDE.md

This file provides global guidance to Claude Code across all repositories.

## Language

All written artifacts (code, comments, docs, READMEs, commit messages) must be in professional, concise English. Conversation in the terminal is in French.

## Code style

Follow current best practices for the stack in use. When in doubt, research and apply the most up-to-date conventions for the language and framework.

## Code comments

Code must be readable by someone who knows programming but not the specific stack. This means:

- Every file gets a short header comment (1–3 lines) explaining its role in the system and how it connects to other files.
- Inline comments only where the **why** is non-obvious: a hidden constraint, a subtle invariant, a surprising behavior.
- Comments form a navigable trail — not a numbered list, but linked breadcrumbs. A reader can start anywhere and follow the thread through the codebase.
- The entry point (e.g. `main.tsx`, `main.py`, `index.ts`) is the suggested starting point; the README root can mention it.
- Never verbose. One precise sentence beats three vague ones.

## Commit messages

Short, explicit, professional English. Describe what changed and why, not how.

## Config & dotfiles

Global config (`~/.claude/CLAUDE.md`, `~/.claude/settings.json`) lives in the dotfiles repo at `https://github.com/Gipeio/dotfiles` (cloned at `~/.dotfiles`). Both files are symlinks into `~/.dotfiles/claude/`.

A PostToolUse hook auto-commits and pushes `~/.dotfiles` whenever one of its files is edited. Never edit `~/.claude/CLAUDE.md` directly — verify the symlink is in place, then edit through the dotfiles path.

New machine setup: `git clone git@github.com:Gipeio/dotfiles.git ~/.dotfiles && ~/.dotfiles/setup.sh`

## Behavior

- Always ask for confirmation before: pushing, deleting files or branches, force-reset, dropping data.
- No sycophancy: if the user proposes a suboptimal algorithm, an outdated approach, or a technology with a better alternative — say so clearly and explain why.
- No ambiguity: if anything in the request is unclear, ask immediately and wait for the answer before proceeding. Never guess or assume.
- If the request is vague or lacks context, fire all clarifying questions upfront — goal, constraints, scale, existing attempts, preferences. Do not start until the picture is clear.
- No trailing summaries of what was just done.

## Charte graphique personnelle

Palette **FL4K** — choisie en avril 2026, inspirée du personnage Borderlands 3.

| Rôle        | Variable CSS | Hex     |
|-------------|--------------|---------|
| Ancre       | `--kaki`     | #4A5830 |
| Accent      | `--rouge`    | #C84020 |
| Fond clair  | `--creme`    | #FAEBCC |
| Fond sombre | `--noir`     | #222220 |
| Secondaire  | `--orange`   | #D4692A |

Projet charte : `/atelier/graphic_chart/`
