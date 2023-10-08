#lang racket

(provide (all-defined-out))

(require "TDAChatbot_20677670_SaavedraOlmos.rkt")
(require "TDAUser_20677670_SaavedraOlmos.rkt")

; Nombre: system
; Dominio: name (string) X InitialChatbotCodeLink (int) X chatbot* (list).
; Recorrido: system (list).
; Descripción: Corresponde a la función constructora del TDA System. En su entrada tiene
; un nombre, código de enlace al chatbot inicial y chatbots (son 0 o más chatbots).
; Su salida es un sistema representado por una lista con la información mencionada. Cabe destacar que los chatbots
; no se repiten debido al id de estos y su nombre es único.

(define system
  (lambda (name InitialChatbotCodeLink . chatbot)
    (cons name (list InitialChatbotCodeLink
               (eliminar-duplicados3 (eliminar-concurrencias3 chatbot)) null null))))

; Nombre: name-system
; Dominio: system (list).
; Recorrido: name (string).
; Descripción: Corresponde a una función selectora de TDA Sistema. Su entrada recibe
; un sistema. Su salida es el nombre del sistema entrante.

(define name-system
  (lambda (system)
    (car system)))

; Nombre: InitialChatbotCodeLink-system
; Dominio: system (list).
; Recorrido: InitialChatbotCodeLink (int).
; Descripción: Corresponde a una función selectora de TDA Sistema. Su entrada recibe
; un sistema. Su salida es el código inicial del chatbot del sistema entrante.

(define InitialChatbotCodeLink-system
  (lambda (system)
    (cadr system)))

; Nombre: chatbots-system
; Dominio: system (list).
; Recorrido: chatbots (list).
; Descripción: Corresponde a una función selectora de TDA Sistema. Su entrada recibe
; un sistema. Su salida corresponde a la lista de chatbots del sistema entrante.

(define chatbots-system
  (lambda (system)
    (caddr system)))

; Nombre: chatbotHistory-system
; Dominio: system (list).
; Recorrido: chatbotHistory (list).
; Descripción: Corresponde a una función selectora de TDA Sistema. Su entrada recibe
; un sistema. Su salida corresponde a los chatbots del sistema entrante.

(define chatbotHistory-system
  (lambda (system)
    (cadddr system)))

; Nombre: user-system
; Dominio: system (list).
; Recorrido: user (list).
; Descripción: Corresponde a una función selectora de TDA Sistema. Su entrada recibe
; un sistema. Su salida corresponde a los usuarios del sistema entrante.

(define user-system
  (lambda (system)
    (cadddr (cdr system))))

; Nombre: user-login
; Dominio: system (list).
; Recorrido: user (list).
; Descripción: Corresponde a una función selectora de TDA Sistema. Su entrada recibe
; un sistema. Su salida corresponde al usuario que inicia la sesión en el sistema entrante.

(define user-login
  (lambda (system)
    (cadddr (cddr system))))

(define is-system?
  (lambda (system)
    (if (and (not (null? system)) (= 6 (length system)))
        #t
        #f)))

; Nombre: system-add-chatbot.
; Dominio: system (list) X chatbot (list).
; Recorrido: system (list).
; Descripción: Corresponde a una función modificadora del TDA Sistema. En su entrada recibe
; un sistema y una opción. Su salida corresponde a un sistema con la misma cantidad de chatbots o
; un chatbot más (si no se repiten). Cabe destacar que los chatbots añadidos no se pueden repetir
; con respecto a su id.

(define system-add-chatbot
  (lambda (system chatbot)
    (cons (name-system system) (cons (InitialChatbotCodeLink-system system)
    (cons (add-chatbot (chatbots-system system) chatbot) (list null null null))))))

(define system-add-user
  (lambda (system user)
    (cons (name-system system) (cons (InitialChatbotCodeLink-system system)
    (cons (chatbots-system system) (cons (chatbotHistory-system system)
    (cons (add-user (user-system system) user) (cons (user-login system) null))))))))

(define system-login
  (lambda (system user)
    (if (and (member user (user-system system)) (not (= 1 (length (user-login system)))))
        (cons (name-system system) (cons (InitialChatbotCodeLink-system system) (cons (chatbots-system system)
        (cons (chatbotHistory-system system) (cons (user-system system) (cons (list user) (user-login system)))))))
        system)))

(define system-logout
  (lambda (system)
     (cons (name-system system) (cons (InitialChatbotCodeLink-system system)
     (cons (chatbots-system system) (cons (chatbotHistory-system system)
     (cons (user-system system) (cons null null))))))))