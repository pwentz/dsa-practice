(ns sorting-suite.merge-sort)

(defn merging
  ([acc [l & ls :as left] [r & rs :as right]]
   (cond (and l r) (cond (< l r) (recur (conj acc l) ls right)
                         (< r l) (recur (conj acc r) left rs)
                         :else (recur (conj acc l r) ls rs))
         l (recur (conj acc l) ls right)
         r (recur (conj acc r) left rs)
         :else acc))
  ([left right] (merging [] left right)))

(defn merge-sort [nums]
  (if (< 1 (count nums))
    (let [middle (-> nums count (/ 2) Math/floor int)
          [left right] ((juxt take drop) middle nums)]
      (merging (merge-sort left) (merge-sort right)))
    nums))

; ms [2 1 3]
  ; ms [2]
  ; merging [2]...
    ; ms [1 3]
      ; merging [1] [3]
      ; [1 3]
  ; merging [2] [1 3]
; [1 2 3]
