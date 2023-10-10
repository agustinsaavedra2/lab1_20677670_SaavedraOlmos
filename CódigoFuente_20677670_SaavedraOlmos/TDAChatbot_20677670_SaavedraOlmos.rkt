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

; Nombre: is-chatbot?.
; Dominio: chatbot (list).
; Recorrido: bool.
; Descripción: Corresponde a una función de pertenencia del TDA Chatbot. Su entrada es un flujo
; y devuelve una función booleana (verdadero o falso).

(define is-chatbot?
  (lambda (chatbot)
    (if (and (not (null? chatbot)) (list? chatbot) (= 5 (length chatbot)))
        #t
        #f)))

; Nombre: add-chatbot.
; Dominio: list-chatbots (list) X chatbots (list).
; Recorrido: list-chatbots (list).
; Descripción: Corresponde a una función modificadora del TDA Chatbot. Su entrada es un chatbot
; y una lista de chatbots, devuelve una lista de chatbots modificada con un flujo agregado dependiendo
; si su id está repetido o no.

(define add-chatbot
  (lambda (list-chatbots chatbot)
    (if (and (not (member (id-chatbot chatbot) (map id-chatbot list-chatbots))) (is-chatbot? chatbot))
        (cons list-chatbots chatbot)
        list-chatbots)))

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

; Nombre: repeat-id-chatbot.
; Dominio: chatbots (list).
; Recorrido: chatbots (list).
; Descripción: Corresponde a una función de operación adicional del TDA Chatbot. Su entrada es una
; lista de chatbots, devuelve una lista de chatbots modificada dependiendo si el id de un flujo
; se repite o no en base al resto de los chatbots, usando la función de orden superior filter.

(define repeat-id-chatbot
  (lambda (chatbots)
    (filter (lambda (element) (not (equal? element (id-chatbot chatbots)))) (cdr chatbots))))

; Nombre: delete-chatbots.
; Dominio: chatbots (list).
; Recorrido: chatbots (list).
; Descripción: Corresponde a una función de operación adicional del TDA Chatbot. Su entrada es una
; lista de chatbots, devuelve una lista de chatbots modificada con eliminación de chatbots en base
; a la repetición de su id. Se usa algoritmo de recursión natural para eliminar los flujos con el
; id repetido. 

(define delete-chatbots
  (lambda (chatbots)
    (if (null? chatbots)
      '()
      (cons (id-chatbot chatbots) (delete-chatbots (repeat-id-chatbot chatbots))))))

; Nombre: delete-repeat-chatbots.
; Dominio: chatbots (list).
; Recorrido: chatbots (list).
; Descripción: Corresponde a una función de operación adicional del TDA Chatbot. Su entrada es una
; lista de chatbots, devuelve una lista de chatbots con distinto id a través aplicando la función
; delete-chatbots a todas los flujos usando la función map.

(define delete-repeat-chatbots
  (lambda (chatbots)
    (map delete-chatbots chatbots)))