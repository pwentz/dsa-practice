(ns topological-sort.core-spec
  (:require [speclj.core :refer :all]
            [topological-sort.core :refer :all]
            [graph-utils :refer [add-edge add-node]]
            [spec-helper :refer :all]))

(def dag
  (-> (add-node {} "5")
      (add-node "7")
      (add-node "3")
      (add-node "11")
      (add-node "8")
      (add-node "2")
      (add-node "9")
      (add-node "10")
      (add-edge "5" "11")
      (add-edge "7" "11")
      (add-edge "7" "8")
      (add-edge "3" "8")
      (add-edge "3" "10")
      (add-edge "11" "2")
      (add-edge "11" "9")
      (add-edge "11" "10")
      (add-edge "8" "9")))

(describe "zero-in-degrees?"
  (it "returns t or f if 0 in-degree"
    (should= true
             (zero-in-degrees? dag "3"))
    (should= false
             (zero-in-degrees? dag "8"))))

(describe "zero-in-degrees"
  (it "can return nodes with 0 in-degree"
    (should== '("3" "5" "7")
              (zero-in-degrees dag))))

(describe "topological-sort"
  (it "does the topological sort"
    (let [sols [["5" "7" "11" "2" "3" "10" "8" "9"]
                ["7" "5" "11" "2" "3" "10" "8" "9"]
                ["3" "7" "8" "5" "11" "2" "9" "10"]
                ["7" "5" "11" "2" "3" "8" "9" "10"]
                ["5" "7" "11" "2" "3" "8" "9" "10"]
                ["3" "7" "5" "10" "8" "11" "9" "2"]
                ["3" "7" "5" "8" "11" "2" "9" "10"]]]
      (should-contain (topological-sort dag)
                      sols))))
