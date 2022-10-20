;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname hot-dog) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; ***************************************************
;; Julien Liang (21006564)
;; CS 135 Fall 2022
;; Assignment 04, Problem 3
;; ***************************************************
;;

;;
;; a)
;;

;; (contains-hot-dog? list) consumes a list of any type and produces true if it contains the symbol
;; 'hot-dog and false otherwise

;; Examples:
(check-expect (contains-hot-dog? (list 'pizza 'hot-dog 'hamburger)) true)
(check-expect (contains-hot-dog? (list )) false)
(check-expect (contains-hot-dog? (list 'pizza 'hot-Dog 'hamburger)) false)

;; contains-hot-dog?: Lst -> Bool
(define (contains-hot-dog? any-list)
  (cond
    [(empty? any-list) false]
    [(is-hot-dog? (first any-list)) true]
    [else (contains-hot-dog? (rest any-list))]))

;; (is-hot-dog? item) consumes any input and determines whether or not it is 'hot-dog
;; example:
(check-expect (is-hot-dog? 'hot-dog) true)
(check-expect (is-hot-dog? "hotdog") false)
(define (is-hot-dog? item)
  (and (symbol? item) (symbol=? item 'hot-dog)))

;; Tests:
(check-expect (contains-hot-dog? (list )) false)
(check-expect (contains-hot-dog? (list 'hot-dog)) true)
(check-expect (contains-hot-dog? (list 'hot-dog 'hot-dog 'hot-dog)) true)
(check-expect (contains-hot-dog? (list 'monkey 'banana "Boonie Bears")) false)
(check-expect (contains-hot-dog? (list 'hot-dog 'something-else 82349143)) true)
(check-expect (contains-hot-dog? (list 'smtg-random 'hotdog (list (list (list 'hot-dog))))) false)
(check-expect (contains-hot-dog? (list 'hot-dog "hotdog" 1321)) true)

;;
;; b)
;;

;; (spells-hot-dog? a-string) consumes a string and produces true if the letters required to spell
;; "hot-dog" are present and false otherwise

;; Examples:
(check-expect (spells-hot-dog? "Hot Dog!") true)
(check-expect (spells-hot-dog? "abcdefgh    toooo") true)
(check-expect (spells-hot-dog? "hot-dog") false)
(check-expect (spells-hot-dog? "colddog") false)

;; spells-hot-dog?: Str -> Bool
(define (spells-hot-dog? a-string)
  (and
   (>= (charcount (string-downcase a-string) #\h) 1)
   (>= (charcount (string-downcase a-string) #\o) 2)
   (>= (charcount (string-downcase a-string) #\t) 1)
   (>= (charcount (string-downcase a-string) #\ ) 1)
   (>= (charcount (string-downcase a-string) #\d) 1)
   (>= (charcount (string-downcase a-string) #\g) 1)))

;; (charcount list-of-string char) consumes a string->list and returns how many of character char
;; there are
;; example:
(check-expect (charcount-list (list #\r #\e #\e #\e) #\e) 3)
(define (charcount-list list-of-string char)
  (cond
    [(empty? list-of-string) 0]
    [else (+ (cond [(char=? char (first list-of-string)) 1]
                   [else 0])
             (charcount-list (rest list-of-string) char))]))

;; (charcount a-string char) consumes a string and returns how many of character char
;; there are
;;example:
(check-expect (charcount "reee" #\e) 3)
(define (charcount a-string char)
  (charcount-list (string->list a-string) char))

;; Tests:
(check-expect (spells-hot-dog? "") false)
(check-expect (spells-hot-dog? "hotdggggg") false)
(check-expect (spells-hot-dog? "this is a hotdog") true)
(check-expect (spells-hot-dog? "tHiS iS a HoTdOg") true)
(check-expect (spells-hot-dog? "HoT dOg") true)
(check-expect (spells-hot-dog? "h西O塞t山D前o白G鹭 飞") true)
(check-expect (spells-hot-dog? " ") false)
(check-expect (spells-hot-dog? ".") false)