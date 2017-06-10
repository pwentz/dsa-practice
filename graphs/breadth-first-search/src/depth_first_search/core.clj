(ns depth-first-search.core
  (:require [graph-utils :refer [mark-visited]]))

(defn depth-first-search
  ([graph [curr & others] nodes]
   (if curr
     (if (true? (-> curr graph :visited)) ; if visited before, backtrack...
       (recur graph others nodes)
       (let [unvisited (remove (comp :visited graph) (-> curr graph :neighbors))]
         (recur ; otherwise, place unvisited on top of stack
           (mark-visited graph curr)
           (concat unvisited others)
           (conj nodes curr))))
     nodes))
  ([graph source] (depth-first-search graph [source] [])))
