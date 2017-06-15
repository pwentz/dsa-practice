(ns minimum-spanning-trees.kruskals
  (:require [clojure.set :as s]))

(defn- format-edges [graph]
  (distinct (reduce (fn [acc v]
                      (concat acc
                              (reduce #(conj %1 {#{v %2} ((graph v) %2)}) [] (keys (graph v)))))
                    [] (keys graph))))

(defn sort-by-weight [graph]
  (sort-by (comp first vals) (format-edges graph)))

(defn- get-parents [vertices union-find]
  (remove (comp empty? (partial s/intersection vertices) union-find) (keys union-find)))

(defn- sort-by-size [union-find nodes]
  (reverse (sort-by (comp count union-find) nodes)))

(defn unionize [union-find vertices]
  "Find root nodes that contain either vertex, pick the root with most children.
   If no root contains either vertices, pick largest (ie. most children) root that matches either vertex"
  (if-let [root-parent (first (sort-by-size union-find (get-parents vertices union-find)))]
    (assoc union-find root-parent (s/union vertices (union-find root-parent)))
    (let [[largest-parent] (sort-by-size union-find (filter #(contains? vertices %) (keys union-find)))]
      (assoc union-find largest-parent (s/union (union-find largest-parent) (disj vertices largest-parent))))))

(defn same-set? [union-find vertices]
  (let [parents (set (get-parents vertices union-find))]
    (s/subset? vertices (reduce s/union parents (map union-find parents)))))

(defn init-union-find [graph]
  (into {} (map vector (keys graph) (repeat #{}))))

(defn kruskals
  "Kruskal's algorithm for minimum spanning trees.
    To start, sort edges by weight (asc)
     1. Grab top element
     2. Make sure vertices do not share root node of union-find sub-tree
     3. Add edge to new tree
     4. Unionize edge with correct union-find subtree
     5. Repeat with next edge in sorted list."
  ([union-find [curr & more]]
   (let [[[vertices weight]] (seq curr)]
     (when vertices
       (if (same-set? union-find vertices)
         (recur union-find more)
         (merge {vertices weight} (kruskals (unionize union-find vertices) more))))))

  ([graph] (let [[union-find sorted-edges] ((juxt init-union-find sort-by-weight) graph)
                 edges (kruskals union-find sorted-edges)]
             {:edges edges :total (reduce + (vals edges))})))
