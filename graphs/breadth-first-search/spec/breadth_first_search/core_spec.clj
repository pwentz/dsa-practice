(ns breadth-first-search.core-spec
  (:require [speclj.core :refer :all]
            [breadth-first-search.core :refer :all]))

(defn generate-nodes [stop-point]
  (let [letters (map str
                     (take-while
                       #(not= % (first stop-point))
                       (iterate (comp char inc int) \a)))]
    (reduce add-node {} letters)))

(defn generate-edges []
  (-> (generate-nodes "i")
      (add-edge "a" "b")
      (add-edge "a" "c")
      (add-edge "b" "d")
      (add-edge "b" "e")
      (add-edge "c" "f")
      (add-edge "c" "g")
      (add-edge "e" "h")))

(describe "add-node"
  (it "takes a map of nodes and returns map with node added"
    (should= {"a" {:edges []}}
             (add-node {} "a")))

  (it "handles many nodes"
    (let [nodes (generate-nodes "i")]
      (should= {"a" {:edges []} "b" {:edges []} "c" {:edges []}
                "d" {:edges []} "e" {:edges []} "f" {:edges []}
                "g" {:edges []} "h" {:edges []}}
               nodes))))

(describe "add-edge"
  (it "takes an adjacency list, source, and neighbor labels and returns new tree"
    (let [a-list {"a" {:edges []}
                  "b" {:edges []}}]
      (should= {"a" {:edges ["b"]} "b" {:edges []}}
               (add-edge a-list "a" "b"))))

  (it "can add many edges"
    (let [nodes (generate-edges)]
      (should= {"a" {:edges ["b" "c"]} "b" {:edges ["d" "e"]} "c" {:edges ["f" "g"]}
                "d" {:edges []} "e" {:edges ["h"]} "f" {:edges []}
                "g" {:edges []} "h" {:edges []}}
               nodes)))

  (it "can add node and edges if they do not exist"
    (should= {"a" {:edges ["b"]}}
             (add-edge {} "a" "b"))))

(describe "mark-visited"
  (it "takes a tree and a source and returns the same tree with a :visited field on node"
    (let [tree (generate-nodes "d")]
      (should= {"a" {:edges []} "b" {:edges [] :visited true} "c" {:edges []}}
               (mark-visited tree "b")))))

(describe "breadth-first-search"
  (it "takes a tree and a source node and returns vector of searched nodes"
    (let [tree (generate-edges)]
      (should= ["a" "b" "c" "d" "e" "f" "g" "h"]
               (breadth-first-search tree "a")))))
