(ns fibonacci-numbers.dp)

(defn fibonacci [n]
  (if (zero? n)
    0
    (apply + (reduce
               (fn [[back-two back-one :as acc] _]
                 (assoc acc 0 back-one 1 (apply + acc)))
               [0 1]
               (range 2 n)))))
