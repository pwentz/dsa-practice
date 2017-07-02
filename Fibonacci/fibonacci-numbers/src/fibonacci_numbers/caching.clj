(ns fibonacci-numbers.caching)

(def f (atom []))

(defn fibonacci-caching [n]
  (when (neg? (@f n))
    (do
      (swap! f assoc n (+ (fibonacci-caching (dec n)) (fibonacci-caching (- n 2))))))
  (@f n))

(defn driver [n]
  (do
    (reset! f (vec (concat [0 1] (repeat (dec n) -1)))))
  (fibonacci-caching n))
