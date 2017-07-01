(ns insertion-sort.core)

;TODO: implement "right shift" insert
(defn insert [[x & xs :as c] elt]
  (if x
    (if (<= elt x)
      (cons elt c)
      (cons x (insert xs elt)))
    [elt]))

(defn insertion-sort
  "Takes head of input and passes to new sorted array
  to insert on first element larger than it. Mutable insertion
  sort 'shifts' left-pile elements in existing array to the right,
  making it effective against nearly sorted collections"
  ([sorted [x & xs]]
   (if x
     (insertion-sort (insert sorted x) xs)
     sorted))
  ([[x & xs]] (insertion-sort [x] xs)))
