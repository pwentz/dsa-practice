(ns topological-sort.core
  (:require [depth-first-search.core :refer [depth-first-search]]
            [graph-utils :refer [add-edge add-node mark-visited]]))

(defn zero-in-degrees? [graph node]
  (not-any? #{node} (mapcat :neighbors (vals graph))))

(defn zero-in-degrees [graph]
  (filter #(zero-in-degrees? graph %) (keys graph)))

(defn topological-sort [graph]
  (letfn [(search [acc node]
            (concat
              (depth-first-search (reduce mark-visited graph acc) node)
              acc))]
    (reduce search [] (zero-in-degrees graph))))
