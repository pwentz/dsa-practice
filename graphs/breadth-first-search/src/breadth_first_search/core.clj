(ns breadth-first-search.core)

(defn mark-visited [tree source]
  (let [node (get tree source)]
    (assoc tree source (assoc node :visited true))))

(defn enqueue [queue & nodes]
  (apply conj queue nodes))

(defn dequeue [queue]
  (first queue))

(defn add-node [nodes label]
  (assoc nodes label {:edges []}))

(defn add-edge [graph source neighbor]
  (let [source-node (get graph source)
        source-edges (:edges source-node)]
    (assoc graph source {:edges (conj source-edges neighbor)})))

(defn breadth-first-search
  ([tree source queue nodes]
   (let [current (dequeue queue)]
     (if current
       (let [neighbors (map #(get tree %) (:edges current)) ; get neighbor nodes from tree
             unvisited-nodes (remove :visited neighbors) ; add unvisited neighbors to queue
             unvisited-keys (remove #(:visited (get tree %)) (:edges current)) ; add unvisited node-refs to explored
             updated-tree (reduce mark-visited tree (cons source (:edges current)))] ; update-tree to reflect current and edges as visited
         (breadth-first-search updated-tree (first unvisited-keys) (apply enqueue (vec (rest queue)) unvisited-nodes) (apply conj nodes unvisited-keys)))
       nodes)))
  ([tree source] (breadth-first-search tree source [(get tree source)] [source])))
