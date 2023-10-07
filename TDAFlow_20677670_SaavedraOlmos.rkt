#lang racket

(provide (all-defined-out))

(require "TDAOption_20677670_SaavedraOlmos.rkt")

; Nombre: flow.
; Dominio: id (int) X name (string) X Options* (list).
; Recorrido: flow (list).
; Descripción: Corresponde a la función constructora del TDA Flujo. En su entrada tiene
; un id, nombre y opciones (son 0 o más opciones). Su salida es un flujo representado por una lista con
; la información mencionada. Cabe destacar que las opciones no se repiten debido al id de estas.

(define flow
  (lambda (id name . Options)
    (cons id (list name (delete-options (delete-repeat-options Options))))))

(define add-flow
  (lambda (flows flow)
    (cons flow flows)))

; Nombre: id-flow.
; Dominio: flow (list).
; Recorrido: id (int).
; Descripción: Corresponde a una función selectora del TDA Flujo. En su entrada recibe
; un flujo. Su salida corresponde al id del flujo entrante.

(define id-flow
  (lambda (flow)
    (car flow)))

; Nombre: name-flow.
; Dominio: flow (list).
; Recorrido: name (string).
; Descripción: Corresponde a una función selectora del TDA Flujo. En su entrada recibe
; un flujo. Su salida corresponde al nombre del flujo entrante.

(define name-flow
  (lambda (flow)
    (cadr flow)))

; Nombre: options-flow.
; Dominio: flow (list).
; Recorrido: Options (list).
; Descripción: Corresponde a una función selectora del TDA Flujo. En su entrada recibe
; un flujo. Su salida corresponde a la lista de opciones del flujo entrante.

(define options-flow
  (lambda (flow)
    (caddr flow)))

; Nombre: flow-add-option.
; Dominio: flow (list) X option (list).
; Recorrido: flow (list).
; Descripción: Corresponde a una función modificadora del TDA Flujo. En su entrada recibe
; un flujo y una opción. Su salida corresponde a un flujo con la misma cantidad de opciones o
; una opción más (si no se repiten). Cabe destacar que las opciones añadidas no se pueden repetir
; con respecto a su id.

(define flow-add-option
  (lambda (flow option)
    (cons (id-flow flow) (cons (name-flow flow)
          (list (delete-flows (delete-repeat-flows (add-option (options-flow flow) option))))))))

(define repeat-id-flow
  (lambda (flows)
    (filter (lambda (element) (not (equal? element (id-flow flows)))) (cdr flows))))

(define delete-flows
  (lambda (flows)
    (if (null? flows)
      '()
      (cons (id-flow flows) (delete-flows (repeat-id-flow flows))))))

(define delete-repeat-flows
  (lambda (flows)
    (map delete-flows flows)))