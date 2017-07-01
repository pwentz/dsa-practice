(ns breadth-first-search.core-spec
  (:require [speclj.core :refer :all]
            [breadth-first-search.graph :as g]
            [breadth-first-search.core :refer :all]))

(defn letters [[start] [stop]]
  (map str
       (take-while
         #(not= % stop)
         (iterate (comp char inc int) start))))

(defn generate-nodes [start-point stop-point]
  (reduce g/add-node {} (letters start-point stop-point)))

(defn generate-edges [graph source start stop]
  (reduce #(g/add-edge %1 source %2) graph (letters start stop)))

(def directed-tree
  (-> (generate-nodes "a" "i")
      (generate-edges "a" "b" "d")
      (generate-edges "b" "d" "f")
      (generate-edges "c" "f" "h")
      (g/add-edge "e" "h")))

(def undirected-graph
  (-> (generate-nodes "a" "j")
      (g/add-edge "a" "b")
      (g/add-edge "a" "h")
      (g/add-edge "b" "a")
      (g/add-edge "b" "c")
      (g/add-edge "b" "h")
      (g/add-edge "c" "b")
      (g/add-edge "c" "d")
      (g/add-edge "c" "f")
      (g/add-edge "c" "i")
      (g/add-edge "d" "c")
      (g/add-edge "d" "e")
      (g/add-edge "d" "f")
      (g/add-edge "e" "d")
      (g/add-edge "e" "f")
      (g/add-edge "f" "c")
      (g/add-edge "f" "d")
      (g/add-edge "f" "e")
      (g/add-edge "f" "g")
      (g/add-edge "g" "f")
      (g/add-edge "g" "h")
      (g/add-edge "g" "i")
      (g/add-edge "h" "a")
      (g/add-edge "h" "b")
      (g/add-edge "h" "g")
      (g/add-edge "h" "i")
      (g/add-edge "i" "c")
      (g/add-edge "i" "g")
      (g/add-edge "i" "h")))

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
