(ns all-permutations.core)

(def TRUE 1)
(def FALSE 0)

(defn- defaults [input]
  (-> input inc (repeat FALSE) vec))

(defn construct-solution [a k input]
  (let [in-perm (reduce #(assoc %1 (a %2) TRUE) (defaults input) (range k))]
    (reduce-kv (fn [acc idx c]
                 (if (or (= TRUE c) (zero? idx))
                   acc
                   (conj acc idx)))
               [] in-perm)))

(defn- process-solution [position-matchers]
  (mapv position-matchers (->> position-matchers count (range 1))))

(defn- backtrack [position-matchers k input acc]
  (if (= k input)
    (conj acc (process-solution position-matchers))
    (let [candidates (construct-solution position-matchers (inc k) input)]
      (reduce #(backtrack
                 (assoc position-matchers (inc k) (candidates %2))
                 (inc k)
                 input
                 %1)
             acc (range (count candidates))))))

(defn all-permutations [input]
  (backtrack (defaults input) 0 input []))
