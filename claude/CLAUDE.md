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
- Warn the user before proceeding with any task likely to consume more than 5% of the remaining session context. Estimate based on file sizes, number of files to generate, and scope of work.
- For any visual addition or modification in a webapp (colors, fonts, spacing, icons, components): use the **Glaze** design system at `/atelier/glaze/`. The active palette is **Garance** — source of truth is `/atelier/glaze/src/palettes/presets.ts`. Never invent colors or styles outside this palette.

## Boot screen (webapps)

Every webapp gets an animated boot screen. It is **not optional** — implement it automatically when scaffolding or setting up a new webapp.

**Canonical implementation**: `/atelier/glaze/src/boot/` — copy and adapt it. The module is self-contained (`index.ts` + `style.css`). Entry-point wiring lives in the app's `main.ts` (see `/atelier/glaze/src/main.ts`).

### Parameters to adapt per project
- **App name** — used in the terminal boot messages (e.g. `Starting <AppName> Runtime...`)
- **ASCII art** — box-drawing block letters of the app name, shown centered during the logo reveal phase
- **Logo** — the app's pixel-art or SVG logo, displayed below the ASCII art

### Three phases
1. **Terminal boot** — dmesg-style lines then systemd-style `[  OK  ]` service starts, referencing the app's actual subsystems. Web Audio API noise bursts per line (subtle, realistic).
2. **Logo reveal** — ASCII art fades in centered, lifts slightly, pixel/SVG logo fades in below. Two-tone sine chime on entry.
3. **Scan dismiss** — overlay clipped from top in `steps(6)` over 640ms (stepped, mechanical feel). Filtered noise burst per step. A red `--t-accent` scan bar marks the clip boundary.

### Appearance rules
| Situation | Behavior |
|---|---|
| New tab | Full boot (phases 1 → 2 → 3) |
| Browser closed → reopened | Full boot |
| Private / incognito session | Full boot |
| Page refresh (F5) in same tab | Scan only (phase 3) |
| In-app navigation / page switch | Scan only (phase 3) |
| Same tab, no reload | Nothing (already booted) |
| Duplicated tab | Nothing (sessionStorage is copied) |

State tracked via `sessionStorage` key `<appname>:booted`. Scan on refresh and page switch is wired in the app's entry point alongside the template/route change listener.

A `[ REPLAY BOOT ]` button (fixed, bottom-right) is included in **every webapp** by default. It clears the session flag and replays the full boot sequence.

## Charte graphique personnelle

Design system : `/atelier/glaze/` — palette-driven, Garance is the active preset.

### Palette — Garance

| Rôle    | Token CSS     | Hex     |
|---------|---------------|---------|
| Fond    | `--t-bg`      | #EEE2DE |
| Surface | `--t-surface` | #EA906C |
| Accent  | `--t-accent`  | #B31312 |
| Texte   | `--t-text`    | #2B2A4C |
