(ns floyd-warshall.core)

(def inf Long/MAX_VALUE)

(defn get-vertices [graph]
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
  ([graph] (let [distances (adjacency-matrix graph)
                 parents (parent-matrix distances)]
             (reduce floyd-warshall {:distances distances :parents parents} (-> distances count range))))
  ([payload intermediate-idx]
   (reduce #(floyd-warshall %1 intermediate-idx %2) payload (-> payload :distances count range)))
  ([payload intermediate-idx start-idx]
   (reduce #(floyd-warshall %1 intermediate-idx start-idx %2) payload (-> payload :distances count range)))
  ([{:keys [distances parents] :as payload} intermediate-idx start-idx end-idx]
   (let [current-best (get-in distances [start-idx end-idx])
         start-to-intermediate (get-in distances [start-idx intermediate-idx])
         intermediate-to-end (get-in distances [intermediate-idx end-idx])
         new-cost (if (or (= inf start-to-intermediate) (= inf intermediate-to-end)) inf (+ start-to-intermediate intermediate-to-end))]
     (if (< new-cost current-best)
       (assoc payload :distances (assoc-in distances [start-idx end-idx] new-cost)
                      :parents (assoc-in parents [start-idx end-idx] intermediate-idx))
       payload))))

(defn build-path [graph start end distance-row parent-row]
  (let [indices (zipmap (get-vertices graph) (range))
        vertices (zipmap (range) (get-vertices graph))
        predecessor-idx (get parent-row (indices end))
        predecessor (get vertices predecessor-idx)]
    (if (= predecessor-idx (indices start))
      {#{start end} (get-in graph [start end])}
      (merge {#{end predecessor} (get-in graph [predecessor end])} (build-path graph start predecessor distance-row parent-row)))))

(defn build-shortest-path [paths distances-row parent-row graph current-idx]
  (let [positions (zipmap (range) (get-vertices graph))
        start (positions current-idx)]
    (reduce (fn [acc idx]
              (if (= idx current-idx)
                acc
                (assoc-in acc [start (positions idx)] (build-path graph start (positions idx) distances-row parent-row))))
            (assoc paths start {}) (->> positions count (range current-idx)))))

(defn floyd-warshall-graph [graph]
  (let [{:keys [distances parents]} (floyd-warshall graph)]
    (reduce-kv #(build-shortest-path %1 %3 (parents %2) graph %2) {} distances)))
