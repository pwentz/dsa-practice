(ns depth-first-search.core)

(defn mark-visited [graph source]
  (assoc graph source (assoc (graph source) :visited true)))

(defn add-node [nodes label]
  (assoc nodes label {:neighbors []}))

(defn add-edge [graph source neighbor]
  (let [neighbors-of (comp :neighbors graph)]
    (assoc graph source {:neighbors (conj (neighbors-of source) neighbor)})))

(defn push [stack & nodes]
  (concat nodes stack))

(defn if-visited [acc tree source]
    (println "|| NODE" source)
    (println "|| TREE" tree)
    (println "|| NODES" acc)
  (if (true? (-> source tree :visited))
    acc
    (conj acc source)))

(defn depth-first-search
  ([graph [curr & others :as st] nodes]
   (if curr
     (if (true? (-> curr graph :visited)) ; if visited before, keep going...
       (recur graph others nodes)
       (let [unvisited (remove (comp :visited graph) (:neighbors (graph curr)))]
         (recur ; otherwise, place unvisited on top of stack
           (mark-visited graph curr)
           (concat unvisited others)
           (conj nodes curr))))
     nodes))
  ([graph source] (depth-first-search graph [source] [])))
