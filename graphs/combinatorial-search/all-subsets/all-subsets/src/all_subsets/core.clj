(ns all-subsets.core)

(def CANDIDATES [true false])
(def N_CANDIDATES 2)

(defn- process-solution [position-matchers]
  (reduce (fn [acc idx]
            (if (true? (position-matchers idx))
              (conj acc idx)
              acc))
          #{} (range 1 (count position-matchers))))

(defn- backtrack [position-matchers k input acc]
  (if (= k input)
    (conj acc (process-solution position-matchers))
    (reduce (fn [a i]
              (let [matchers (assoc position-matchers (inc k) (CANDIDATES i))]
                (backtrack matchers (inc k) input a)))
            acc (range N_CANDIDATES))))

(defn all-subsets [n]
  (backtrack (->> false (repeat (inc n)) vec) 0 n #{}))
