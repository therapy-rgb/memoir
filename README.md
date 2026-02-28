# Methodology

A memoir by Marcus Berley. Journal entries and poems from the first year of his daughter's life.

**Read it at [methodology.pub](https://methodology.pub)**

## About

Methodology is a web-based memoir -- journal entries written in cafes and poems scribbled in stolen moments during the first year of fatherhood. Published as a literary website rather than a traditional ebook, built with tools that treat the book as a program.

## Built With

| Layer | Tool |
|-------|------|
| Publishing system | [Pollen](https://docs.racket-lang.org/pollen/) (by Matthew Butterick) |
| Language | [Racket 9.0](https://racket-lang.org/) |
| Editor | [iA Writer](https://ia.net/writer) |
| Hosting | [GitHub Pages](https://pages.github.com/) |

Pollen is a Racket-based publishing system designed for books. Content is written in `.pm` markup files using a lozenge (`◊`) command syntax and rendered to HTML via templates. The book's structure, tag definitions, and rendering logic all live alongside the prose.

## Structure

The book is organized into front matter, three thematic sections, and poems:

```
Front Matter
  Title -- cover page and table of contents
  Author -- bio and portrait
  Preface -- introduction
  Notes -- colophon and credits

Materials -- the early days
  Getting Started
  Getting Set Up
  Infinite Regression

Technique -- finding a rhythm
  The Show

Ripple Effects -- what stays with you
  Blasphemy (poem)
```

Navigation between pages is automatic -- Pollen generates previous/next links from the book's table of contents (`index.ptree`).

## Typography

Follows [Butterick's Practical Typography](https://practicaltypography.com) guidelines:

- **Body text:** Cooper Light at 22px, 1.5 line height, ~65 characters per line
- **Headings:** Cooper Bold
- **Poems and handwritten text:** TT Disruptors
- **Fallback:** Georgia

No first-line indents. Space between paragraphs. Smart quotes and proper dashes rendered automatically by Pollen's root decoder.

## Theme

Three-state toggle in the header:

| Mode | Icon | Behavior |
|------|------|----------|
| System | ◑ | Follows OS preference (default) |
| Light | ☀ | Forces light mode |
| Dark | ☾ | Forces dark mode |

A background color tint picker sits next to the theme toggle, offering four options: default, sepia, green, and pink. Tints work in both light and dark mode -- the two settings are independent.

Both choices persist in localStorage. An inline script applies saved settings before CSS loads to prevent flash.

## Local Development

### Prerequisites

- [Racket](https://racket-lang.org/) (full distribution)
- Pollen package: `raco pkg install pollen`

### Commands

```bash
raco pollen start          # Dev server at localhost:8080
raco pollen start --launch # Same, auto-opens browser
raco pollen render         # Render all pages to HTML
raco pollen render -p      # Render in parallel
raco pollen reset          # Clear caches
```

All commands should be run from the project root.

### Project Files

```
pollen.rkt               # Central config: tag functions and root decoder
index.ptree              # Book structure (reading order)
styles.css.pp            # Pollen-preprocessed CSS

template.html            # Default template (prose chapters)
template-poems.html      # Poem pages
template-title.html      # Title page with dynamic TOC
template-section.html    # Section dividers

*.html.pm                # Content pages (chapters, poems, front matter)
fonts/                   # Cooper and TT Disruptors (woff/woff2)
images/                  # Photos and figures (WebP)
```

### Writing content

Content files use Pollen Markup (`.pm`). The lozenge `◊` is the command character (Mac: Option + Shift + V):

```
◊chapter-title{Getting Started}
◊figure["images/forest.webp"]{}

Regular prose becomes paragraphs automatically.

◊dialogue{She said something}

◊section-break[]

More prose after the break.
```

Available tags: `chapter-title`, `epigraph`, `epigraph-source`, `section-break`, `dialogue`, `emphasis`, `strong`, `smallcaps`, `handwritten`, `dateline`, `poem`, `figure`, `link`.

## Deployment

The site is hosted on GitHub Pages. Pushing to `main` triggers a GitHub Actions workflow that:

1. Installs Racket and Pollen
2. Renders all `.pm` files to HTML
3. Publishes the output to the `gh-pages` branch

The custom domain `methodology.pub` is configured via a CNAME record.

## License

This work is licensed under the [Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License](LICENSE) (CC BY-NC-ND 4.0).

You are free to share the material with appropriate attribution for non-commercial purposes. No derivatives -- the text and poems may not be remixed or modified for redistribution. See the [LICENSE](LICENSE) file for full terms.
