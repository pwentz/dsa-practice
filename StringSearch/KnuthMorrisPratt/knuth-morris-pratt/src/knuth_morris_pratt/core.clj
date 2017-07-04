(ns knuth-morris-pratt.core
  (:require [knuth-morris-pratt.z-array :refer [z-array]]))

(defn- suffix-prefix [p]
  (let [zeta (z-array p)]
    (reduce
      (fn [acc i]
        (assoc acc (-> (zeta i) (+ i) dec) (zeta i)))
      (-> (count zeta) (repeat 0) vec)
      (->> zeta count (range 1) reverse))))

(defn knuth-morris-pratt
  ([text pattern] (knuth-morris-pratt text pattern 0 0 [] (suffix-prefix pattern)))
  ([text pattern text-idx pattern-idx indices suff-pre]
   (if (< (-> (count pattern) (- pattern-idx) dec (+ text-idx)) (count text))
     (if (and (< pattern-idx (count pattern)) (= (get pattern pattern-idx) (get text text-idx)))
       (recur text pattern (inc text-idx) (inc pattern-idx) indices suff-pre)
       (let [new-indices (if (= pattern-idx (count pattern)) (conj indices (- text-idx pattern-idx)) indices)]
         (if (zero? pattern-idx)
           (recur text pattern (inc text-idx) pattern-idx new-indices suff-pre)
           (recur text pattern text-idx (suff-pre (dec pattern-idx)) new-indices suff-pre))))
     indices)))
