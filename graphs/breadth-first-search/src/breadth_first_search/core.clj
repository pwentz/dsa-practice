(ns breadth-first-search.core)

(defn mark-visited [graph source]
  (assoc graph source (assoc (graph source) :visited true)))

(defn enqueue [queue & nodes]
  (apply conj (vec queue) nodes))

(defn add-node [nodes label]
  (assoc nodes label {:neighbors []}))

(defn add-edge [graph source neighbor]
  (let [neighbors-of (comp :neighbors graph)]
    (assoc graph source {:neighbors (conj (neighbors-of source) neighbor)})))

(defn breadth-first-search
  ([graph [curr & others] nodes]
   (if curr
     (let [unvisited (remove (comp :visited graph) (:neighbors curr)) ; add unvisited node-refs to explored
           unvisited-neighbors (map graph unvisited) ; add unvisited neighbors to queue
           updated-tree (reduce mark-visited graph (:neighbors curr))] ; update-tree to reflect edges as visited
       (recur
         updated-tree
         (apply enqueue others unvisited-neighbors)
         (apply conj nodes unvisited)))
     nodes))
  ([graph source] (breadth-first-search (mark-visited graph source) [(graph source)] [source])))
