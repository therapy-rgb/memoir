# CLAUDE.md

This file provides guidance for Claude Code when working on this project.

## Working Guidelines

1. **Marcus writes, Claude builds.** Marcus focuses on prose and plain-language direction. Claude handles all Racket/Pollen technical work: tag functions, templates, config, rendering.
2. **Never speculate about code you haven't read.** Always read relevant files before making changes.
3. **Explain every change at a high level.** Marcus is learning Pollen — teach as you go.
4. **Keep it simple.** Pollen is powerful but start minimal. Add complexity only when needed.
5. **Check in before major changes.** Verify the plan before restructuring files, changing templates, or modifying `pollen.rkt`.

## Project Overview

**Methodology** — a web-based memoir/book by Marcus Berley, authored with **Pollen** (a Racket-based publishing system). Journal entries from the first year of his daughter's life, plus poems written in stolen moments.

Pollen treats the book as a program — content is written in `.pm` markup files with a lozenge (`◊`) command syntax, rendered to HTML via templates. Output is **HTML only** — no ebook or PDF targets.

- **Live site:** https://methodology.pub
- **Hosting:** GitHub Pages (`gh-pages` branch)

## Tech Stack

- **Racket 9.0** — language runtime (installed at `/Applications/Racket v9.0/`)
- **Pollen** — book publishing system (Racket package)
- **DrRacket** — IDE for Racket/Pollen development

## Commands

```bash
raco pollen start             # Start dev server (localhost:8080), preview in browser
raco pollen start --launch    # Same, but auto-opens browser
raco pollen render            # Render all source files to output
raco pollen render -p         # Render in parallel (faster on multi-core)
raco pollen publish           # Export clean output (no source files) for distribution
raco pollen reset             # Clear all caches (fresh start)
raco pollen setup             # Pre-compile and cache everything
raco pollen version           # Show Pollen version
```

All commands should be run from the project root (`/Users/marcusberley/Documents/Projects/memoir`).

## Project Structure

```
memoir/
├── CLAUDE.md                # This file
├── pollen.rkt               # Central config: tag functions, setup, shared code
├── index.ptree              # Book structure: chapter ordering and hierarchy
├── index.html               # Redirect → title.html (landing page)
│
├── template.html            # Default HTML template (prose chapters)
├── template-poems.html      # Poem pages (body class "poems-page")
├── template-title.html      # Title page with table of contents
│
├── title.html.pm            # Title page
├── preface.html.pm          # Preface
├── author.html.pm           # Author bio
├── chapter-01.html.pm       # Prose chapters (01–09)
├── ...
├── chapter-09.html.pm
├── poem-01.html.pm          # Poems (01–09)
├── ...
├── poem-09.html.pm
├── notes.html.pm            # Colophon / notes
├── puttering.html.pm        # Draft (not in index.ptree)
│
├── styles.css.pp            # Pollen preprocessor CSS (variables/logic in CSS)
├── fonts/                   # Cooper Light/Medium/Bold, TT Disruptors (woff/woff2)
└── images/                  # Static assets (squiggle, etc.)
```

## Key Files

- **`pollen.rkt`** — The brain of the project. Defines tag functions (how `◊` commands render), project settings, and shared code. Every `.pm` file automatically imports from here.
- **`index.ptree`** — The table of contents. Lists output filenames in reading order. Navigation (previous/next) derived from this.
- **`template.html`** — Default HTML template for prose chapters. Receives `doc` (content) and `here` (current page). Handles header, nav, footer.
- **`template-poems.html`** — Template for poem pages. Same structure as `template.html` but adds a `poems-page` body class for poem-specific styling.
- **`template-title.html`** — Title page template. Builds the table of contents dynamically, grouping entries into Prose and Poems sections using the `section` meta.
- **`styles.css.pp`** — CSS with Pollen preprocessing (use `◊` for variables, logic). Typography follows Butterick's Practical Typography guidelines.
- **`*.html.pm`** — Chapter/page source files in Pollen Markup.

## Tag Functions

All defined in `pollen.rkt`. Use these in `.pm` files:

| Tag | Usage | Renders as |
|-----|-------|-----------|
| `◊chapter-title{...}` | Chapter/page heading | `<h1 class="chapter-title">` |
| `◊epigraph{...}` | Opening quote | `<blockquote class="epigraph">` |
| `◊epigraph-source{...}` | Attribution for epigraph | `<cite class="epigraph-source">` |
| `◊section-break[]` | Scene/section divider | `<hr class="section-break">` (renders as • • •) |
| `◊dialogue{...}` | Quoted speech | `<span class="dialogue">` |
| `◊emphasis{...}` | Italic text | `<em>` |
| `◊strong{...}` | Bold text | `<strong>` |
| `◊smallcaps{...}` | Small capitals | `<span class="smallcaps">` |
| `◊handwritten{...}` | TT Disruptors font | `<span class="handwritten">` |
| `◊dateline{...}` | Journal entry date | `<p class="dateline">` |
| `◊poem{...}` | Poem block (preserves line breaks) | `<div class="poem">` |
| `◊book-title{...}` | Title page heading | `<h1 class="book-title">` |
| `◊book-subtitle{...}` | Title page subtitle | `<p class="book-subtitle">` |
| `◊squiggle[]` | Decorative squiggle image | `<img class="squiggle">` |

## Metadata Conventions

Every `.pm` file starts with metadata via `◊(define-meta ...)`:

```
◊(define-meta title "Chapter Title")           # Required — used in nav and TOC
◊(define-meta section "prose")                  # "prose" or "poems" — groups entries in TOC
◊(define-meta template "template-poems.html")   # Override default template
◊(define-meta date "November 15, 2025")         # Date for journal entries
```

- `title` — required on every page. Displayed in navigation links and the TOC.
- `section` — set to `"prose"` or `"poems"`. The title page template uses this to group TOC entries into collapsible Prose/Poems sections. Pages without a `section` (preface, author, notes) appear as standalone TOC entries.
- `template` — overrides `template.html`. Poems use `template-poems.html`, the title page uses `template-title.html`.

## Pollen Basics (for Claude's Reference)

### Command Syntax

The lozenge (`◊`) is the command character (Mac: Option + Shift + V):

```
◊tag{text content}                    → X-expression: '(tag "text content")
◊tag[#:attr "val"]{text}              → With attributes
◊(racket-expression)                  → Inline Racket code
◊(define-meta title "Chapter One")    → Page metadata
◊; comment                            → Comment (no output)
```

Any unknown tag name becomes an X-expression automatically. Define custom rendering in `pollen.rkt`.

### Rendering Pipeline

```
Source (.pm) → Pollen Parser → X-expression → Template → Output (.html)
```

### Pagetree Rules

- `index.ptree` lists **output** filenames (e.g., `chapter-01.html`), not source filenames
- Indentation creates parent-child hierarchy
- Changing `index.ptree` requires restarting the dev server

### Navigation (in templates)

- `(previous here)` — previous page in sequence
- `(next here)` — next page in sequence
- `(up here)` — parent page in hierarchy

## Fonts

- **Cooper Light** — body text, weight 300 (`fonts/cooper_light.woff2`)
- **Cooper Medium** — weight 400 (`fonts/cooper_medium.woff2`)
- **Cooper Bold** — headings, chapter titles (`fonts/cooper_bold.woff2`)
- **TT Disruptors** — handwritten/personal style, use via `◊handwritten{...}` or `◊poem{...}` (`fonts/TT_Disruptors_Regular.woff2`)
- Georgia as fallback for Cooper

Font files in `fonts/` — same fonts used on suburbandadmode.com (sourced from nextjs-blog project).

## Conventions

- **File naming:** `chapter-01.html.pm`, `poem-01.html.pm` (zero-padded for sort order)
- **Semantic tags:** Use meaningful names (`◊chapter-title{...}`, `◊epigraph{...}`, `◊dialogue{...}`) rather than raw HTML tags. Define rendering in `pollen.rkt`.
- **One concern per file:** Content in `.pm` files, presentation logic in `pollen.rkt`, layout in templates, styling in `styles.css.pp`.
- **Drafts:** Files not listed in `index.ptree` (e.g., `puttering.html.pm`) are drafts — they exist in the repo but aren't part of the book's navigation or TOC.
- **Preview often:** Run `raco pollen start` and check the browser dashboard at `http://localhost:8080/index.ptree`
- **Cache issues:** See the "Restarting the Dev Server" section below — `raco pollen reset` alone is not enough

## Deployment

- **Live site:** https://methodology.pub
- **Hosting:** GitHub Pages, served from the `gh-pages` branch
- **Deploy process:** Use the `/ship` skill, which renders, commits, pushes to `main`, publishes to `gh-pages`, and restores the CNAME
- **CNAME:** `methodology.pub` (written to `gh-pages` branch during deploy)

## Restarting the Dev Server

When `index.ptree`, templates, or metadata changes aren't reflected, a full restart is needed. `pkill -f "raco pollen start"` often fails to kill the Racket server processes. Use this reliable sequence:

```bash
# 1. Find and force-kill the actual processes on port 8080
kill -9 $(lsof -ti:8080) 2>/dev/null

# 2. Wait and verify the port is free
sleep 2
lsof -ti:8080 2>/dev/null || echo "PORT FREE"

# 3. Delete stale rendered output files and cache
rm -rf compiled/
rm -f title.html preface.html author.html chapter-*.html poem-*.html notes.html styles.css

# 4. Reset Pollen cache (belt and suspenders)
raco pollen reset

# 5. Start fresh
raco pollen start &
```

**Why all these steps?**
- `pkill` doesn't reliably kill Racket server processes — always use `kill -9` on PIDs from `lsof -ti:8080`
- Pollen serves pre-rendered `.html` files from disk if they exist, so stale output files must be deleted
- The `compiled/` directory holds Pollen's internal cache (`.rktd` files) which can also go stale
- `raco pollen reset` only clears cache it knows about — manually deleting `compiled/` is more thorough

## Gotchas

- Racket path is in `/etc/paths.d/racket` — includes a space (`/Applications/Racket v9.0/bin`)
- `index.ptree` edits require a full server restart (see above)
- `pollen.rkt` changes are picked up automatically (no restart needed)
- The lozenge `◊` is typed with **Option + Shift + V** on Mac
- Pollen's dev server renders on demand — first page load may be slow
- Always render from the project directory (not with full absolute paths) — Pollen sets `here` based on the working directory
- On this machine, `grep` is aliased to `rg` — use `command grep` in shell pipelines to get real grep behavior

## Repository

- **GitHub**: https://github.com/therapy-rgb/memoir (private)
- **Branch strategy**: Direct commits to `main`
