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
