(ns floyd-warshall.core-spec
  (:require [speclj.core :refer :all]
            [floyd-warshall.core :refer :all]))

; only works with directed graphs right now
; TODO:
  ; - Consider adding support for undirected graphs
  ; (merge-with merge graph {source {neighbor weight}} {neighbor {source weight}})

; TODO: FIND WHAT YOU WANT FINAL FN TO RETURN (parents-matrix is useless)
(defn add-edge [graph source neighbor weight]
  (merge-with merge graph {source {neighbor weight}}))

(def i Long/MAX_VALUE)

(def mini-graph
  (-> (add-edge {} 1 2 4)
      (add-edge 1 3 1)
      (add-edge 1 4 3)
      (add-edge 2 3 8)
      (add-edge 2 4 -2)
      (add-edge 3 4 -5)))

(def graph
  (-> (add-edge {} 1 2 3)
      (add-edge 1 5 -4)
      (add-edge 1 3 8)
      (add-edge 2 4 1)
      (add-edge 2 5 7)
      (add-edge 3 2 4)
      (add-edge 4 1 2)
      (add-edge 4 3 -5)
      (add-edge 5 4 6)))

(describe "adjacency-matrix"
  (it "creates an adjacency matrix from a graph"
    (let [result [[0  4  1   3]
                  [i  0  8  -2]
                  [i  i  0  -5]
                  [i  i  i   0]]]
      (should= result
               (adjacency-matrix mini-graph)))))

(describe "parent-matrix"
  (it "creates an adjacency matrix of best-path parents"
    (let [x nil
          distance-matrix (adjacency-matrix mini-graph)
          result [[x  0  0  0]
                  [i  x  1  1]
                  [i  i  x  2]
                  [i  i  i  x]]]
      (should= result
               (parent-matrix distance-matrix)))))

(describe "floyd-warshall"
  (it "can handle a smaller graph"
    (let [result [[0  4  1  -4]
                  [i  0  8  -2]
                  [i  i  0  -5]
                  [i  i  i   0]]]
      (should= result
               (floyd-warshall mini-graph))))

  (it "can do larger graphs"
    (let [result [[0   1  -3   2  -4]
                  [3   0  -4   1  -1]
                  [7   4   0   5   3]
                  [2  -1  -5   0  -2]
                  [8   5   1   6   0]]]
      (should= result
               (floyd-warshall graph)))))
