;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname range) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;
;; a)
;;

;; (in-range a b numlist) consumes two numbers a and b and a list of numbers numlist, producing
;; the number of elements in the list that are between a and b (inclusive)

;; Examples:
(check-expect (in-range 1 10 (list 1 2 3 4 5 6 7 8 9 10)) 10)
(check-expect (in-range 1 10 (list 11 11 -99)) 0)

;; in-range: Num Num Lst -> Nat
;; Requires: numlist to contain numbers only
(define (in-range a b numlist)
  (cond
    [(empty? numlist) 0]
    [else (+ (cond
               [(<= (min a b) (first numlist) (max a b)) 1]
               [else 0])
             (in-range a b (rest numlist)))]))

;; Tests: 
(check-expect (in-range -1 -99 (list -45 0 9)) 1)
(check-expect (in-range 0 0 (list 0)) 1)
(check-expect (in-range 1 999 (list )) 0)
(check-expect (in-range -33 pi (list 0 0 0 pi 9)) 4)
(check-expect (in-range -9 9 (list e pi 0 1 2 9)) 6)
(check-expect (in-range 0 9 (list )) 0)

;;
;; b)
;;

;; (spread numlist) consumes a non-empty list of numbers and produces the non-negative difference
;; between the max and min element in the list

;; Examples:
(check-expect (spread (list 1 2 3)) 2)
(check-expect (spread (list -4 9 0)) 13)
(check-expect (spread (list 0 0 0)) 0)

;; spread: Lst -> Num
;; Requires: numlist to contain numbers only and be non-empty
(define (spread numlist)
  (abs (- (listmax numlist) (listmin numlist))))

;; (listmax numlist) consumes a non-empty list of numbers and produces the largest number
;; Example:
(check-expect (listmax (list 1 2 3)) 3)

(define (listmax numlist)
  (cond
    [(empty? (rest numlist)) (first numlist)]
    [(< (first numlist) (first (rest numlist))) (listmax (rest numlist))]
    [else (listmax (cons (first numlist) (rest (rest numlist))))]))

;; (listmax numlist) consumes a non-empty list of numbers and produces the smallest number
;; Example: 
(check-expect (listmin (list 1 2 3)) 1)

(define (listmin numlist)
  (cond
    [(empty? (rest numlist)) (first numlist)]
    [(> (first numlist) (first (rest numlist))) (listmin (rest numlist))]
    [else (listmin (cons (first numlist) (rest (rest numlist))))]))

;; Tests:
(check-expect (spread (list 0 0)) 0)
(check-expect (spread (list 0)) 0)
(check-expect (spread (list 1 2 3 4 5 6 7 8 9)) 8)
(check-expect (spread (list -2 -9)) 7)
(check-expect (spread (list -2 -2 -2 -2)) 0)
(check-expect (spread (list 1)) 0)
(check-expect (spread (list 999 -1 0 0 0)) 1000)
(check-expect (spread (list 0 3 0 9 0)) 9)
