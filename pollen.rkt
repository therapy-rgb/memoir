#lang racket/base
(require pollen/decode pollen/tag txexpr racket/string racket/list)
(provide (all-defined-out))

(module setup racket/base
  (provide (all-defined-out))
  (define project-server-port 8080)
  (define publish-directory "publish")
  (define cache-watchlist null))

;; ——————————————————————————————————————————
;; Root decoder
;; - Smart quotes: straight " ' → curly " " ' '
;; - Smart dashes: -- → en-dash, --- → em-dash
;; - Paragraph wrapping from blank lines
;; These follow Butterick's Practical Typography rules:
;; curly quotes always, proper dashes, one space between sentences.
;; ——————————————————————————————————————————

(define (root . elements)
  (txexpr 'root empty (decode-elements elements
    #:txexpr-elements-proc decode-paragraphs
    #:string-proc (compose1 smart-quotes smart-dashes))))

;; ——————————————————————————————————————————
;; Semantic tag functions
;; Memoir-specific tags. Add more as the book grows.
;; ——————————————————————————————————————————

(define (chapter-title . elements)
  (txexpr 'h1 '((class "chapter-title")) elements))

(define (section-break)
  (txexpr 'hr '((class "section-break")) empty))

(define (epigraph . elements)
  (txexpr 'blockquote '((class "epigraph")) elements))

(define (epigraph-source . elements)
  (txexpr 'cite '((class "epigraph-source")) elements))

(define (link url . elements)
  (txexpr 'a `((href ,url) (target "_blank") (rel "noopener noreferrer")) elements))

(define (emphasis . elements)
  (txexpr 'em empty elements))

(define (strong . elements)
  (txexpr 'strong empty elements))

(define (dialogue . elements)
  (txexpr 'span '((class "dialogue")) elements))

;; Smallcaps with letterspacing (Butterick: 5–12% extra tracking)
(define (smallcaps . elements)
  (txexpr 'span '((class "smallcaps")) elements))

;; Handwritten style (TT Disruptors)
(define (handwritten . elements)
  (txexpr 'span '((class "handwritten")) elements))

;; Dateline for journal entries
(define (dateline . elements)
  (txexpr 'p '((class "dateline")) elements))

;; Title page elements
(define (book-title . elements)
  (txexpr 'h1 '((class "book-title")) elements))

(define (book-subtitle . elements)
  (txexpr 'p '((class "book-subtitle")) elements))

;; Figures: image with optional caption
;; Usage: ◊figure["images/photo.jpg"]{Caption text} or ◊figure["images/photo.jpg"]
(define (figure src . elements)
  (define caption-elements (filter (lambda (e) (not (equal? e ""))) elements))
  (define img (txexpr 'img `((src ,src) (loading "lazy") (alt ,(if (pair? caption-elements)
                                                                    (string-join (filter string? caption-elements) "")
                                                                    ""))) empty))
  (if (null? caption-elements)
      (txexpr 'figure empty (list img))
      (txexpr 'figure empty (list img (txexpr 'figcaption empty caption-elements)))))

;; Creative Commons license icons
(define (cc-icons)
  (txexpr 'span '((class "cc-icons"))
    (list
      (txexpr 'img '((src "images/cc.svg") (alt "Creative Commons") (class "cc-icon")) empty)
      (txexpr 'img '((src "images/by.svg") (alt "Attribution") (class "cc-icon")) empty)
      (txexpr 'img '((src "images/nc.svg") (alt "NonCommercial") (class "cc-icon")) empty)
      (txexpr 'img '((src "images/nd.svg") (alt "NoDerivatives") (class "cc-icon")) empty))))

;; HTML-escape helper for safe string interpolation in templates
(define (html-escape s)
  (string-replace (string-replace (string-replace (string-replace s "&" "&amp;") "<" "&lt;") ">" "&gt;") "\"" "&quot;"))

;; Poetry: preserve line breaks within a poem block
(define (poem . elements)
  (define text (string-join
    (filter string?
      (flatten elements)) ""))
  (define lines (string-split text "\n"))
  (define line-elements
    (add-between
      (map (lambda (l) (string-trim l)) lines)
      '(br)))
  (txexpr 'div '((class "poem")) line-elements))
