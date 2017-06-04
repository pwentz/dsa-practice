(ns sorting-suite.insertion-sort)

(defn insert [[x & xs :as c] elt]
  (if x
    (if (<= elt x)
      (cons elt c)
      (cons x (insert xs elt)))
    [elt]))

(defn insertion-sort
  "Takes head of input and passes to new sorted array
  to insert on first element larger than it."
  ([sorted [x & xs]]
   (if x
     (insertion-sort (insert sorted x) xs)
     sorted))
  ([[x & xs]] (insertion-sort [x] xs)))
