(ns floyd-warshall.core)

(def inf Long/MAX_VALUE)

(defn- get-vertices [graph]
  (distinct (concat (keys graph) (mapcat (comp keys graph) (keys graph)))))

(defn create-row [graph vertex]
  (let [neighbors (graph vertex)
        positions (zipmap (range) (get-vertices graph))]
    (mapv (fn [idx]
            (if (= vertex (positions idx))
              0
              (get neighbors (positions idx) inf)))
          (-> positions count range))))

(defn adjacency-matrix [graph]
  (reduce #(conj %1 (create-row graph %2)) [] (get-vertices graph)))

(defn parent-matrix [distances]
  (letfn [(parent-row [row-idx row]
            (mapv #(cond (zero? %) nil
                         (< % inf) row-idx
                         :else %) row))]
    (vec (map-indexed parent-row distances))))

(defn floyd-warshall
  ([distances intermediate-idx start-idx end-idx]
   (let [current-best (get-in distances [start-idx end-idx])
         start-to-intermediate (get-in distances [start-idx intermediate-idx])
         intermediate-to-end (get-in distances [intermediate-idx end-idx])
         new-cost (if (or (= inf start-to-intermediate) (= inf intermediate-to-end)) inf (+ start-to-intermediate intermediate-to-end))]
     (if (< new-cost current-best)
       (assoc-in distances [start-idx end-idx] new-cost)
       distances)))
  ([distances intermediate-idx start-idx]
   (reduce #(floyd-warshall %1 intermediate-idx start-idx %2) distances (-> distances count range)))
  ([distances intermediate-idx]
   (reduce #(floyd-warshall %1 intermediate-idx %2) distances (-> distances count range)))
  ([graph] (let [distances (adjacency-matrix graph)]
             (reduce floyd-warshall distances (-> distances count range)))))
