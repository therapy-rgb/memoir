# Methodology

A memoir by Marcus Berley. Journal entries and poems from the first year of his daughter's life.

**Read it at [methodology.pub](https://methodology.pub)**

## Built with

[Pollen](https://docs.racket-lang.org/pollen/) — a publishing system by Matthew Butterick, built on Racket. Content is written in `.pm` markup files and rendered to HTML.

## Local development

Requires [Racket](https://racket-lang.org/) and the Pollen package (`raco pkg install pollen`).

```bash
raco pollen start     # Dev server at localhost:8080
raco pollen render    # Render all pages
raco pollen reset     # Clear caches
```

## Typography

Follows [Butterick's Practical Typography](https://practicaltypography.com) guidelines. Body text in Cooper Light, headings in Cooper Bold, poems in TT Disruptors.
