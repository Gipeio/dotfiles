# dotfiles

Personal config files, synced across machines via symlinks.

## First-time setup

1. Clone the repo
   ```bash
   git clone git@github.com:Gipeio/dotfiles.git ~/.dotfiles
   ```
2. Run the setup script
   ```bash
   ~/.dotfiles/setup.sh
   ```

## What gets linked

| Symlink | Source |
|---|---|
| `~/.claude/CLAUDE.md` | `claude/CLAUDE.md` |
| `~/.claude/settings.json` | `claude/settings.json` |

## Adding new config

1. Add the file under `~/.dotfiles/<tool>/`
2. Add a `ln -sf` line in `setup.sh`
3. Commit and push
