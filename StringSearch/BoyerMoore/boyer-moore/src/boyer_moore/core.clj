(ns boyer-moore.core)

(defn- index-from
  "Right to left comparison between pattern characters
   and string characters"
  [s s-idx p p-idx]
  (if (pos? p-idx)
    (when (= (get p p-idx) (get s s-idx))
      (recur s (dec s-idx) p (dec p-idx)))
    s-idx))

(defn- skip-table
  ([s] (skip-table s (dec (count s))))
  ([[chr & more] n]
   (when chr
     (merge {chr n} (skip-table more (dec n))))))

(defn boyer-moore
  ([s p]
   (let [p-end (dec (count p))]
     (if (< 0 p-end (count s))
       (boyer-moore p-end s p-end p (skip-table p))
       -1)))

  ([curr-idx s p-end p skips]
   (if-let [source (get s curr-idx)]
     (if (= (last p) source)
       (if-let [pattern-idx (index-from s curr-idx p p-end)]
         pattern-idx
         (recur (inc curr-idx) s p-end p skips))
       (recur (+ curr-idx (get skips source p-end)) s p-end p skips))
     -1)))
