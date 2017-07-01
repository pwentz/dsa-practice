(ns topological-sort.core-spec
  (:require [speclj.core :refer :all]
            [topological-sort.core :refer :all]
            [topological-sort.graph :as g]))

(defn letters [[start] [stop]]
  (map str
       (take-while
         #(not= % stop)
         (iterate (comp char inc int) start))))

(defn generate-nodes [start-point stop-point]
  (reduce g/add-node {} (letters start-point stop-point)))

(defn generate-edges [graph source start stop]
  (reduce #(g/add-edge %1 source %2) graph (letters start stop)))

(def dag
  (-> (g/add-node {} "5")
      (g/add-node "7")
      (g/add-node "3")
      (g/add-node "11")
      (g/add-node "8")
      (g/add-node "2")
      (g/add-node "9")
      (g/add-node "10")
      (g/add-edge "5" "11")
      (g/add-edge "7" "11")
      (g/add-edge "7" "8")
      (g/add-edge "3" "8")
      (g/add-edge "3" "10")
      (g/add-edge "11" "2")
      (g/add-edge "11" "9")
      (g/add-edge "11" "10")
      (g/add-edge "8" "9")))

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
