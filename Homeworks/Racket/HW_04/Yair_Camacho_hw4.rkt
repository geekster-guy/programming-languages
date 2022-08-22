#|
    Third Racket homework
    Using lists

    ITESM QRO
    Edgar Yair Camacho Paredes - A01206849
    TODO Change date -> 05/07/2022
|#

; Mandatory language intrepeter definition
#lang Racket

; Public functions
; (provide hailstone hailstone-list shift-char caesar-encode)

#|  
	hailstone: number -> list

	Given a integer, generate a list of numbers starting from the given integer
  and finishing at 1. The numbers in the list must obey to the following rules:
	If the number is even, divide it by 2
	If the number is odd, multiply it by 3 and add 1

	TODO EXAMPLE:
|# 
(define (hailstone number)
  (cond
    [(= number 0) empty]
    [(= number 1) (cons 1 '())]
    [(even? number) (cons number (hailstone (/ number 2)))]
    [(odd? number) (cons number (hailstone (add1 (* number 3))))]))

#|  
  hailstone-list: number number -> list

  Given two integers, the first being lower than the second, generate a new list with
  the results of the hailstone function from the lower to the upper limits.

  TODO EXAMPLE:
|#
(define (hailstone-list lower-limit upper-limit)
  (cond
    [(= lower-limit upper-limit) (cons (hailstone upper-limit) '())]
    [else (cons (hailstone lower-limit) (hailstone-list (add1 lower-limit) upper-limit))]))

; Add this to trace
; (require racket/trace)
; (trace hailstone-list)