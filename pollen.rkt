#lang racket/base
(require pollen/decode pollen/tag txexpr)
(provide (all-defined-out))

(module setup racket/base
  (provide (all-defined-out))
  (define project-server-port 8080)
  (define publish-directory "publish"))

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
