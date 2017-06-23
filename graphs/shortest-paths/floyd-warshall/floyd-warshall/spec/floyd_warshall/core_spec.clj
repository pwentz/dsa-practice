(ns floyd-warshall.core-spec
  (:require [speclj.core :refer :all]
            [floyd-warshall.core :refer :all]))

(defn add-edge [graph source neighbor weight]
  (merge-with merge graph {source {neighbor weight}}))

(def i Double/POSITIVE_INFINITY)

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

(describe "get-vertices"
  (it "gets the vertices of a graph"
    (should= [1 2 3 4]
             (get-vertices mini-graph))
    (should= [1 2 3 4 5]
             (get-vertices graph))))

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
               (:distances (floyd-warshall mini-graph)))))

  (it "can return parents"
    (let [x nil
          result [[x  0  0  2]
                  [i  x  1  1]
                  [i  i  x  2]
                  [i  i  i  x]]]
      (should= result
               (:parents (floyd-warshall mini-graph)))))

  (it "can do larger graphs"
    (let [result [[0   1  -3   2  -4]
                  [3   0  -4   1  -1]
                  [7   4   0   5   3]
                  [2  -1  -5   0  -2]
                  [8   5   1   6   0]]]
      (should= result
               (:distances (floyd-warshall graph)))))

  (it "can return parents for large graphs"
    (let [x nil
          result [[x  2  3  4  0]
                  [3  x  3  1  0]
                  [3  2  x  1  0]
                  [3  2  3  x  0]
                  [3  2  3  4  x]]]
      (should= result
               (:parents (floyd-warshall graph))))))

(describe "build-path"
  (it "builds a path"
    (let [result {#{1 3} 1
                  #{3 4} -5}]
      (should= result
               (build-path mini-graph 1 4 [0 4 1 -4] [nil 0 0 2])))))

(describe "build-shortest-path"
  (it "builds the shortest path"
    (let [result {1 {2 {#{1 2} 4}
                     3 {#{1 3} 1}
                     4 {#{1 3} 1 #{3 4} -5}}}]
      (should= result
               (build-shortest-path {} [0 4 1 -4] [nil 0 0 2] mini-graph 0)))))

(describe "floyd-warshall-graph"
  (it "gets all paths for mini graph"
    (let [result {1
                  {2 {#{1 2} 4}
                   3 {#{1 3} 1}
                   4 {#{1 3} 1 #{3 4} -5}}
                  2
                  {3 {#{2 3} 8}
                   4 {#{2 4} -2}}
                  3
                  {4 {#{3 4} -5}}
                  4 {}}]
      (should= result
               (floyd-warshall-graph mini-graph))))

  (it "gets all paths for graph"
    (let [result {1
                  {2 {#{1 5} -4, #{5 4} 6, #{4 3} -5, #{3 2} 4}
                   3 {#{1 5} -4, #{5 4} 6, #{4 3} -5}
                   4 {#{1 5} -4, #{5 4} 6}
                   5 {#{1 5} -4}}
                  2
                  {1 {#{2 4} 1, #{4 1} 2}
                   3 {#{2 4} 1, #{4 3} -5}
                   4 {#{2 4} 1}
                   5 {#{2 4} 1, #{4 1} 2, #{1 5} -4}}
                  3
                  {1 {#{3 2} 4, #{2 4} 1, #{4 1} 2}
                   2 {#{3 2} 4}
                   4 {#{3 2} 4, #{2 4} 1}
                   5 {#{3 2} 4, #{2 4} 1, #{4 1} 2, #{1 5} -4}}
                  4
                  {1 {#{4 1} 2}
                   2 {#{4 3} -5, #{3 2} 4}
                   3 {#{4 3} -5}
                   5 {#{4 1} 2, #{1 5} -4}}
                  5
                  {1 {#{5 4} 6, #{4 1} 2}
                   2 {#{5 4} 6, #{4 3} -5, #{3 2} 4}
                   3 {#{5 4} 6, #{4 3} -5}
                   4 {#{5 4} 6}}}]
      (should= result
               (floyd-warshall-graph graph)))))
