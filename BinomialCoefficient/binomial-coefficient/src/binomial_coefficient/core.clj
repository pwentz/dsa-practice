(ns binomial-coefficient.core)

(defn quick-bc [n k]
  (reduce (fn [res i]
            (-> (* res (- n i))
                (/ (inc i)))) 1 (range k)))

(defn binomial-coefficient [n k]
  (let [bc-init (vec (repeat (inc n) (vec (repeat (inc n) 0))))
        bc (reduce #(-> (assoc-in %1 [%2 0] 1)
                        (assoc-in [%2 %2] 1)) bc-init (range (inc n)))]
    (get-in
      (reduce
        (fn [acc i]
          (reduce
            (fn [a j]
              (assoc-in a [i j] (+ (get-in a [(dec i) (dec j)])
                                   (get-in a [(dec i) j]))))
            acc
            (range 1 i)))
        bc
        (range 1 (inc n)))
      [n k])))
