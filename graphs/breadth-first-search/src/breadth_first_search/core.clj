(ns breadth-first-search.core
  (:require [graph-utils :refer [mark-visited]]))

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
