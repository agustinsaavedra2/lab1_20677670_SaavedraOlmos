#lang racket

(require "TDAOption_20677670_SaavedraOlmos.rkt")
(require "TDAFlow_20677670_SaavedraOlmos.rkt")
(require "TDAChatbot_20677670_SaavedraOlmos.rkt")

(define op1 (option  1 "1) Viajar" 2 1 "viajar" "turistear" "conocer"))
(define op2 (option  2 "2) Estudiar" 3 1 "estudiar" "aprender" "perfeccionarme"))

(define f10 (flow 1 "flujo1" op1 op2 op2 op2 op2 op1)) ;solo añade una ocurrencia de op2
(define f11 (flow-add-option f10 op1)) ;se intenta añadir opción duplicada
(define cb0 (chatbot 0 "Inicial" "Bienvenido\n¿Qué te gustaría hacer?" 1 f10 f10 f10 f10));solo añade una ocurrencia de f10