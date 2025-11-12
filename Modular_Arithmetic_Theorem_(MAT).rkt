;; Simplifies the given number to its congruence class of the given mod
;; simplify: Int Nat -> Nat
(define (simplify x m)
  (cond
    [(zero? (remainder x m)) 0]
    [(> x 0) (remainder x m)]
    [else (+ x (* m (+ 1 (quotient (abs x) m))))]))

;; Finds a particular solution to the given linear diophantine equation
;; get-particular Int Int Int Int Int Int Int Int -> Int
(define (get-particular x1 y1 r1 q1 x2 y2 r2 q2)
  (cond
    [(zero? r2) x1]
    [else
     (get-particular x2 y2 r2 q2
                  (- x1 (* (quotient r1 r2) x2))
                  (- y1 (* (quotient r1 r2) y2))
                  (remainder r1 r2)
                  (quotient r1 r2))]))

;; Consumes a particular solution and gives a list of all possible congruence class solutions
;; mk-sol-list: Nat Nat Nat Nat -> (listof Nat)
(define (mk-sol-list good-sol d m n)
  (cond
    [(= n d) empty]
    [else (cons (+ good-sol (* n (/ m d))) (mk-sol-list good-sol d m (add1 n)))]))

;; Finds all possible congruence class solutions to a linear diophantine equation
;; primary-solutions: Int Int Nat -> (listof Nat)
(define (primary-solutions a c m)
  (cond
    [(or (= a m) (zero? (simplify a m)))
     (cond
       [(zero? (remainder c m)) (mk-sol-list 0 (gcd a m) m 0)]
       [else "No real solutions exist"])]
    [(not (zero? (remainder c (gcd a m)))) "No real solutions exist"]
    [(> a m) (mk-sol-list (simplify (* (get-particular 1 0 a 0 0 1 m 0) (/ c (gcd a m))) m) (gcd a m) m 0)]
    [(< a m) (mk-sol-list (simplify (* (get-particular 0 1 m 0 1 0 a 0) (/ c (gcd a m))) m) (gcd a m) m 0)]))

;; Simplifies each element of the consumed list to its congruence class of the given mod
;; finalize: (anyof Str (listof Int)) Nat -> (anyof Str (listof Int))
(define (finalize lst m)
  (cond
    [(string? lst) lst]
    [else (cond
            [(empty? lst) empty]
            [else (cons (simplify (first lst) m) (finalize (rest lst) m))])]))

;; Consumes a linear diophantine equation of the for ax congruent to c (mod m)
;; and produces all the possible congruent class solutions
;; mat: Int Int Nat -> (listof Nat)
(define (mat a c m) (finalize (primary-solutions a c m) m))





