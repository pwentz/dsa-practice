(ns prims-algorithm.core-spec
  (:require [speclj.core :refer :all]
            [prims-algorithm.core :refer :all]))

(defn add-edge [graph source neighbor weight]
  (merge-with merge graph {source {neighbor weight}} {neighbor {source weight}}))

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

(describe "add-edge"
  (it "adds a weighted edge"
    (should= {"A" {"B" 4} "B" {"A" 4}}
             (add-edge {} "A" "B" 4)))

  (it "can add to existing graph"
    (let [graph {"A" {"B" 4} "B" {"A" 4}}]
      (should= {"A" {"B" 4 "C" 12} "B" {"A" 4} "C" {"A" 12}}
               (add-edge graph "A" "C" 12)))))

(describe "priority-queue"
  (it "can maintain ascending order of weights"
    (let [p-queue (-> (enqueue [] {:v "B" :weight 11})
                      (enqueue {:v "C" :weight 22})
                      (enqueue {:v "G" :weight 3})
                      (enqueue {:v "H" :weight 8}))]
      (should= [{:v "G" :weight 3}
                {:v "H" :weight 8}
                {:v "B" :weight 11}
                {:v "C" :weight 22}]
               p-queue))))

(describe "prims"
  (it "is Prim's Algorithm"
    (let [expected-edges {#{"A" "B"} 5
                          #{"A" "D"} 7
                          #{"D" "E"} 3
                          #{"E" "C"} 2
                          #{"E" "F"} 2
                          #{"D" "G"} 4}]
      (should= expected-edges
               (:edges (prims graph)))
      (should= 23
               (:total (prims graph))))))
