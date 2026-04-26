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

Projet : `/atelier/graphic_chart/` — apprenant débutant en design, apprentissage par la pratique visuelle d'abord.

### Palette — FL4K

Inspirée du personnage Borderlands 3, choisie en avril 2026.

| Rôle        | Variable CSS | Hex     |
|-------------|--------------|---------|
| Ancre       | `--kaki`     | #4A5830 |
| Accent      | `--rouge`    | #C84020 |
| Fond clair  | `--creme`    | #FAEBCC |
| Fond sombre | `--noir`     | #222220 |
| Secondaire  | `--orange`   | #D4692A |

### Typographie — Outfit + Inter

| Niveau  | Fonte  | Taille  | Graisse    |
|---------|--------|---------|------------|
| H1      | Outfit | 34px    | 800        |
| H2      | Outfit | 18–17px | 700        |
| Corps   | Inter  | 14px    | 400        |
| Caption | Inter  | 12px    | 400        |
| Label   | Inter  | 11px    | 600 · caps |

Google Fonts : `Outfit` (wght 400–800) + `Inter` (wght 400–600).

### Espacement

| Paramètre   | Valeur                                      |
|-------------|---------------------------------------------|
| Padding     | 16px                                        |
| Gap         | 10px                                        |
| Line-height | 1.55                                        |
| Radius      | carte 8px · tag 4px · bouton 5px           |
| Ombres      | aucune — bordure seule `rgba(74,88,48,.18)` |
| Layout      | sidebar fixe + grille de cartes 3 colonnes  |

### Composants

**Boutons** — 3 styles : solid / outline / ghost. 4 tailles : sm (5px 10px) / md (8px 16px) / lg (12px 24px) / xl (16px 32px). 3 états : normal / hover (fond -20% luminosité) / disabled (opacity 0.38). Icônes SVG supportées. Variante pill (border-radius 999px).

**Badges & Tags** — mêmes 3 styles que les boutons. Variantes : pill, avec dot indicateur, compteur numérique. Utilisés pour statuts (terminé/en cours/à venir) et catégories.

**Inputs** — fond `--creme`, bordure `var(--border)`, radius 5px. 4 états : normal / focus (outline kaki) / erreur (outline rouge) / disabled (opacity 0.45). Types : text, textarea, select, checkbox, radio. Icônes inline supportées.

### Iconographie — Style D Sharp

Style choisi : **D — Sharp**. `stroke-width: 2`, `stroke-linecap: square`, `stroke-linejoin: miter`, `fill: none`. Utiliser `currentColor` pour hériter de la couleur du parent.

| Taille | Usage               |
|--------|---------------------|
| 12px   | caption, tag        |
| 16px ★ | bouton, label       |
| 20px ★ | nav, liste          |
| 24px   | headline, section   |
| 32px   | empty state         |
| 48px   | illustration        |

viewBox de référence : `0 0 16 16` (adapter proportionnellement pour les autres tailles). Icônes SVG inline — pas de sprite, pas de font.
