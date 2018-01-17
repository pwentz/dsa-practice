(ns depth-first-search.core
  (:require [depth-first-search.graph :as g]))

(defn depth-first-search
  "Implementation uses an explicit stack to keep track of those
   next to get visited."
  ([graph [curr & to-explore] explored]
   (if curr
     (if (true? (get-in graph [curr :visited]))
       ; if visited before, backtrack...
       (recur graph to-explore explored)
       (let [unvisited (remove (comp :visited graph) (get-in graph [curr :neighbors]))]
         ; otherwise, place unvisited on top of stack
         (recur
           (g/mark-visited graph curr) (concat unvisited to-explore) (conj explored curr))))
     explored))
  ([graph source] (depth-first-search graph [source] [])))
