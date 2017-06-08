(ns breadth-first-search.core-spec
  (:require [speclj.core :refer :all]
            [breadth-first-search.core :refer :all]
            [breadth-first-search.spec-helper :refer :all]))

(def directed-tree
  (-> (generate-nodes "a" "i")
      (generate-edges "a" "b" "d")
      (generate-edges "b" "d" "f")
      (generate-edges "c" "f" "h")
      (add-edge "e" "h")))

(def undirected-graph
  (-> (generate-nodes "a" "j")
      (add-edge "a" "b")
      (add-edge "a" "h")
      (add-edge "b" "a")
      (add-edge "b" "c")
      (add-edge "b" "h")
      (add-edge "c" "b")
      (add-edge "c" "d")
      (add-edge "c" "f")
      (add-edge "c" "i")
      (add-edge "d" "c")
      (add-edge "d" "e")
      (add-edge "d" "f")
      (add-edge "e" "d")
      (add-edge "e" "f")
      (add-edge "f" "c")
      (add-edge "f" "d")
      (add-edge "f" "e")
      (add-edge "f" "g")
      (add-edge "g" "f")
      (add-edge "g" "h")
      (add-edge "g" "i")
      (add-edge "h" "a")
      (add-edge "h" "b")
      (add-edge "h" "g")
      (add-edge "h" "i")
      (add-edge "i" "c")
      (add-edge "i" "g")
      (add-edge "i" "h")))

(describe "add-node"
  (it "takes a map of nodes and returns map with node added"
    (should= {"a" {:neighbors []}}
             (add-node {} "a")))

  (it "handles many nodes"
    (let [nodes (generate-nodes "a" "i")]
      (should= {"a" {:neighbors []} "b" {:neighbors []} "c" {:neighbors []}
                "d" {:neighbors []} "e" {:neighbors []} "f" {:neighbors []}
                "g" {:neighbors []} "h" {:neighbors []}}
               nodes))))

(describe "add-edge"
  (it "takes an adjacency list, source, and neighbor labels and returns new tree"
    (let [a-list {"a" {:neighbors []}
                  "b" {:neighbors []}}]
      (should= {"a" {:neighbors ["b"]} "b" {:neighbors []}}
               (add-edge a-list "a" "b"))))

  (it "can add many edges"
    (should= {"a" {:neighbors ["b" "c"]} "b" {:neighbors ["d" "e"]} "c" {:neighbors ["f" "g"]}
              "d" {:neighbors []} "e" {:neighbors ["h"]} "f" {:neighbors []}
              "g" {:neighbors []} "h" {:neighbors []}}
             directed-tree))

  (it "can add node and edges if they do not exist"
    (should= {"a" {:neighbors ["b"]}}
             (add-edge {} "a" "b"))))

(describe "mark-visited"
  (it "takes a tree and a source and returns the same tree with a :visited field on node"
    (let [tree (generate-nodes "a" "d")]
      (should= {"a" {:neighbors []} "b" {:neighbors [] :visited true} "c" {:neighbors []}}
               (mark-visited tree "b")))))

(describe "breadth-first-search"
  (it "takes a tree and a source node and returns vector of searched nodes"
    (should= ["a" "b" "c" "d" "e" "f" "g" "h"]
             (breadth-first-search directed-tree "a")))

  (it "can handle undirected graphs"
    (should= ["a" "b" "h" "c" "g" "i" "d" "f" "e"]
             (breadth-first-search undirected-graph "a")))

  (it "can handle a single node graph"
    (let [single-node-graph (generate-nodes "a" "b")]
      (should= ["a"]
               (breadth-first-search single-node-graph "a")))))
