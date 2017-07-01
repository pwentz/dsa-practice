(ns dijkstras-algorithm.core-spec
  (:require [speclj.core :refer :all]
            [dijkstras-algorithm.core :refer :all]))

(defn add-edge [graph source neighbor weight]
  (merge-with merge graph {source {neighbor weight}} {neighbor {source weight}}))

(def mini-graph
  (-> (add-edge {} "A" "B" 5)
      (add-edge "A" "D" 7)
      (add-edge "A" "G" 12)
      (add-edge "B" "D" 9)
      (add-edge "D" "G" 4)))

(def graph
  (-> (add-edge {} "A" "B" 5)
      (add-edge "A" "D" 7)
      (add-edge "A" "G" 12)
      (add-edge "B" "C" 7)
      (add-edge "B" "D" 9)
      (add-edge "C" "D" 4)
      (add-edge "C" "F" 5)
      (add-edge "D" "E" 3)
      (add-edge "D" "G" 4)
      (add-edge "E" "C" 2)
      (add-edge "E" "F" 2)
      (add-edge "E" "G" 7)))

(describe "lowest-cost-node"
  (it "finds the lowest cost node that has not yet been visited"
    (let [costs {"B" 5, "D" 7, "G" 12}]
      (should= "B"
               (lowest-cost-node costs #{}))
      (should= "G"
               (lowest-cost-node costs #{"B" "D"})))))

(describe "build-solution"
  (it "finds the shortest distance to G"
    (let [result {#{"A" "D"} 7
                  #{"D" "G"} 4}]
      (should= result
               (build-shortest-path mini-graph {"B" "A", "D" "A", "G" "D"} "A" "G")))))

(describe "dijkstra"
  (it "finds the shortest distance to G on mini-graph"
    (let [result {#{"A" "D"} 7
                  #{"D" "G"} 4}]
      (should= result
               (:edges (dijkstra mini-graph "A" "G")))
      (should= 11
               (:total (dijkstra mini-graph "A" "G")))))

  (it "finds the shortest distance to F on mini-graph"
    (let [result {#{"A" "D"} 7
                  #{"D" "E"} 3
                  #{"E" "F"} 2}]
      (should= result
               (:edges (dijkstra graph "A" "F")))
      (should= 12
               (:total (dijkstra graph "A" "F"))))))
