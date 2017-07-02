(ns fibonacci-numbers.core)

(defn fibonacci [n]
  (case n
    0 0
    1 1
    (+ (fibonacci (dec n)) (fibonacci (- n 2)))))
