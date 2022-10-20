;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname fizz-buzz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; (fizz-buzz start end fizz buzz) consumes a start integer, end integer, fizz integer,
;; and buzz integer and produces a list from the start integer to the end integer where
;; each multiple of the fizz integer is replaced with 'fizz
;; each multiple of the buzz integer is replaced with 'buzz
;; each multiple of both the fizz and buzz integer is replaced with 'honk

;; Examples:
(check-expect (fizz-buzz 8 15 3 5) (list 8 'fizz 'buzz 11 'fizz 13 14 'honk))
(check-expect (fizz-buzz 0 14 2 14)
              (list 'honk 1 'fizz 3 'fizz 5 'fizz 7 'fizz 9 'fizz 11 'fizz 13 'honk))

;; fizz-buzz: Int Int Int Int -> (listof (anyof Int Sym)) 
;; Requires: start <= end, fizz different from buzz, fizz>0, buzz>0

(define (fizz-buzz start end fizz buzz)
  (cond
    [(= start end) (cons (fizz-buzz-helper end fizz buzz) empty)]
    [else (cons (fizz-buzz-helper start fizz buzz) (fizz-buzz (+ start 1) end fizz buzz))]))

;; (fizz-buzz-helper num fizz buzz) consumes an integer and based on the conditions laid out in
;; bizz-buzz outputs the corresponding symbol
;; example:
(check-expect (fizz-buzz-helper 15 3 5) 'honk)
(check-expect (fizz-buzz-helper 3 3 5) 'fizz)
(check-expect (fizz-buzz-helper 5 3 5) 'buzz)
(check-expect (fizz-buzz-helper 1 3 5) 1)

(define (fizz-buzz-helper num fizz buzz)
  (cond
  [(and (zero? (modulo num fizz)) (zero? (modulo num buzz))) 'honk]
  [(zero? (modulo num fizz)) 'fizz]
  [(zero? (modulo num buzz)) 'buzz]
  [else num]))

;; Tests:
(check-expect (fizz-buzz 0 0 1 2) (list 'honk))
(check-expect (fizz-buzz 0 0 69 1) (list 'honk))
(check-expect (fizz-buzz -4 6 3 5) (list -4 'fizz -2 -1 'honk 1 2 'fizz 4 'buzz 'fizz))
(check-expect (fizz-buzz 0 9 99 345) (list 'honk 1 2 3 4 5 6 7 8 9))

