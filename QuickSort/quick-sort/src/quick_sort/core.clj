(ns quick-sort.core
  (:require [clojure.core.reducers :as r]))

(defn partitioning [n c]
  "Custom partition function yields slightly faster results
  than q-sort with built in filter functions."
  (loop [[x & xs] c
         less []
         eq []
         greater []]
    (if (nil? x)
      (conj [less] eq greater)
      (cond (< x n) (recur xs (conj less x) eq greater)
            (< n x) (recur xs less eq (conj greater x))
            :else (recur xs less (conj eq x) greater)))))

(defn q-sort-custom [c]
  "Quick Sort implementation using random pivot selection
  and custom partitioning. Takes ~1.75 seconds when n = 100000"
  (if (< 1 (count c))
    (let [pivot (get (vec c) (rand-int (count c)))
          [less eq more] (partitioning pivot c)]
      (lazy-cat (q-sort-custom less) eq (q-sort-custom more)))
    c))

(defn quick-sort [c]
  "Quick sort with random pivot and (reducible) filter partitioning,
  take ~1 seconds when n = 100000"
  (if (< 1 (count c))
    (let [pivot (get (vec c) (rand-int (count c)))
          less (into [] (r/filter #(< % pivot) c))
          more (into [] (r/filter #(< pivot %) c))
          eq (into [] (r/filter #{pivot} c))]
      (lazy-cat
        (quick-sort less)
        eq
        (quick-sort more)))
    c))
