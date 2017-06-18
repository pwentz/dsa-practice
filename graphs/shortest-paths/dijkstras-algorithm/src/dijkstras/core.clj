(ns dijkstras.core)

(defn lowest-cost-node [costs visited]
  (let [visited? (partial contains? visited)]
    (->> costs keys (sort-by costs) (remove visited?) first)))

(defn build-shortest-path [graph parents start curr]
  (let [node (parents curr)]
    (if (= start node)
      {#{node curr} ((graph node) curr)}
      (merge {#{node curr} ((graph node) curr)} (build-shortest-path graph parents start node)))))

(defn dijkstra
  "Dijkstra's shortest path algorithm for weighted undirected (or directed) graphs.
   Three main data structures are required. First is the graph/adjacency list.
   Second is the costs map that contains lowest current cost to get to node. Last is
   the parents map, whose values represent the direct parent of node in shortest path.
    1. Grab lowest cost node that has not been visited
    2. Go through each of this node's neighboring edges and add the cost of current node (from costs) to cost of edge
    3. If any of these new values are lower than said neighbors current cost as reflected in costs...
       3a. Update costs map to reflect new, lower value of neighbor
       3b. Update parents map so that lower cost neighbor's parent is current node
    4. Add current node to visited collection and repeat 1-4.
    5. Traverse parents struct starting with destination and ending with starting point"
  ([graph costs parents visited]
   (if-let [node (lowest-cost-node costs visited)] ; step 1
     (let [neighbors (merge-with + (graph node) (zipmap (-> node graph keys) (-> node costs repeat))) ; step 2
           updated-costs (merge-with min neighbors costs) ; step 3a
           neighbors-to-update (remove #(= (costs %) (updated-costs %)) (keys updated-costs))
           updated-parents (merge parents (zipmap neighbors-to-update (repeat node)))] ; step 3b
       (recur graph updated-costs updated-parents (conj visited node))) ; step 4
     parents))
  ([graph start end] (let [start-neighbors (zipmap (-> start graph keys) (repeat start))
                           parents (dijkstra (dissoc graph start) (graph start) start-neighbors #{start})
                           edges (build-shortest-path graph parents start end)]
                       (assoc {} :edges edges :total (reduce + (vals edges))))))
