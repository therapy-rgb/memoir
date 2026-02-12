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
◊(define body-size "19px")
◊(define line-height "1.4")
◊(define max-width "33em")
◊(define text-color "#111")
◊(define bg-color "#fffff8")
◊(define accent-color "#555")

◊; ——— @font-face declarations ———

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
}

main {
  margin-bottom: 3rem;
}

◊; ——— Headings ———

.chapter-title {
  font-family: ◊|heading-font|;
  font-size: 1.6em;
  font-weight: bold;
  letter-spacing: 0.01em;
  margin-bottom: 1.8rem;
  text-align: center;
}

◊; ——— Body text ———
◊; First-line indent for paragraphs (Butterick: 1–4x point size)
◊; No space between paragraphs — pick indent OR space, not both

p {
  margin-bottom: 0;
  text-indent: 1.5em;
  hanging-punctuation: first;
}

◊; No indent on first paragraph after headings, epigraphs, or breaks
p:first-of-type,
h1 + p,
h2 + p,
h3 + p,
blockquote + p,
hr + p,
.epigraph + p,
.epigraph + cite + p,
.epigraph-source + p {
  text-indent: 0;
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

◊; ——— Handwritten (TT Disruptors) ———

.handwritten {
  font-family: ◊|handwritten-font|;
  font-size: 1.1em;
}

◊; ——— Links ———
◊; Butterick: underline is acceptable for links, nothing else

a {
  color: ◊|text-color|;
  text-decoration: underline;
  text-underline-offset: 0.15em;
}

a:hover {
  color: ◊|accent-color|;
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
