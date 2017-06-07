(ns breadth-first-search.core)

(def graph-requirements
  [#(not-empty %)
   #(every? :edges (vals %))
   #(every? vector? (map :edges (vals %)))])

(defn add-node [nodes label]
  (assoc nodes label {:edges []}))

(defn add-edge [graph source neighbor]
  {:pre [(every? #(% graph) graph-requirements)]}
  (let [source-node (get graph source)
        source-edges (:edges source-node)]
    (assoc graph source {:edges (conj source-edges neighbor)})))
