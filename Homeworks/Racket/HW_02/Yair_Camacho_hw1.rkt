#|
    First Racket homework
    Using functions and arithmetic operations

    ITESM QRO
    Edgar Yair Camacho Paredes - A01206849
    05/07/2022
|#

; Mandatory language intrepreter definition
#lang racket

; Public functions
(provide is-triangle? triangle-type point-quadrant parking-ticket)

#| 
  is-triangle?: number number number -> boolean

  Says if a figure is a triangle by giving the length of its sides
  
  EXAMPLES:
  (is-triangle? 7 7 7) -> #t
  (is-triangle? 1 0 5) -> #f
|#
(define (is-triangle? a b c)
  (and
   (and (positive? a)
        (positive? b)
        (positive? c))
   (and (> (+ a b) c)
        (> (+ b c) a)
        (> (+ c a) b))))

#|  
  triangle-type: number number number -> string

  Shows what type of triangle is, given the length of its sides

  EXAMPLES:
  (triangle-type 2 2 2) -> EQUILATERAL
  (triangle-type 4 7 4) -> ISOSCELES
  (triangle-type 3 4 5) -> SCALENE
|#
(define (triangle-type a b c)
  (if (not (is-triangle? a b c))
      'INVALID
      (cond
        [(= a b c) 'EQUILATERAL]
        [(or (= a b) (= a c) (= b c)) 'ISOSCELES]
        [else 'SCALENE])))

#|  
  point-quadrant: number number -> string

  Given the coordinates x and y, show the quadrant where the point is located

  EXAMPLES:
  (point-quadrant 0 0) -> ORIGIN
  (point-quadrant 0 5) -> Y_AXIS
  (point-quadrant -8 0) -> X_AXIS
  (point-quadrant -2 -9) -> III
  (point-quadrant -6 7) -> II
|#
(define (point-quadrant x y)
  (cond
    [(zero? (* x y))
     (cond
       [(not (zero? y)) 'Y_AXIS]
       [(not (zero? x)) 'X_AXIS]
       [else 'ORIGIN])]
    [(positive? (* x y))
     (if (positive? x)
         'I
         'III)]
    [(negative? (* x y))
     (if (positive? x)
         'IV
         'II)]))

#|  
  parking-ticket: number number string -> number

  Calculate the parking fee by giving hours, minutes and ticket status
  
  EXAMPLES:
  (parking-ticket 0 0 'STAMPED) -> 0
  (parking-ticket 3 14 'LOST) -> 100
  (parking-ticket 4 31 'STAMPED) -> 39
|#
(define (parking-ticket hours minutes ticket)
  (if (= 0 hours minutes)
      0
      (case ticket
        ['LOST 100]
        ['STAMPED
         (cond
           [(< hours 2) 5]
           [(< hours 3) 17]
           [else (- (parking-fee hours minutes) 19)])]
        ['UNSTAMPED
         (if (< hours 1)
             12
             (parking-fee hours minutes))]
        [else "error: TICKET UNABLE TO READ"])))

; Helper function for parking-ticket that calculates the normal parking fee
(define (parking-fee hours minutes)
  (cond
    [(<= minutes 15) (+ (* hours 12) 5)]
    [(<= minutes 30) (+ (* hours 12) 8)]
    [(<= minutes 45) (+ (* hours 12) 10)]
    [else (* (add1 hours) 12)]))
  