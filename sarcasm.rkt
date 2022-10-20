;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname sarcasm) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;;
;; a)
;;

;; pair-listof-X-template: Lst -> Any
(define (pair-listof-X-template pair-listof-X)
  (cond
    [(empty? pair-listof-X) ...]
    [(empty? (rest pair-listof-X)) ...]
    [(cons? (first (rest pair-listof-X)))
     (... (cons (first pair-listof-X) (cons (first (rest pair-listof-X)) empty))
      ... (pair-listof-X-template (rest (rest pair-listof-X))) ...)]))




;;
;; b)
;;

;; (sarcastic sentence) consumes a string and produces that string in sarcasm case

;; Examples:
(check-expect (sarcastic "EMOTIONAL DAMAGE") "EmOtIoNaL DaMaGe")
(check-expect (sarcastic "BeijingCorn") "BeIjInGcOrN")

;; sarcastic: Str -> Str
(define (sarcastic sentence)
  (cond
    [(= 0 (string-length sentence)) ""]
    [(= 1 (string-length sentence)) (string-upcase sentence)]
    [else (string-append (string-upcase (substring sentence 0 1))
                         (string-downcase (substring sentence 1 2))
                         (sarcastic (substring sentence 2 (string-length sentence))))]))

;; Tests:
(check-expect (sarcastic "") "")
(check-expect (sarcastic "$%^&*(*&^%") "$%^&*(*&^%")
(check-expect (sarcastic "奉天靖难") "奉天靖难")
(check-expect (sarcastic "sArCaSm") "SaRcAsM")
(check-expect (sarcastic "These are words") "ThEsE ArE WoRdS")
