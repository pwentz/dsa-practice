(ns sorting-suite.selection-sort)

(defn find-lowest
  ([low [x & xs]]
   (if x
     (if (< x low)
       (find-lowest x xs)
       (find-lowest low xs))
     low))
  ([[x & _ :as c]] (find-lowest x c)))

(defn selection-sort [[x & xs :as nums]]
  (when x
    (let [xs (vec xs)
          lowest (find-lowest x nums)]
      (if (not= x lowest)
        (cons lowest (selection-sort (assoc xs (.indexOf xs lowest) x)))
        (cons x (selection-sort xs))))))
