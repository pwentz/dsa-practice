(ns depth-first-search.core
  (:require [graph-utils :refer [mark-visited]]))

(defn depth-first-search
  ([graph [curr & to-explore] explored]
   (if curr
     (if (true? (-> curr graph :visited))
       ; if visited before, backtrack...
       (recur graph to-explore explored)
       (let [unvisited (remove (comp :visited graph) (-> curr graph :neighbors))]
         ; otherwise, place unvisited on top of stack
         (recur
           (mark-visited graph curr) (concat unvisited to-explore) (conj explored curr))))
     explored))
  ([graph source] (depth-first-search graph [source] [])))
