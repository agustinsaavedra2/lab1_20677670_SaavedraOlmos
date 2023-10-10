#lang racket

(provide (all-defined-out))

(require "TDAChatbot_20677670_SaavedraOlmos.rkt")
(require "TDAUser_20677670_SaavedraOlmos.rkt")

; Nombre: chatHistory.
; Dominio: user (string) X message (string) X chatbot (list).
; Recorrido: chatHistory (list).
; Descripción: Corresponde a la función constructora del TDA ChatHistory. En su entrada tiene
; un usuario, mensaje y un chatbot. Su salida es un chatHistory representado por una lista con
; su respectivo usuario, mensaje y chatbot.

(define chatHistory
  (lambda (user message chatbot)
    (list user message chatbot)))

; Nombre: user-chatHistory.
; Dominio: chatHistory (list).
; Recorrido: user (string).
; Descripción: Corresponde a una función selectora del TDA ChatHistory. Su entrada es un chatHistory
; y retorna su usuario.

(define user-chatHistory
  (lambda (chatHistory)
    (car chatHistory)))

; Nombre: message-chatHistory.
; Dominio: chatHistory (list).
; Recorrido: message (string).
; Descripción: Corresponde a una función selectora del TDA ChatHistory. Su entrada es un chatHistory
; y retorna su mensaje.

(define message-chatHistory
  (lambda (chatHistory)
    (cadr chatHistory)))

; Nombre: chatbot-chatHistory.
; Dominio: chatHistory (list).
; Recorrido: chatbot (list).
; Descripción: Corresponde a una función selectora del TDA ChatHistory. Su entrada es un chatHistory
; y retorna su chatbot.

(define chatbot-chatHistory
  (lambda (chatHistory)
    (caddr chatHistory)))