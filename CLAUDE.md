# CLAUDE.md

This file provides guidance for Claude Code when working on this project.

## Working Guidelines

1. **Marcus writes, Claude builds.** Marcus focuses on prose and plain-language direction. Claude handles all Racket/Pollen technical work: tag functions, templates, config, rendering.
2. **Never speculate about code you haven't read.** Always read relevant files before making changes.
3. **Explain every change at a high level.** Marcus is learning Pollen — teach as you go.
4. **Keep it simple.** Pollen is powerful but start minimal. Add complexity only when needed.
5. **Check in before major changes.** Verify the plan before restructuring files, changing templates, or modifying `pollen.rkt`.

## Project Overview

Web-based memoir/book authored with **Pollen** (a Racket-based publishing system). Pollen treats the book as a program — content is written in `.pm` markup files with a lozenge (`◊`) command syntax, rendered to HTML via templates. Output is **HTML only** — no ebook or PDF targets.

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
├── CLAUDE.md               # This file
├── pollen.rkt              # Central config: tag functions, setup, shared code
├── index.ptree             # Book structure: chapter ordering and hierarchy
├── template.html           # Default HTML template for all chapters
├── styles.css.pp           # Pollen preprocessor CSS (variables/logic in CSS)
├── chapter-01.html.pm      # Chapter source files (Pollen Markup)
├── chapter-02.html.pm
├── ...
├── fonts/                  # Cooper, TT Disruptors (woff/woff2)
└── images/                 # Static assets (cover, photos, etc.)
```

## Key Files

- **`pollen.rkt`** — The brain of the project. Defines tag functions (how `◊` commands render), project settings, and shared code. Every `.pm` file automatically imports from here.
- **`index.ptree`** — The table of contents. Lists output filenames in reading order. Hierarchy via indentation. Navigation (previous/next) derived from this.
- **`template.html`** — HTML skeleton wrapping each chapter. Receives `doc` (content) and `here` (current page). Handles `<head>`, nav, footer.
- **`styles.css.pp`** — CSS with Pollen preprocessing (use `◊` for variables, logic).
- **`*.html.pm`** — Chapter/page source files in Pollen Markup.

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

### Metadata

Use `◊(define-meta key "value")` in source files. Access in templates via the `metas` hash table.

## Fonts

- **Cooper Medium** — body text (`fonts/cooper_medium.woff2`)
- **Cooper Bold** — headings, chapter titles (`fonts/cooper_bold.woff2`)
- **TT Disruptors** — handwritten/personal style, use via `◊handwritten{...}` (`fonts/TT_Disruptors_Regular.woff2`)
- Georgia as fallback for Cooper

Font files in `fonts/` — same fonts used on suburbandadmode.com (sourced from nextjs-blog project).

## Conventions

- **File naming:** `chapter-01.html.pm`, `chapter-02.html.pm` (zero-padded for sort order)
- **Semantic tags:** Use meaningful names (`◊chapter-title{...}`, `◊epigraph{...}`, `◊dialogue{...}`) rather than raw HTML tags. Define rendering in `pollen.rkt`.
- **One concern per file:** Content in `.pm` files, presentation logic in `pollen.rkt`, layout in `template.html`, styling in `styles.css.pp`.
- **Preview often:** Run `raco pollen start` and check the browser dashboard at `http://localhost:8080/index.ptree`
- **Cache issues:** Run `raco pollen reset` if output seems stale

## Gotchas

- Racket path includes a space: `/Applications/Racket v9.0/bin` — added to PATH in `~/.zshrc`
- `index.ptree` edits require a server restart
- `pollen.rkt` changes are picked up automatically (no restart needed)
- The lozenge `◊` is typed with **Option + Shift + V** on Mac
- Pollen's dev server renders on demand — first page load may be slow

## Repository

- **GitHub**: https://github.com/therapy-rgb/memoir (private)
- **Branch strategy**: Direct commits to `main`
