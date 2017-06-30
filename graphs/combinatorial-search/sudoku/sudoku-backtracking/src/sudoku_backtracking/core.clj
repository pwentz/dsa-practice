(ns sudoku-backtracking.core)

(def ^:private based 3)
(def ^:private dimension (* based based))
(def ^:private n-cells (* dimension dimension))
(def ^:private repeat-vec (comp vec (partial repeat (inc n-cells))))

(def ^:private free? (partial zero?))
(def ^:private taken? (complement free?))

(defn- free-count [board]
  (let [open-spaces (comp count (partial filter free?))]
    (apply + (map open-spaces board))))

(defn- mark-as-taken [possibilities subsection]
  (let [value-possibilities (mapcat vector (remove free? subsection) (repeat false))]
    (if (seq value-possibilities)
      (apply assoc possibilities value-possibilities)
      possibilities)))

(defn- available-by-row [possibilities board {:keys [x y]}]
  (mark-as-taken possibilities (board x)))

(defn- available-by-column [possibilities board {:keys [x y]}]
  (let [column (map #(get-in board [% y]) (range dimension))]
    (mark-as-taken possibilities column)))

(defn- available-by-sector [possibilities board {:keys [x y]}]
  (let [x-low (* based (int (/ x based)))
        y-low (* based (int (/ y based)))
        sector (mapcat #(subvec (board (+ % x-low)) y-low (+ y-low 3)) (range 3))]
    (mark-as-taken possibilities sector)))

(defn- possible-values [{:keys [x y] :as coords} board]
  (let [square (get-in board [x y])
        invalid-square? (or (taken? square) (or (neg? x) (neg? y)))
        valid-positions #(if (zero? %) false (not invalid-square?))]
    (-> (mapv valid-positions (-> dimension inc range vec))
        (available-by-row board coords)
        (available-by-column board coords)
        (available-by-sector board coords))))

(defn- next-square [board]
  (reduce-kv
    (fn [acc row-idx row]
      (reduce-kv (fn [a col-idx col]
                   (let [new-count (count (filter true? (possible-values {:x row-idx :y col-idx} board)))]
                     (cond (and (zero? new-count) (free? col)) (assoc a :x -1 :y -1)
                           (and (pos? new-count) (free? col)) (assoc a :x row-idx :y col-idx)
                           :else a))) acc row))
    {:x -1 :y -1}
    board))

(defn- construct-candidates [k board moves]
  (let [true-indices #(if (true? %3) (conj %1 %2) %1)
        {:keys [x y] :as sq} (next-square board)]
    (if (or (neg? x) (neg? y))
      {:candidates [] :moves moves}
      (let [candidates (reduce-kv true-indices [] (possible-values sq board))]
        {:candidates candidates :moves (assoc moves k sq)}))))

(def ^:private board-ref (atom []))
(def ^:private finished (atom false))
(def ^:private steps (atom 0))

(defn- update-board [k moves v]
  (let [{:keys [x y]} (moves k)]
    (when (false? @finished)
      (swap! board-ref assoc-in [x y] v))))

(defn- make-move [a k moves]
  (update-board k moves (a k)))

(defn- unmake-move [k moves]
  (update-board k moves 0))

(defn- backtrack [a k board m]
  (if (zero? (free-count board))
    (reset! finished true)
    (let [{:keys [candidates moves]} (construct-candidates (inc k) board m)]
      (doall
        (for [c candidates]
          (let [j (inc k)
                b (assoc a j c)]
            (make-move b j moves)
            (backtrack b j @board-ref moves)
            (unmake-move j moves)))))))

(defn solve [board]
  (let [a (repeat-vec 0)]
    (do
      (reset! board-ref board)
      (reset! finished false)
      (backtrack a 0 @board-ref (repeat-vec {:x -1 :y -1})))
    @board-ref))
