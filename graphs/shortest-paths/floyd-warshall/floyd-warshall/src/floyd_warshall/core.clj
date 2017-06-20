(ns floyd-warshall.core)

(def inf Long/MAX_VALUE)

(defn- vertices [graph]
  (let [all-vertices (apply conj (-> graph keys set) (mapcat (comp keys graph) (keys graph)))]
    (sort-by (comp - count graph) all-vertices)))

(defn create-row [graph vertex]
  (let [neighbors (graph vertex)
        positions (zipmap (range) (vertices graph))]
    (map (fn [idx]
           (if (= vertex (positions idx))
             0
             (get neighbors (positions idx) inf)))
         (-> positions count range))))

(defn adjacency-matrix [graph]
  (reduce #(conj %1 (create-row graph %2)) [] (vertices graph)))

(defn parent-matrix [distances]
  (letfn [(parent-row [row-idx row]
            (map #(cond (zero? %) nil
                        (< % inf) row-idx
                        :else %) row))]
    (map-indexed parent-row distances)))
