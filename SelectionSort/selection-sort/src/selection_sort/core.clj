(ns selection-sort.core)

(defn find-lowest-idx
  ([curr low c]
   (let [x (get c curr)
         lowest (get c low)]
     (if x
       (if (< x lowest)
         (find-lowest-idx (inc curr) curr c)
         (find-lowest-idx (inc curr) low c))
       low)))
  ([c] (find-lowest-idx 0 0 c)))

(defn selection-sort [c]
  "Original SS implementation mutates values of initial array reference.
   Since this is a functional solution, immutability is favored.
   Tradeoff for immutability is stack space taken by recursive calls."
  (when (seq c)
    (let [[x & xs :as nums] (vec c)
          low-idx (find-lowest-idx nums)
          lowest (get nums low-idx)]
      (if (not= x lowest)
        (cons lowest (selection-sort (rest (assoc nums low-idx x))))
        (cons x (selection-sort xs))))))
