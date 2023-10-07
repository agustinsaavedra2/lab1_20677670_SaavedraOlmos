#lang racket

(provide (all-defined-out))

(require "TDAFlow_20677670_SaavedraOlmos.rkt")

; Nombre: chatbot
; Dominio: chatbotID (int) X name (string) X welcomeMessage (string) X startFlowID (int) X flows* (list).
; Recorrido: chatbot (list).
; Descripción: Corresponde a la función constructora del TDA Chatbot. En su entrada tiene
; un id, nombre y opciones (son 0 o más opciones). Su salida es un flujo representado por una lista con
; la información mencionada. Cabe destacar que los flujos no se repiten debido al id de estos y su chatbotID
; es único.

(define chatbot
  (lambda (chatbotID name welcomeMessage startFlowID . flows)
    (cons chatbotID (list name welcomeMessage startFlowID
                          (delete-flows (delete-repeat-flows flows))))))

(define add-chatbot
  (lambda (chatbots chatbot)
    (if (member (id-chatbot chatbot) (map id-chatbot chatbots))
        chatbots
        (cons chatbots chatbot))))

; Nombre: id-chatbot
; Dominio: chatbot (list).
; Recorrido: chatbotID (int).
; Descripción: Corresponde a una función selectora de TDA Chatbot. Su entrada recibe
; un chatbot. Su salida es el ID del chatbot entrante.

(define id-chatbot
  (lambda (chatbot)
    (car chatbot)))

; Nombre: name-chatbot
; Dominio: chatbot (list).
; Recorrido: name (string).
; Descripción: Corresponde a una función selectora de TDA Chatbot. Su entrada recibe
; un chatbot. Su salida es el nombre del chatbot entrante.

(define name-chatbot
  (lambda (chatbot)
    (cadr chatbot)))

; Nombre: welcomeMessage-chatbot
; Dominio: chatbot (list).
; Recorrido: welcomeMessage (string).
; Descripción: Corresponde a una función selectora de TDA Chatbot. Su entrada recibe
; un chatbot. Su salida es el mensaje de bienvenida del chatbot entrante.

(define welcomeMessage-chatbot
  (lambda (chatbot)
    (caddr chatbot)))

; Nombre: startFlowID-chatbot
; Dominio: chatbot (list).
; Recorrido: startFlowID (int).
; Descripción: Corresponde a una función selectora de TDA Chatbot. Su entrada recibe
; un chatbot. Su salida es el ID del flujo inicial del chatbot entrante.

(define startFlowID-chatbot
  (lambda (chatbot)
    (cadddr chatbot)))

; Nombre: flows-chatbot
; Dominio: chatbot (list).
; Recorrido: flows (list).
; Descripción: Corresponde a una función selectora de TDA Chatbot. Su entrada recibe
; un chatbot. La salida son los flujos contenidos en el chatbot entrante.

(define flows-chatbot
  (lambda (chatbot)
    (cddddr chatbot)))

; Nombre: chatbot-add-flow.
; Dominio: chatbot (list) X flow (list).
; Recorrido: flow (list).
; Descripción: Corresponde a una función modificadora del TDA Chatbot. En su entrada recibe
; un chatbot y una flujo. Su salida corresponde a un chatbot con la misma cantidad de flujos o
; una flujo más (si no se repiten). Cabe destacar que los flujos añadidos no se pueden repetir
; con respecto a su id. Además, se utiliza un algoritmo de recursión natural para añadir el flujo
; al chatbot de entrada.

(define chatbot-add-flow
  (lambda (chatbot flow)
    (cond
      [(null? flow) chatbot]
      [(member (id-flow flow) (map id-flow (flows-chatbot chatbot)))
       (chatbot-add-flow chatbot (cdr (flows-chatbot chatbot)))]
      [else (cons (id-chatbot chatbot) (cons (name-chatbot chatbot) (cons (welcomeMessage-chatbot chatbot)
            (cons (startFlowID-chatbot chatbot) (cons (flows-chatbot chatbot)
                                                 (add-flow (cdr (flows-chatbot chatbot)) flow))))))])))

(define eliminar-duplicados3
  (lambda (chatbots)
    (if (null? chatbots)
      '()
      (cons (id-chatbot chatbots)
            (eliminar-duplicados3
             (filter (lambda (element)
                       (not (equal? element (id-chatbot chatbots))))
                     (cdr chatbots)))))))

(define eliminar-concurrencias3
  (lambda (chatbots)
    (map eliminar-duplicados3 chatbots)))