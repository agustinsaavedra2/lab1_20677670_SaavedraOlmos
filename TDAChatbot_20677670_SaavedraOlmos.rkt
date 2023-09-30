#lang racket

(provide (all-defined-out))

(require "TDAFlow_20677670_SaavedraOlmos.rkt")

; Nombre: chatbot
; Dominio: chatbotID (int) X name (string) X welcomeMessage (string) X startFlowID (int) X flows* (list).
; Recorrido: chatbot.
; Descripción: Corresponde a la función constructora del TDA Chatbot. En su entrada tiene
; un id, nombre y opciones (son 0 o más opciones). Su salida es un flujo representado por una lista con
; la información mencionada. Cabe destacar que los flujos no se repiten debido al id de estos y su chatbotID
; es único.

(define chatbot
  (lambda (chatbotID name welcomeMessage startFlowID . flows)
    (cons chatbotID (list name welcomeMessage startFlowID
                          (delete-flows (delete-repeat-flows flows))))))