#lang pollen

◊; —————————————————————————————————————————————
◊; Typography rules per Butterick's Practical Typography
◊;
◊; Body size:    19px (web range: 15–25px)
◊; Line height:  1.4 (140% — within 120–145% guideline)
◊; Line length:  ~33em ≈ 65 chars (within 45–90 char guideline)
◊; Paragraph:    First-line indent, no space between (pick one, not both)
◊; Kerning:      Always enabled
◊; Quotes/dashes: Handled by pollen.rkt smart-quotes and smart-dashes
◊; —————————————————————————————————————————————

◊(define body-font "'Cooper', 'Georgia', serif")
◊(define heading-font "'Cooper', 'Georgia', serif")
◊(define handwritten-font "'TT Disruptors', cursive")
◊(define body-size "22px")
◊(define line-height "1.5")
◊(define max-width "33em")

◊; ——— Color scheme (light / dark) ———
◊; Colors are CSS custom properties. Dark mode activates via:
◊;   1. OS preference (media query) — unless the user explicitly chose light
◊;   2. User toggle (data-theme="dark" on <html>)
◊; Dark values are Pollen variables so they stay in sync across both rules.

◊(define dark-text "#d4d4d4")
◊(define dark-bg "#1a1a1a")
◊(define dark-accent "#999")
◊(define dark-link "#e07a8f")
◊(define dark-link-hover-bg "#2a3a2e")
◊(define dark-border "#3a3a3a")
◊(define dark-toc-border "#333")
◊(define dark-toc-hover "#e8a070")
◊(define dark-toc-heading-hover "#d4a84a")
◊(define dark-home-hover-color "#1a1a1a")
◊(define dark-home-hover-bg "#d4d4d4")
◊(define dark-nav-hover-bg "#1e2d3d")

:root {
  color-scheme: light dark;

  --text-color: #111;
  --bg-color: #fafafa;
  --accent-color: #555;
  --link-color: #C44569;
  --link-hover-bg: #e8f5e9;
  --border-color: #ddd;
  --toc-border-color: #e0e0e0;
  --toc-hover-color: #d4764e;
  --toc-heading-hover: #b8860b;
  --home-hover-color: #faf9f6;
  --home-hover-bg: #2c2c2c;
  --nav-hover-bg: #e3f2fd;
}

:root[data-theme="light"] { color-scheme: light; }
:root[data-theme="dark"]  { color-scheme: dark; }

◊; System preference: apply dark unless user forced light
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) {
    --text-color: ◊|dark-text|;
    --bg-color: ◊|dark-bg|;
    --accent-color: ◊|dark-accent|;
    --link-color: ◊|dark-link|;
    --link-hover-bg: ◊|dark-link-hover-bg|;
    --border-color: ◊|dark-border|;
    --toc-border-color: ◊|dark-toc-border|;
    --toc-hover-color: ◊|dark-toc-hover|;
    --toc-heading-hover: ◊|dark-toc-heading-hover|;
    --home-hover-color: ◊|dark-home-hover-color|;
    --home-hover-bg: ◊|dark-home-hover-bg|;
    --nav-hover-bg: ◊|dark-nav-hover-bg|;
  }
}

◊; Explicit dark override from user toggle
:root[data-theme="dark"] {
  --text-color: ◊|dark-text|;
  --bg-color: ◊|dark-bg|;
  --accent-color: ◊|dark-accent|;
  --link-color: ◊|dark-link|;
  --link-hover-bg: ◊|dark-link-hover-bg|;
  --border-color: ◊|dark-border|;
  --toc-border-color: ◊|dark-toc-border|;
  --toc-hover-color: ◊|dark-toc-hover|;
  --toc-heading-hover: ◊|dark-toc-heading-hover|;
  --home-hover-color: ◊|dark-home-hover-color|;
  --home-hover-bg: ◊|dark-home-hover-bg|;
  --nav-hover-bg: ◊|dark-nav-hover-bg|;
}

◊; ——— @font-face declarations ———

@font-face {
  font-family: 'Cooper';
  src: url('fonts/cooper_light.woff2') format('woff2'),
       url('fonts/cooper_light.woff') format('woff');
  font-weight: 300;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'Cooper';
  src: url('fonts/cooper_medium.woff2') format('woff2'),
       url('fonts/cooper_medium.woff') format('woff');
  font-weight: normal;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'Cooper';
  src: url('fonts/cooper_bold.woff2') format('woff2'),
       url('fonts/cooper_bold.woff') format('woff');
  font-weight: bold;
  font-style: normal;
  font-display: swap;
}

@font-face {
  font-family: 'TT Disruptors';
  src: url('fonts/TT_Disruptors_Regular.woff2') format('woff2'),
       url('fonts/TT_Disruptors_Regular.woff') format('woff');
  font-weight: normal;
  font-style: normal;
  font-display: swap;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: ◊|body-font|;
  font-size: ◊|body-size|;
  font-weight: 300;
  line-height: ◊|line-height|;
  color: var(--text-color);
  background: var(--bg-color);
  max-width: ◊|max-width|;
  margin: 0 auto;
  padding: 4rem 1.5rem;
  font-kerning: normal;
  font-feature-settings: "kern" 1, "liga" 1;
  text-rendering: optimizeLegibility;
  -webkit-font-smoothing: antialiased;
}

main {
  margin-bottom: 3rem;
}

◊; ——— Site header ———

header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 3rem;
}

.title-page header {
  margin-bottom: 1rem;
}

.theme-toggle {
  background: none;
  border: none;
  cursor: pointer;
  font-family: ◊|body-font|;
  font-size: 0.7em;
  padding: 0.3em 0.5em;
  color: var(--accent-color);
  line-height: 1;
  border-radius: 4px;
  margin-left: auto;
  letter-spacing: 0.02em;
}

.theme-toggle-icon {
  margin-right: 0.3em;
}

.theme-toggle:hover {
  background-color: var(--nav-hover-bg);
}

.home-link {
  font-family: ◊|heading-font|;
  font-size: 0.8em;
  font-weight: bold;
  text-decoration: none;
  color: var(--accent-color);
  letter-spacing: 0.05em;
  text-transform: uppercase;
}

.home-link:hover {
  color: var(--home-hover-color);
  background-color: var(--home-hover-bg);
}

◊; ——— Title page ———

.title-page main {
  text-align: center;
  padding-top: 0.5rem;
  padding-bottom: 1.5rem;
}

.book-title {
  font-family: ◊|heading-font|;
  font-size: 1.8em;
  font-weight: bold;
  letter-spacing: 0.02em;
  margin-bottom: 0.5rem;
}


.book-subtitle {
  font-size: 1em;
  font-style: italic;
  color: var(--accent-color);
  text-indent: 0;
  margin-bottom: 0;
  width: 65%;
  margin-left: auto;
  margin-right: auto;
  text-align: right;
}

.title-page figure {
  margin-top: 2rem;
}

.title-page figure img {
  max-width: 65%;
}

◊; Title page image: swap between light/dark versions
◊; Light mode (default): show inverted (dark bg), hide original (light bg)
.title-page figure:has(img[src*="title-grid.webp"]:not([src*="inverted"])) {
  display: none;
}

◊; Dark mode via system preference
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) .title-page figure:has(img[src*="inverted"]) {
    display: none;
  }
  :root:not([data-theme="light"]) .title-page figure:has(img[src*="title-grid.webp"]:not([src*="inverted"])) {
    display: block;
  }
}

◊; Dark mode via toggle
:root[data-theme="dark"] .title-page figure:has(img[src*="inverted"]) {
  display: none;
}
:root[data-theme="dark"] .title-page figure:has(img[src*="title-grid.webp"]:not([src*="inverted"])) {
  display: block;
}

◊; ——— Table of contents ———
◊; Modeled on Practical Typography: clean, spacious, no decorative borders.

.toc {
  display: block;
  flex-direction: unset;
  justify-content: unset;
  border-top: none;
  font-size: inherit;
  margin-top: 3.5rem;
  padding-top: 0;
  padding-left: 2em;
}

.toc-heading {
  font-family: ◊|heading-font|;
  font-size: 1.2em;
  font-weight: bold;
  letter-spacing: 0.02em;
  margin-bottom: 1.5rem;
}

.toc-entry {
  display: block;
  width: fit-content;
  padding: 0.4em 0;
  text-decoration: none;
  color: var(--text-color);
  transition: color 0.15s;
}

.toc-entry:hover {
  color: var(--toc-hover-color);
}

.toc-section {
  margin-top: 1.5rem;
  padding-top: 1.2rem;
  border-top: 1px solid var(--toc-border-color);
}

.toc-section-heading {
  font-family: ◊|heading-font|;
  font-size: 1em;
  font-weight: bold;
  font-variant: small-caps;
  letter-spacing: 0.1em;
  color: var(--accent-color);
  cursor: pointer;
  margin-bottom: 0.8rem;
  list-style: none;
  width: fit-content;
  padding-left: 2em;
  position: relative;
}

.toc-section-heading::-webkit-details-marker {
  display: none;
}

.toc-section-heading::before {
  content: "▹";
  position: absolute;
  left: 0;
  width: 1.2em;
  text-align: center;
  border-radius: 3px;
  background-color: rgba(128, 128, 128, 0.1);
  transition: background-color 0.15s;
}

.toc-section[open] > .toc-section-heading::before {
  content: "▿";
}

.toc-section-heading:hover:not(:has(a:hover))::before {
  background-color: rgba(128, 128, 128, 0.25);
}

.toc-section-heading a {
  color: inherit;
  text-decoration: none;
}

.toc-section-heading a:hover {
  color: var(--toc-heading-hover);
  text-decoration: underline;
}

.toc-poem {
  font-style: italic;
}

◊; ——— Section divider pages ———
◊; Part title pages between sections — centered vertically and horizontally

.section-page main {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 50vh;
}

.section-page figure img {
  max-width: 65%;
}

.section-title {
  font-family: ◊|heading-font|;
  font-size: 1.6em;
  font-weight: bold;
  font-variant: small-caps;
  letter-spacing: 0.1em;
  text-align: center;
  color: var(--accent-color);
}

◊; ——— Headings ———

.chapter-title {
  font-family: ◊|heading-font|;
  font-size: 1.3em;
  font-weight: bold;
  letter-spacing: 0.01em;
  margin-bottom: 1.8rem;
  text-align: center;
}

◊; ——— Dateline ———

.dateline {
  text-align: center;
  font-size: 0.85em;
  color: var(--accent-color);
  margin-bottom: 2rem;
  text-indent: 0;
  font-style: italic;
}

◊; ——— Body text ———
◊; First-line indent for paragraphs (Butterick: 1–4x point size)
◊; No space between paragraphs — pick indent OR space, not both

p {
  margin-bottom: 1em;
  text-indent: 0;
  hanging-punctuation: first;
}

◊; ——— Emphasis ———
◊; Butterick: use bold OR italic, never both. Use sparingly.

em {
  font-style: italic;
}

strong {
  font-weight: 600;
}

◊; ——— Epigraphs ———

.epigraph {
  font-style: italic;
  font-size: 0.95em;
  margin: 2rem 2em 0.3rem 2em;
  padding: 0;
  border: none;
  text-indent: 0;
}

.epigraph p {
  text-indent: 0;
  margin-bottom: 0;
}

.epigraph-source {
  display: block;
  text-align: right;
  margin: 0 2em 2rem 2em;
  font-style: normal;
  font-size: 0.85em;
  color: var(--accent-color);
}

.epigraph-source::before {
  content: "\2014\2009";
}

◊; ——— Section breaks ———

.section-break {
  border: none;
  text-align: center;
  margin: 1.8rem 0;
}

.section-break::after {
  content: "\2022\2009\2009\2022\2009\2009\2022";
  color: var(--accent-color);
  letter-spacing: 0.2em;
}

◊; Next paragraph after a section break: no indent
.section-break + p {
  text-indent: 0;
}

◊; ——— Smallcaps ———
◊; Butterick: 5–12% extra letterspacing with small caps

.smallcaps {
  font-variant: small-caps;
  letter-spacing: 0.05em;
}

◊; ——— Poems ———

.poems-page .chapter-title {
  margin-bottom: 3rem;
}

.poem {
  font-family: ◊|handwritten-font|;
  font-size: 3em;
  line-height: 1.5;
  margin-bottom: 3rem;
  padding-left: 1.5em;
}

.poem + .poem {
  padding-top: 0;
}

◊; ——— Handwritten (TT Disruptors) ———

.handwritten {
  font-family: ◊|handwritten-font|;
  font-size: 1.1em;
}

◊; ——— Figures / Images ———

figure {
  margin: 2rem 0;
  text-align: center;
}

figure img {
  max-width: 100%;
  height: auto;
  display: block;
  margin: 0 auto;
}

◊; Author portrait: keep headshot small relative to text
[data-page="author.html"] .chapter-title + figure img {
  max-width: 50%;
}

[data-page="preface.html"] .chapter-title + figure img {
  max-width: 75%;
}

[data-page="notes.html"] figure img {
  max-width: 65%;
}

[data-page="chapter-01.html"] .chapter-title + figure img,
[data-page="chapter-02.html"] .chapter-title + figure img,
[data-page="chapter-03.html"] .chapter-title + figure img {
  max-width: 75%;
}

figcaption {
  font-size: 0.85em;
  color: var(--accent-color);
  margin-top: 0.5rem;
  text-indent: 0;
}

◊; Dark mode: subtle border on images so they don't float against dark bg
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) figure img {
    border: 1px solid ◊|dark-border|;
    border-radius: 2px;
  }
}

:root[data-theme="dark"] figure img {
  border: 1px solid ◊|dark-border|;
  border-radius: 2px;
}

◊; ——— CC license icons ———

.cc-icons {
  display: inline;
  margin-left: 0.2em;
}

.cc-icon {
  width: 1em;
  height: 1em;
  vertical-align: -0.15em;
  margin-right: 0.1em;
}

◊; ——— Links ———
◊; Inspired by Practical Typography: small caps + color shift, no underline

a {
  color: var(--text-color);
  text-decoration: none;
}

a:hover {
  color: var(--accent-color);
}

main a:not(.home-link):not(.toc-entry) {
  color: var(--link-color);
  transition: background-color 0.15s;
}

main a:not(.home-link):not(.toc-entry):hover {
  background-color: var(--link-hover-bg);
}

◊; ——— Navigation ———

nav {
  display: flex;
  justify-content: space-between;
  padding-top: 2rem;
  margin-top: 2rem;
  border-top: 1px solid var(--border-color);
  font-size: 0.85em;
}

nav a {
  color: var(--accent-color);
}

nav .nav-prev:hover,
nav .nav-next:hover {
  background-color: var(--nav-hover-bg);
}

◊; ——— Mobile ———

@media (max-width: 520px) {
  .poem {
    font-size: 2.2em;
    padding-left: 0;
  }
}
