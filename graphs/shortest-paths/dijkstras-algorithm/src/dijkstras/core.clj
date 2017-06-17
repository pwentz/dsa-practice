(ns dijkstras.core)

(defn lowest-cost-node [costs visited]
  (let [visited? (partial contains? visited)]
    (first (remove visited? (sort-by costs (keys costs))))))

(defn build-solution [mini-graph mini-parents start end]
  (let [node (mini-parents end)]
    (if (= start node)
      {#{node end} ((mini-graph node) end)}
      (merge {#{node end} ((mini-graph node) end)} (build-solution mini-graph mini-parents start node)))))

(defn dijkstra
  "Dijkstra's shortest path algorithm for weighted undirected (or directed) graphs.
   Three main data structures are required. First is the graph/adjacency list itself.
   Second is the costs map that contains lowest current cost to get to node. Last is
   the parents map, whose values represent the direct parent of node.
    1. Grab lowest cost node that has not been visited
    2. Go through each of this node's neighboring edges and add the cost of current node (from costs) to cost of edge
    3. If any of these new values are lower than said neighbors current cost as reflected in costs...
       3a. Update costs map to reflect new, lower value of neighbor
       3b. Update parents map so that lower cost neighbor's parent is current node
    4. Add current node to visited collection and repeat."
  ([graph costs parents visited start]
   (if-let [node (lowest-cost-node costs visited)] ; step 1
     (let [neighbors (dissoc (graph node) start)
           neighbor-costs (merge-with + neighbors (zipmap (keys neighbors) (repeat (costs node)))) ; step 2
           updated-costs (merge-with min neighbor-costs costs) ; step 3a
           updated-neighbors (remove #(= (costs %) (updated-costs %)) (keys updated-costs))
           updated-parents (merge parents (zipmap updated-neighbors (repeat node)))] ; step 3b
       (recur graph updated-costs updated-parents (conj visited node) start)) ; step 4
     parents))
  ([graph start end] (let [start-neighbors (zipmap (keys (graph start)) (repeat start))
                           parents (dijkstra graph (graph start) start-neighbors #{} start)
                           edges (build-solution graph parents start end)]
                       (assoc {} :edges edges :total (reduce + (vals edges))))))
