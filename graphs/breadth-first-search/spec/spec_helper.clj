(ns spec-helper
  (:require [graph-utils :refer [add-node
                                 add-edge]]))

(defn letters [[start] [stop]]
  (map str
       (take-while
         #(not= % stop)
         (iterate (comp char inc int) start))))

(defn generate-nodes [start-point stop-point]
  (reduce add-node {} (letters start-point stop-point)))

(defn generate-edges [graph source start stop]
  (reduce #(add-edge %1 source %2) graph (letters start stop)))
