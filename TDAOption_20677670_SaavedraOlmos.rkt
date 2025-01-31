#lang racket

(provide (all-defined-out))

; Nombre: option.
; Dominio: code (int) X message (string) X ChatbotCodeLink (int) X FlowCodeLink (int) X Keywords* (list).
; Recorrido: option (list).
; Descripción: Corresponde a la función constructora del TDA Opción. En su entrada tiene
; un código único, mensaje, código de enlace del chatbot, código de enlace del flujo y
; palabras claves (son 0 o más palabras). Su salida es una opción representada por una lista con
; la información mencionada.

(define option
  (lambda (code message ChatbotCodeLink FlowCodeLink . Keywords)
    (cons code (list message ChatbotCodeLink FlowCodeLink Keywords))))

; Nombre: code-option.
; Dominio: option (list).
; Recorrido: code (int).
; Descripción: Corresponde a una función selectora del TDA Opción. Su entrada es una opción
; y retorna su código correspondiente.

(define code-option
  (lambda (option)
    (car option)))

; Nombre: message-option.
; Dominio: option (list).
; Recorrido: message (string).
; Descripción: Corresponde a una función selectora del TDA Opción. Su entrada es una opción
; y retorna su mensaje correspondiente.

(define message-option
  (lambda (option)
    (cadr option)))

; Nombre: keywords-option.
; Dominio: option (list).
; Recorrido: Keywords (list).
; Descripción: Corresponde a una función selectora del TDA Opción. Su entrada es una opción
; y retorna las palabras claves (pueden ser 0 o más palabras) de esta.

(define keywords-option
  (lambda (option)
    (cadddr (cdr option))))

; Nombre: is-option?.
; Dominio: option (list).
; Recorrido: bool.
; Descripción: Corresponde a una función de pertenencia del TDA Opción. Su entrada es una opción
; y devuelve una función booleana (verdadero o falso).

(define is-option?
  (lambda (option)
    (if (and (not (null? option)) (list? option) (= 5 (length option)))
        #t
        #f)))

; Nombre: add-option.
; Dominio: list-options (list) X option (list).
; Recorrido: list-options (list).
; Descripción: Corresponde a una función modificadora del TDA Opción. Su entrada es una opción
; y una lista de opciones, devuelve una lista de opciones modificada con una opcion agregada.

(define add-option
  (lambda (list-options option)
    (if (is-option? option)
        (cons option list-options)
        list-options)))

; Nombre: repeat-code.
; Dominio: options (list).
; Recorrido: options (list).
; Descripción: Corresponde a una función de operación adicional del TDA Opción. Su entrada es una
; lista de opciones, devuelve una lista de opciones modificada dependiendo si el id de una opción
; se repite o no en base al resto de las opciones, usando la función de orden superior filter.

(define repeat-code
  (lambda (options)
    (filter (lambda (element) (not (equal? element (code-option options)))) (cdr options))))

; Nombre: delete-options.
; Dominio: options (list).
; Recorrido: options (list).
; Descripción: Corresponde a una función de operación adicional del TDA Opción. Su entrada es una
; lista de opciones, devuelve una lista de opciones modificada con eliminación de opciones en base
; a la repetición de su id. Se usa algoritmo de recursión natural para eliminar las opciones con el
; id repetido. 

(define delete-options
  (lambda (options)
    (if (null? options)
      '()
      (cons (code-option options) (delete-options (repeat-code options))))))

; Nombre: delete-repeat-options.
; Dominio: options (list).
; Recorrido: options (list).
; Descripción: Corresponde a una función de operación adicional del TDA Opción. Su entrada es una
; lista de opciones, devuelve una lista de opciones con distinto id a través aplicando la función
; delete-options a todas las opciones usando la función map.

(define delete-repeat-options
  (lambda (options)
    (map delete-options options)))
