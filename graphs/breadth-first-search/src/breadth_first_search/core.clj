(ns breadth-first-search.core)

(defn mark-visited [graph source]
  (assoc graph source (assoc (graph source) :visited true)))

(defn add-node [nodes label]
  (assoc nodes label {:neighbors []}))

(defn add-edge [graph source neighbor]
  (let [neighbors-of (comp :neighbors graph)]
    (assoc graph source {:neighbors (conj (neighbors-of source) neighbor)})))

(defn get-unvisited-and-update [graph]
  (juxt (partial remove (comp :visited graph))
        (partial reduce mark-visited graph)))

(defn breadth-first-search
  ([graph [curr & others] nodes]
   (if curr
     (let [[unvisited new-graph] ((get-unvisited-and-update graph) (-> curr graph :neighbors))]
       (recur new-graph (concat others unvisited) (concat nodes unvisited)))
     nodes))
  ([graph source] (breadth-first-search (mark-visited graph source) [source] [source])))
