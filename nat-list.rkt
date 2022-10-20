;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname nat-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; ***************************************************
;; Julien Liang (21006564)
;; CS 135 Fall 2022
;; Assignment 04, Problem 6
;; ***************************************************
;;

;;
;; a)
;;

;; (nat->list n) consumes a natrual number and returns a list of digits based on n

;; Examples:
(check-expect (nat->list 123456789) (list 9 8 7 6 5 4 3 2 1))
(check-expect (nat->list 125) (list 5 2 1))

;; nat->list: n -> Lst

(define (nat->list n)
  (cond
    [(zero? n) (list 0)]
    [else (non-zero n)]))

;; (non-zero n) does exactly what (nat->list n) does but is specialised for non-zero cases
;; example:
(check-expect (non-zero 561) (list 1 6 5))

(define (non-zero n)
  (cond
    [(zero? n) empty]
    [else (cons (* (- (/ n 10) (floor (/ n 10))) 10) (non-zero (floor (/ n 10))))]))

;; Tests:
(check-expect (nat->list 123) (list 3 2 1))
(check-expect (nat->list 0) (list 0))
(check-expect (nat->list 8848) (list 8 4 8 8))

;;
;; b)
;;

;; (list->nat a-list) consumes a list of digits and coverts it into a natural number

;; Examples:
(check-expect (list->nat (list 9 0 3 5 7 6 8)) 8675309)
(check-expect (list->nat (list 2 0 1)) 102)

;; list->nat: Lst -> (listof Nat)
;; Requires: rightmost item of list non-zero

(define (list->nat a-list)
  (cond
    [(empty? a-list) 0]
    [else (+ (first a-list) (* 10 (list->nat (rest a-list))))]))

;; Tests:
(check-expect (list->nat (list 0)) 0)
(check-expect (list->nat (list 1 2 3)) 321)
(check-expect (list->nat (list 0 0 7)) 700)
(check-expect (list->nat (list 4 8 9 1)) 1984)
(check-expect (list->nat (list 0 0 0 0 0)) 0)
