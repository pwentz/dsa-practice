(ns minimum-spanning-trees.core
  (:require [clojure.set :as s]))

(defn enqueue [queue edge]
  "Simple priority queue to sort by weight ascending"
  (sort-by :weight (-> queue vec (conj edge))))

(defn add-edge [graph source neighbor weight]
  (merge-with merge graph {source {neighbor weight}} {neighbor {source weight}}))

(defn- get-edge-maps [graph parent vertices]
  (reduce
    #(conj %1
           {:vertex %2 :parent parent :weight (get-in graph [parent %2])})
    [] vertices))

(defn prims
  "Prims algorithm for minimum spanning trees. To start, pick any vertex:
   1. Make sure vertex has not been visited yet
   2. Add unvisited neighbors to (lowest weight) priority queue
   3. Add edge with current vertex and connecting/parent vertex to resulting sub-tree
   4. Repeat with next on priority queue"
  ([graph [{:keys [vertex weight parent]} & others] visited]
   (when vertex
     (if (contains? visited vertex)
       (recur graph others visited)
       (let [unvisited-edges (get-edge-maps graph vertex (remove #(contains? visited %) (-> vertex graph keys)))
             updated-queue (reduce enqueue others unvisited-edges)]
         (merge {[parent vertex] weight} (prims graph updated-queue (conj visited vertex)))))))
  ([graph] (let [start (-> graph first key)
                 edges (prims graph (-> {:vertex start :weight 0}
                                        (cons (get-edge-maps graph start (-> start graph keys))))
                              #{start})]
             (assoc {} :edges edges :total (->> edges vals (reduce +))))))

(defn- format-edges [graph]
  (reduce (fn [acc v]
            (merge acc
                   (reduce
                     #(merge %1 {#{v %2} ((graph v) %2)}) {} (keys (graph v))))) {} (keys graph)))

(defn sort-by-weight [graph]
  (let [edges (format-edges graph)]
    (into (sorted-map-by #(<= (edges %1) (edges %2))) edges)))

(defn sorted-dissoc [graph vertices]
  (let [unsorted (reduce (fn [acc [elt-key elt-val]]
                           (if (= elt-key vertices)
                             acc
                             (assoc acc elt-key elt-val))) {} graph)]
    (into (sorted-map-by #(<= (unsorted %1) (unsorted %2))) unsorted)))

; TODO:
  ; - Take all parents/keys that contains either of vertices...
  ;   ...pick one that contains most children
  ; - if no parents/keys contains either of vertices, pick one vertex to make parent of other
(defn unionize [union-find vertices]
  (let [direct-parents (remove #(empty? (s/intersection vertices (union-find %))) (keys union-find))
        [main-parent] (reverse (sort-by #(count (union-find %)) direct-parents))]
    (if main-parent
      (assoc union-find main-parent (s/union vertices (union-find main-parent)))
      (let [[largest-parent] (reverse (sort-by #(count (union-find %)) (filter #(contains? vertices %) (keys union-find))))]
        (assoc union-find largest-parent (s/union (union-find largest-parent) (disj vertices largest-parent)))))))

(defn empty-children? [union-find vertices]
  (let [v1 (first vertices)
        v2 (first (disj vertices v1))]
    (and (empty? (union-find v1)) (empty? (union-find v2)))))

(defn same-set? [union-find vertices]
  (let [parent-nodes (remove #(empty? (s/intersection vertices (union-find %))) (keys union-find))
        all-siblings (reduce #(s/union %1 (union-find %2) #{%2}) #{} parent-nodes)]
    (s/subset? vertices all-siblings)))

(defn add-sets [graph]
  (reduce #(merge %1 {%2 #{}}) {} (keys graph)))

(defn kruskals
  ([traversed union-find edges]
   (let [[vertices weight] (first edges)]
     (cond (nil? vertices) traversed
           (same-set? union-find vertices) (recur traversed union-find (sorted-dissoc edges vertices))
           :else (recur (merge traversed {vertices weight}) (unionize union-find vertices) (sorted-dissoc edges vertices))
           )))
  ([graph] (let [edges (kruskals {} (add-sets graph) (sort-by-weight graph))]
             {:edges edges :total (reduce + (vals edges))})))
