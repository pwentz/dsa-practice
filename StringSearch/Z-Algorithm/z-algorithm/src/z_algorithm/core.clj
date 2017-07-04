(ns z-algorithm.core)

(defn- z-expand [s k]
  (let [sub (subs s k)]
    (map
      (partial get sub)
      (take-while
        #(= (get sub %) (get s %))
        (range (count sub))))))

(defn- z-array
  ([s] (z-array s (-> (count s) (repeat 0) vec) 0 0 1))

  ([s zeta left right k]
   (letfn [(add-matching-chars [zeta s k right]
             (let [added-members (z-expand s k)
                   upper-bounds (+ right (count added-members))]
               (z-array s (assoc zeta k (- upper-bounds k)) k (dec upper-bounds) (inc k))))]

     (if (< k (count s))
       (if (< right k)
         (add-matching-chars zeta s k k)
         (let [prefix-subs-len (zeta (- k left))
               remaining-zbox-spaces (inc (- right k))]
           (if (< prefix-subs-len remaining-zbox-spaces)
             (recur s (assoc zeta k prefix-subs-len) left right (inc k))
             (add-matching-chars zeta s k right))))
       zeta))))

(defn z-algorithm [text pattern]
  (let [s (str pattern "$" text )
        z-arr (z-array s)]
    (reduce-kv
      (fn [acc idx x]
        (if (= x (count pattern))
          (conj acc (- idx (-> pattern count inc)))
          acc))
      []
      z-arr)))
