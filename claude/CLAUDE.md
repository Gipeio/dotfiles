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

## README structure

Every project README must include a **Tech Stack** section. It must list, in a table:

| Column | What to put |
|---|---|
| Language | Name + major version |
| Framework | Name + major version, or "none" |
| Build tool | e.g. Vite, webpack, esbuild, cargo |
| Package manager | npm, pnpm, cargo, pip, etc. |
| Output type | Static SPA, SSR, CLI binary, library, etc. |
| Dev server port | If applicable |
| Testing | Framework name, or "none" |
| Design system | e.g. Glaze — Cassette palette, or "none" |

Follow the table with a one-liner noting any major constraint (no framework, no ORM, etc.) and the entry point file.

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
- For any visual addition or modification in a webapp (colors, fonts, spacing, icons, components): use the **Glaze** design system at `/atelier/glaze/`. Two modes — **mode sombre (défaut) : palette Cassette** / **mode clair : palette Garance** — source of truth is `/atelier/glaze/src/palettes/presets.ts`. Never invent colors or styles outside these palettes.

## Boot screen (webapps)

Every webapp gets an animated boot screen. It is **not optional** — implement it automatically when scaffolding or setting up a new webapp.

**Canonical implementation**: `/atelier/glaze/src/boot/` — copy and adapt it. The module is self-contained (`index.ts` + `style.css`). Entry-point wiring lives in the app's `main.ts` (see `/atelier/glaze/src/main.ts`).

### Parameters to adapt per project
- **App name** — used in the terminal boot messages (e.g. `Starting <AppName> Runtime...`)
- **ASCII art** — box-drawing block letters of the app name, shown centered during the logo reveal phase
- **Logo** — the app's pixel-art or SVG logo, displayed below the ASCII art

### Visual style
The boot overlay has an LCD scanlines layer (`::before` pseudo-element, `repeating-linear-gradient` every 3px, 5% `--t-text` tint on 1px stripes — same technique as `t01-ecran`). This sits above all content (`z-index: 100`) with `pointer-events: none`.

### Three phases
1. **Terminal boot** — dmesg-style lines then systemd-style `[  OK  ]` service starts, referencing the app's actual subsystems. Web Audio API noise bursts per line (subtle, realistic). **Write exactly 22 lines** matching the structure of the Glaze reference (`/atelier/glaze/src/boot/index.ts` → `LINES` array): 7 dmesg-style `tag: 'none'` lines (hardware/kernel init), then 15 systemd-style lines alternating `tag: 'wait'` / `tag: 'ok'` pairs, each referencing a real subsystem of the app (e.g. auth service, DB connection, router, API client). Keep timestamps and BIOS/CPU/memory lines generic; customize only the service names.
2. **Logo reveal** — ASCII art appears at screen center (`translateY(80px)` from its flex-group position), then animates to its final position (`translateY(0)`, `420ms cubic-bezier(0.2,0,0.2,1)`). ASCII font-size: `15px`. ASCII color: `--t-text` (beige, **not** `--t-accent` or `--t-surface`). Gap between ASCII and logo: `40px`. Logo size: `108×108px`. Two-tone sine chime on entry. **These values are locked — source of truth is `/atelier/glaze/src/boot/`.**
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

A `[ REBOOT ]` button (fixed, bottom-right) is included in **every webapp** by default. It clears the session flag and replays the full boot sequence.

## Webapp icons

Every webapp needs three icon assets wired into `index.html`. Never reuse the source logo SVG directly for the favicon — its viewBox is designed for the boot screen, not for small display.

### Files to create in `public/`

| File | Purpose | Size |
|---|---|---|
| `favicon.svg` | Browser tab icon | SVG with tight viewBox |
| `apple-touch-icon.png` | Bookmark / home screen icon | 180×180 PNG |

The source logo SVG (e.g. from `glaze/logos/<app>/main.svg`) is **not** used as the favicon directly. It stays as-is for the boot screen (`LOGO_SRC`).

### favicon.svg — tight viewBox

Calculate the bounding box of the actual drawn content (ignore empty canvas space). Add ~8px padding on all sides and make the viewBox square.

Example: content spanning x −48→48, y 2→96 → viewBox `"-56 -7 112 112"`.

The SVG body is a verbatim copy of the source logo; only the root `<svg>` attributes change:
```svg
<svg width="112" height="112" viewBox="<tight-box>" xmlns="http://www.w3.org/2000/svg">
  <!-- logo paths copied verbatim -->
</svg>
```

### apple-touch-icon.png — generate via Playwright

`playwright-core` is available in every Node project. Use it to render `favicon.svg` to a 180×180 PNG:

```js
const { chromium } = require('./node_modules/playwright-core');
const fs = require('fs');
(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage();
  await page.setViewportSize({ width: 180, height: 180 });
  const svg = fs.readFileSync('./public/favicon.svg', 'utf8');
  await page.setContent(`<!DOCTYPE html><html><head><style>
    * { margin:0; padding:0; }
    body { width:180px; height:180px; background:transparent; display:flex; align-items:center; justify-content:center; }
    svg { width:180px; height:180px; }
  </style></head><body>${svg}</body></html>`);
  fs.writeFileSync('./public/apple-touch-icon.png', await page.screenshot({ type:'png', omitBackground:true }));
  await browser.close();
})();
```

### index.html wiring

```html
<title><appname></title>
<link rel="icon" type="image/svg+xml" href="/favicon.svg" />
<link rel="apple-touch-icon" href="/apple-touch-icon.png" />
```

The `<title>` must match the app's warehouse subdomain (e.g. `warehouse`, `desktop`, `radio`).

## Deploying an app to warehouse

Full checklist: `/atelier/warehouse/deploy-apps.md`. Summary below.

### App-side requirements
- `Dockerfile` at the repo root
- App binds on `0.0.0.0:<port>` (not localhost)
- All config via environment variables, no hardcoded paths

### Dockerfile — static SPA (Vite / any build-to-dist tool)

```dockerfile
FROM node:alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 8080
```

Always add an `nginx.conf` next to the Dockerfile:

```nginx
server {
    listen 8080;
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

And a `.dockerignore`:
```
node_modules
dist
.git
.env*
```

### CI/CD — GitHub Actions self-hosted runner

The warehouse server runs a self-hosted runner (registered via Ansible). Every app repo gets a workflow at `.github/workflows/deploy.yml`:

```yaml
name: Deploy to warehouse

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: [self-hosted, warehouse]
    steps:
      - uses: actions/checkout@v4

      - name: Sync source to compose directory
        run: |
          rsync -a --delete \
            --exclude=node_modules \
            --exclude=.git \
            --exclude=dist \
            "$GITHUB_WORKSPACE/" /opt/warehouse/<appname>/

      - name: Rebuild and restart container
        run: |
          cd /opt/warehouse
          docker compose build <appname>
          docker compose up -d --no-deps <appname>
```

### Warehouse-side additions (per app)
1. Add service in `ansible/files/docker-compose.yml` with `build: ./<appname>`
2. Add Ansible task in `compose` role to sync the source: `ansible.posix.synchronize src=/atelier/<appname>/ dest={{ compose_dir }}/<appname>/`
3. Add matcher in `ansible/files/caddy/Caddyfile` → `<appname>.warehouse.dedyn.io`
4. Reserve a port in `/atelier/warehouse/ports.md`
5. Run the playbook: `cd /atelier/warehouse/ansible && infisical run --domain https://eu.infisical.com/api --env prod -- ansible-playbook site.yml`

## Charte graphique personnelle

Design system : `/atelier/glaze/` — deux modes de palette.

### Mode sombre (défaut) — Cassette

| Rôle    | Token CSS     | Hex     |
|---------|---------------|---------|
| Fond    | `--t-bg`      | #1A1912 |
| Surface | `--t-surface` | #4E6851 |
| Accent  | `--t-accent`  | #B83A2D |
| Texte   | `--t-text`    | #DCC9A9 |

### Mode clair — Garance

| Rôle    | Token CSS     | Hex     |
|---------|---------------|---------|
| Fond    | `--t-bg`      | #EEE2DE |
| Surface | `--t-surface` | #EA906C |
| Accent  | `--t-accent`  | #B31312 |
| Texte   | `--t-text`    | #2B2A4C |
