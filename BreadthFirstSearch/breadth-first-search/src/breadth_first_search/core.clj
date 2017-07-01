(ns breadth-first-search.core
  (:require [breadth-first-search.graph :refer [mark-visited]]))

(def get-unvisited-and-update
  (juxt #(remove (comp :visited %1) %2)
        #(reduce mark-visited %1 %2)))

(defn breadth-first-search
  ([graph [curr & to-explore] explored]
   (if curr
     (let [[unvisited new-graph] (get-unvisited-and-update graph (-> curr graph :neighbors))]
       (recur new-graph (concat to-explore unvisited) (concat explored unvisited)))
     explored))
  ([graph source] (breadth-first-search (mark-visited graph source) [source] [source])))
