#lang racket

(provide (all-defined-out))

; Nombre: option.
; Dominio: code (int) X message (string) X ChatbotCodeLink (int) X FlowCodeLink (int) X Keywords* (list).
; Recorrido: option.
; Descripción: Corresponde a la función constructora del TDA Opción. En su entrada tiene
; un código único, mensaje, código de enlace del chatbot, código de enlace del flujo y
; palabras claves (son 0 o más palabras). Su salida es una opción representada por una lista con
; la información mencionada.

(define option
  (lambda (code message ChatbotCodeLink FlowCodeLink . Keywords)
    (cons code (list message ChatbotCodeLink FlowCodeLink Keywords))))

; Nombre: code-option.
; Dominio: option.
; Recorrido: code (int).
; Descripción: Corresponde a una función selectora del TDA Opción. Su entrada es una opción
; y retorna su código correspondiente.

(define code-option
  (lambda (option)
    (car option)))

; Nombre: keywords-option.
; Dominio: option.
; Recorrido: Keywords (list).
; Descripción: Corresponde a una función selectora del TDA Opción. Su entrada es una opción
; y retorna las palabras claves (pueden ser 0 o más palabras) de esta.

(define keywords-option
  (lambda (option)
    (cadddr (cdr option))))