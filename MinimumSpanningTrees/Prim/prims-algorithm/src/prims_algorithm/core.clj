(ns prims-algorithm.core)

(defn enqueue [queue edge]
  "Simple priority queue to sort by weight ascending"
  (sort-by :weight (-> queue vec (conj edge))))

(defn- get-edge-maps [graph parent vertices]
  (reduce
    #(conj %1
           {:vertex %2 :parent parent :weight (get-in graph [parent %2])})
    [] vertices))

(defn prims
  "Prims algorithm for minimum spanning trees. To start, pick any vertex:
   1. Make sure vertex has not been visited yet
   2. Add unvisited neighbors to (lowest weight) priority queue
   3. Add edge with current vertex and connecting/parent vertex to resulting sub-tree
   4. Repeat with next on priority queue"
  ([graph [{:keys [vertex weight parent]} & others] visited]
   (when vertex
     (if (contains? visited vertex)
       (recur graph others visited)
       (let [unvisited-edges (get-edge-maps graph vertex (remove #(contains? visited %) (-> vertex graph keys)))
             updated-queue (reduce enqueue others unvisited-edges)]
         (merge {#{parent vertex} weight} (prims graph updated-queue (conj visited vertex)))))))
  ([graph] (let [start (-> graph first key)
                 edges (prims graph (-> {:vertex start :weight 0}
                                        (cons (get-edge-maps graph start (-> start graph keys))))
                              #{start})]
             (assoc {} :edges edges :total (->> edges vals (reduce +))))))
