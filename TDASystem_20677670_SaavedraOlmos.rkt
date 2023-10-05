#lang racket

(provide (all-defined-out))

(require "TDAChatbot_20677670_SaavedraOlmos.rkt")

; Nombre: system
; Dominio: name (string) X InitialChatbotCodeLink (int) X chatbot* (list).
; Recorrido: chatbot.
; Descripción: Corresponde a la función constructora del TDA System. En su entrada tiene
; un nombre, código de enlace al chatbot inicial y chatbots (son 0 o más chatbots).
; Su salida es un sistema representado por una lista con la información mencionada. Cabe destacar que los chatbots
; no se repiten debido al id de estos y su nombre es único.

(define system
  (lambda (name InitialChatbotCodeLink . chatbot)
    (cons name (list InitialChatbotCodeLink
               (eliminar-duplicados3 (eliminar-concurrencias3 chatbot)) null null))))

; Nombre: name-system
; Dominio: system.
; Recorrido: name.
; Descripción: Corresponde a una función selectora de TDA System. Su entrada recibe
; un sistema. Su salida es el nombre del sistema entrante.

(define name-system
  (lambda (system)
    (car system)))

; Nombre: InitialChatbotCodeLink-system
; Dominio: system.
; Recorrido: InitialChatbotCodeLink.
; Descripción: Corresponde a una función selectora de TDA System. Su entrada recibe
; un sistema. Su salida es el código inicial del chatbot del sistema entrante.

(define InitialChatbotCodeLink-system
  (lambda (system)
    (cadr system)))

; Nombre: chatbots-system
; Dominio: system.
; Recorrido: chatbots.
; Descripción: Corresponde a una función selectora de TDA System. Su entrada recibe
; un sistema. Su salida corresponde a los chatbots del sistema entrante.

(define chatbots-system
  (lambda (system)
    (caddr system)))

(define chatbotHistory-system
  (lambda (system)
    (cadddr system)))

(define user-system
  (lambda (system)
    (cadddr (cdr system))))

(define user-login
  (lambda (system)
    (cadddr (cddr system))))

(define system-add-chatbot
  (lambda (system chatbot)
    (cons (name-system system) (cons (InitialChatbotCodeLink-system system)
    (cons (add-chatbot (chatbots-system system) chatbot) (list null null null))))))

(define system-add-user
  (lambda (system user)
    (cons (name-system system) (cons (InitialChatbotCodeLink-system system)
    (cons (chatbots-system system) (cons (chatbotHistory-system system)
    (cons (add-user (user-system system) user) (cons (user-login system) null))))))))