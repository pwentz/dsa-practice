(ns topological-sort.core
  (:require [topological-sort.graph :as g]))

(defn depth-first-search
  ([graph [curr & to-explore] explored]
   (if curr
     (if (true? (-> curr graph :visited))
       (recur graph to-explore explored)
       (let [unvisited (remove (comp :visited graph) (-> curr graph :neighbors))]
         (recur
           (g/mark-visited graph curr) (concat unvisited to-explore) (conj explored curr))))
     explored))
  ([graph source] (depth-first-search graph [source] [])))

(defn zero-in-degrees? [graph node]
  (not-any? #{node} (mapcat :neighbors (vals graph))))

(defn zero-in-degrees [graph]
  (filter #(zero-in-degrees? graph %) (keys graph)))

(defn topological-sort [graph]
  (letfn [(search [acc node]
            (concat
              (depth-first-search (reduce g/mark-visited graph acc) node)
              acc))]
    (reduce search [] (zero-in-degrees graph))))
