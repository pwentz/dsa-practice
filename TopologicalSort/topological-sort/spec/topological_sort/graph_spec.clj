(ns topological-sort.graph-spec
  (:require [speclj.core :refer :all]
            [topological-sort.core-spec :as cs]
            [topological-sort.graph :refer :all]))

(def directed-tree
  (-> (cs/generate-nodes "a" "i")
      (cs/generate-edges "a" "b" "d")
      (cs/generate-edges "b" "d" "f")
      (cs/generate-edges "c" "f" "h")
      (add-edge "e" "h")))

(describe "add-node"
  (it "takes a map of nodes and returns map with node added"
    (should= {"a" {:neighbors []}}
             (add-node {} "a")))

  (it "handles many nodes"
    (let [nodes (cs/generate-nodes "a" "i")]
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
    (let [tree (cs/generate-nodes "a" "d")]
      (should= {"a" {:neighbors []} "b" {:neighbors [] :visited true} "c" {:neighbors []}}
               (mark-visited tree "b")))))

