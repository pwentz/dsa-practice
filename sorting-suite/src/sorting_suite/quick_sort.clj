(ns sorting-suite.quick-sort)

(defn partitioning
  "Custom function to ensure partition in single pass.
  Passing accumulator as first arg to merge-with causes
  SOE, so initial order gets reversed in this implementation."
  ([acc n [x & xs]]
   (if x
     (recur (merge-with concat (cond (< x n) {:less [x]}
                                     (< n x) {:more [x]}
                                     :else {:eq [x]}) acc) n xs)
     acc))
  ([n c] (partitioning {} n c)))

(defn q-sort-custom [c]
  "Quick Sort implementation using random pivot selection
  and custom partitioning. Takes ~5 seconds when n = 100000"
  (if (< 1 (count c))
    (let [pivot (get (vec c) (rand-int (count c)))
          {:keys [less eq more]} (partitioning pivot c)]
      (lazy-cat
        (q-sort-custom less)
        eq
        (q-sort-custom more)))
    c))

(defn quick-sort [c]
  "Quick sort with random pivot and filter partitioning,
  take ~2 seconds when n = 100000"
  (if (< 1 (count c))
    (let [pivot (get (vec c) (rand-int (count c)))
          less (filter #(< % pivot) c)
          more (filter #(< pivot %) c)
          eq (filter #{pivot} c)]
      (lazy-cat
        (quick-sort less)
        eq
        (quick-sort more)))
    c))
