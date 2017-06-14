(ns minimum-spanning-trees.core-spec
  (:require [speclj.core :refer :all]
            [minimum-spanning-trees.core :refer :all]))

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
    (let [expected-edges {["A" "B"] 5
                          ["A" "D"] 7
                          ["D" "E"] 3
                          ["E" "C"] 2
                          ["E" "F"] 2
                          ["D" "G"] 4}]
      (should= expected-edges
               (:edges (prims graph)))
      (should= 23
               (:total (prims graph))))))

(describe "sort-by-weight"
  (it "sorts edges of graph by weight"
    (let [unsorted {#{"E" "C"} 2
                    #{"E" "F"} 2
                    #{"D" "E"} 3
                    #{"C" "D"} 4
                    #{"D" "G"} 4
                    #{"A" "B"} 5
                    #{"C" "F"} 5
                    #{"A" "D"} 7
                    #{"B" "C"} 7
                    #{"E" "G"} 7
                    #{"B" "D"} 9
                    #{"A" "G"} 12}
          expected (into (sorted-map-by #(<= (unsorted %1) (unsorted %2))) unsorted)]
      (should== expected
                (sort-by-weight graph)))))

(describe "sorted-dissoc"
  (it "dissociates"
    (let [example {#{"E" "C"} 2
                   #{"M" "N"} 5
                   #{"D" "G"} 11}
          sorted (into (sorted-map-by #(<= (example %1) (example %2))) example)]
      ; (should= {#{"E" "C"} 2
      ;           #{"D" "G"} 11}
      ;          (sorted-dissoc sorted #{"M" "N"}))
      )))

(describe "union-find data structure"
  (it "can tell if set values for keys in vertices are empty"
    (let [union-find {"A" #{"D"} "B" #{} "C" #{}}]
      (should= true
               (empty-children? union-find #{"B" "C"}))
      (should= false
               (empty-children? union-find #{"A" "C"}))))

  (it "can add together empty elements"
    (let [union-find {"A" #{} "B" #{} "C" #{} "D" #{}}]
      (should= {"A" #{} "B" #{} "C" #{"A"} "D" #{}}
               (unionize union-find #{"A" "C"}))))

  (it "can add together non-empty elements"
    (let [union-find {"A" #{"D"} "B" #{} "C" #{} "D" #{}}]
      (should= {"A" #{"C" "D"} "B" #{} "C" #{} "D" #{}}
               (unionize union-find #{"A" "C"}))))

  (it "can unionize elements already belonging to tree"
    (let [union-find {"A" #{"B" "C"} "B" #{} "C" #{} "D" #{}}]
      (should= {"A" #{"B" "C" "D"} "B" #{} "C" #{} "D" #{}}
               (unionize union-find #{"B" "D"}))))

  (it "can tell if elements belong to same set"
    (let [union-find {"A" #{"B" "C" "H"} "G" #{"N"}}
          edge-case {"A" #{} "B" #{"A"} "C" #{"B" "D"} "D" #{}}]
      (should= true
               (same-set? union-find #{"H" "C"}))
      (should= true
               (same-set? union-find #{"A" "B"}))
      (should= true
               (same-set? edge-case #{"A" "D"}))
      )
    )

  (it "can start elements off"
    (let [expected {"A" #{} "B" #{} "C" #{} "D" #{} "E" #{} "F" #{} "G" #{}}]
      (should= expected
               (add-sets graph)))))

(describe "kruskals"
  (it "is Kruskal's Algorithm"
    (let [expected-edges {#{"E" "C"} 2
                          #{"E" "F"} 2
                          #{"D" "E"} 3
                          #{"D" "G"} 4
                          #{"A" "B"} 5
                          #{"B" "C"} 7}]
      (should= expected-edges
               (:edges (kruskals graph)))
      (should= 23
               (:total (kruskals graph))))))
