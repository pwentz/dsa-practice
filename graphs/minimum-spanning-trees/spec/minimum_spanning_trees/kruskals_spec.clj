(ns minimum-spanning-trees.kruskals-spec
  (:require [speclj.core :refer :all]
            [minimum-spanning-trees.kruskals :refer :all]))

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

(describe "sort-by-weight"
  (it "sorts edges of graph by weight"
    (let [edges [{#{"E" "C"} 2}
                 {#{"E" "F"} 2}
                 {#{"D" "E"} 3}
                 {#{"C" "D"} 4}
                 {#{"D" "G"} 4}
                 {#{"A" "B"} 5}
                 {#{"C" "F"} 5}
                 {#{"A" "D"} 7}
                 {#{"B" "C"} 7}
                 {#{"E" "G"} 7}
                 {#{"B" "D"} 9}
                 {#{"A" "G"} 12}]]
      (should= edges
               (sort-by-weight graph)))))

(describe "union-find data structure"
  (it "unionizes on all empty elements"
    (let [union-find {"A" #{} "B" #{} "C" #{} "D" #{}}]
      (should= {"A" #{} "B" #{} "C" #{"A"} "D" #{}}
               (unionize union-find #{"A" "C"}))))

  (it "correctly unionizes when vertices contain root node w/ children"
    (let [union-find {"A" #{"D"} "B" #{} "C" #{} "D" #{}}]
      (should= {"A" #{"C" "D"} "B" #{} "C" #{} "D" #{}}
               (unionize union-find #{"A" "C"}))))

  (it "correctly unionizes when one vertex belongs to sub-tree"
    (let [union-find {"A" #{"B" "C"} "B" #{} "C" #{} "D" #{}}]
      (should= {"A" #{"B" "C" "D"} "B" #{} "C" #{} "D" #{}}
               (unionize union-find #{"B" "D"}))))

  (it "can tell if elements belong to same set"
    (let [union-find {"A" #{} "B" #{"A"} "C" #{"B" "D"} "D" #{}}]
      (should= true
               (same-set? union-find #{"B" "D"}))
      (should= true
               (same-set? union-find #{"A" "B"}))
      (should= true
               (same-set? union-find #{"A" "D"}))))

  (it "can start elements off"
    (let [expected {"A" #{} "B" #{} "C" #{} "D" #{} "E" #{} "F" #{} "G" #{}}]
      (should= expected
               (init-union-find graph)))))

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
