(ns breadth-first-search.graph)

(defn mark-visited [graph source]
  (assoc graph source (assoc (graph source) :visited true)))

(defn add-node [nodes label]
  (assoc nodes label {:neighbors []}))

(defn add-edge [graph source neighbor]
  (let [neighbors-of (comp :neighbors graph)]
    (assoc graph source {:neighbors (conj (neighbors-of source) neighbor)})))
