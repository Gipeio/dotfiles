# Global CLAUDE.md

Rules that apply to all projects on this machine.

## Language

Always respond in French unless the codebase, comments, or existing docs are in English — in that case follow the language of the code.

## Style

- No comments in code unless the WHY is non-obvious
- No docstrings or multi-line comment blocks
- Short, direct responses — no trailing summaries of what was just done

## Git

- Never push without explicit confirmation
- Never amend published commits
- Never use --no-verify
- Prefer creating a new commit over amending when a hook fails

## Behavior

- Always confirm before destructive operations (rm, reset --hard, force-push, drop table)
- Don't add features or abstractions beyond what the task requires
- Don't add error handling for scenarios that can't happen
