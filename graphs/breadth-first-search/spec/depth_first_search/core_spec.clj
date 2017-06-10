(ns depth-first-search.core-spec
  (:require [speclj.core :refer :all]
            [depth-first-search.core :refer :all]
            [graph-utils :refer [add-edge add-node]]
            [spec-helper :refer :all]))

(def directed-tree
  (-> (generate-nodes "a" "i")
      (generate-edges "a" "b" "d")
      (generate-edges "b" "d" "f")
      (generate-edges "c" "f" "h")
      (add-edge "e" "h")
      (add-edge "e" "f")
      (add-edge "f" "g")))

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

(describe "depth-first-search"
  (it "takes a tree and a source node and returns vector of searched nodes"
    (should= ["a" "b" "d" "e" "h" "f" "g" "c"]
             (depth-first-search directed-tree "a")))

  (it "can handle undirected graphs"
    (should= ["a" "b" "c" "d" "e" "f" "g" "h" "i"]
             (depth-first-search undirected-graph "a")))

  (it "can handle a single node graph"
    (let [single-node-graph (generate-nodes "a" "b")]
      (should= ["a"]
               (depth-first-search single-node-graph "a"))))
  )
