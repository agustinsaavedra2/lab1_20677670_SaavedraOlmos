#lang racket

(provide (all-defined-out))

; Nombre: create-user.
; Dominio: name (string)
; Recorrido: user (string).
; Descripción: Corresponde a la función constructora del TDA Usuario. En su entrada tiene
; un nombre. Su salida es el nombre del usuario ingresado en su entrada.

(define create-user
  (lambda (name)
    (if (string? name)
        name
        "No se puede ingresar el nombre")))

; Nombre: is-user?.
; Dominio: user (string).
; Recorrido: bool.
; Descripción: Corresponde a una función de pertenencia del TDA Usuario. Su entrada es un usuario
; y devuelve una función booleana (verdadero o falso).

(define is-user?
  (lambda (user)
    (if (string? user)
        #t
        #f)))

; Nombre: add-user.
; Dominio: list-users (list) X newUser (string).
; Recorrido: list-users (list).
; Descripción: Corresponde a una función modificadora del TDA Usuario. Su entrada es un usuario
; y una lista de usuarios, devuelve una lista de usuarios modificada con un usuarios agregado.

(define add-user
  (lambda (list-users newUser)
    (if (and (not (member newUser list-users)) (is-user? newUser))
        (cons (create-user newUser) list-users)
        list-users)))