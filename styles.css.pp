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
◊(define text-color "#111")
◊(define bg-color "#fafafa")
◊(define accent-color "#555")

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
  color: ◊|text-color|;
  background: ◊|bg-color|;
  max-width: ◊|max-width|;
  margin: 0 auto;
  padding: 4rem 1.5rem;
  font-kerning: normal;
  font-feature-settings: "kern" 1, "liga" 1;
  text-rendering: optimizeLegibility;
  -webkit-font-smoothing: antialiased;
  border: 1px solid #ddd;
}

main {
  margin-bottom: 3rem;
}

◊; ——— Site header ———

header {
  margin-bottom: 3rem;
}

.home-link {
  font-family: ◊|heading-font|;
  font-size: 0.8em;
  font-weight: bold;
  text-decoration: none;
  color: ◊|accent-color|;
  letter-spacing: 0.05em;
  text-transform: uppercase;
}

.home-link:hover {
  color: #faf9f6;
  background-color: #2c2c2c;
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
  color: ◊|accent-color|;
  text-indent: 0;
  margin-bottom: 0;
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
  color: ◊|text-color|;
  transition: color 0.15s;
}

.toc-entry:hover {
  color: #d4764e;
}

.toc-section {
  margin-top: 1.5rem;
  padding-top: 1.2rem;
  border-top: 1px solid #e0e0e0;
}

.toc-section-heading {
  font-family: ◊|heading-font|;
  font-size: 1em;
  font-weight: bold;
  font-variant: small-caps;
  letter-spacing: 0.1em;
  color: ◊|accent-color|;
  cursor: pointer;
  margin-bottom: 0.8rem;
  list-style: none;
  width: fit-content;
}

.toc-section-heading:hover {
  color: #b8860b;
}

.toc-section-heading::-webkit-details-marker {
  display: none;
}

.toc-section-heading::after {
  content: none;
}

.toc-section[open] > .toc-section-heading::after {
  content: none;
}

.toc-poem {
  font-style: italic;
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
  color: ◊|accent-color|;
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
  color: ◊|accent-color|;
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
  color: ◊|accent-color|;
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

◊; ——— Links ———
◊; Inspired by Practical Typography: small caps + color shift, no underline

a {
  color: ◊|text-color|;
  text-decoration: none;
}

a:hover {
  color: ◊|accent-color|;
}

main a:not(.home-link):not(.toc-entry) {
  color: #C44569;
  transition: background-color 0.15s;
}

main a:not(.home-link):not(.toc-entry):hover {
  background-color: #e8f5e9;
}

◊; ——— Navigation ———

nav {
  display: flex;
  justify-content: space-between;
  padding-top: 2rem;
  margin-top: 2rem;
  border-top: 1px solid #ddd;
  font-size: 0.85em;
}

nav a {
  color: ◊|accent-color|;
}

nav .nav-prev:hover,
nav .nav-next:hover {
  background-color: #e3f2fd;
}

◊; ——— Mobile ———

@media (max-width: 520px) {
  .poem {
    font-size: 2.2em;
    padding-left: 0;
  }
}
