(ns minimum-spanning-paths.core)

(defn enqueue [queue edge]
  (sort-by :weight (conj (vec queue) edge)))

(defn add-edge [graph source neighbor weight]
  (merge-with merge graph {source {neighbor weight}} {neighbor {source weight}}))

(defn prims
  ([graph [curr & others] visited {edges :edges :as res}]
   (if curr
     (if (contains? visited (:v curr))
       (recur graph others visited res)
       (let [neighbors (keys (graph (:v curr)))
             unvisited (map #(into {} [[:v %] [:parent (:v curr)] [:weight ((graph (:v curr)) %)]]) (remove #(contains? visited %) neighbors))
             new-res (if (:parent curr) (assoc res :edges (merge edges {[(:parent curr) (:v curr)] (:weight curr)})) res) ]
         (recur graph (reduce enqueue others unvisited) (conj visited (:v curr)) new-res)))
     (merge res {:total (reduce + (vals edges))})))
  ([graph] (prims graph [{:v (key (first graph)) :weight 0}] #{} {:edges {}})))
