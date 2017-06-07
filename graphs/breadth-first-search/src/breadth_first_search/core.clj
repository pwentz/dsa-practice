(ns breadth-first-search.core)

; (def graph-requirements
;   [#(not-empty %)
;    #(every? :edges (vals %))
;    #(every? vector? (map :edges (vals %)))])

(defn mark-visited [tree source]
  (let [node (get tree source)]
    (assoc tree source (assoc node :visited true))))

(defn enqueue [queue & nodes]
  (apply conj queue nodes))

(defn dequeue [queue]
  (first queue))

(defn add-node [nodes label]
  (assoc nodes label {:edges []}))

(defn add-edge [graph source neighbor]
  (let [source-node (get graph source)
        source-edges (:edges source-node)]
    (assoc graph source {:edges (conj source-edges neighbor)})))

(defn breadth-first-search
  ([tree source queue nodes]
   (println "Q" queue)
   (println "TREE" tree)
   (println "EXPLORED" nodes)
   (let [current (dequeue queue)]
   (println "CURRENT" current)
     (if current
       (let [neighbors (map #(get tree %) (:edges current))
             updated-tree (reduce mark-visited tree (cons source (:edges current)))
             unvisited (map #(assoc % :visited true) (remove :visited neighbors))
             first-unvisited (remove #(:visited (get tree %)) (:edges current))]
         (println "UNVISITED" first-unvisited)
   (println "-------------")
         (breadth-first-search updated-tree first-unvisited (apply enqueue (vec (rest queue)) unvisited) (apply conj nodes first-unvisited)))
       nodes)))
  ([tree source] (breadth-first-search tree source [(get tree source)] [source])))
