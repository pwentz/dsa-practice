(ns sudoku-backtracking.core)

(def ^:private based 3)
(def ^:private dimension (* based based))
(def ^:private n-cells (* dimension dimension))

(def ^:private repeat-vec (comp vec (partial repeat (inc n-cells))))

(def ^:private free? (partial zero?))
(def ^:private taken? (complement free?))

(def ^:private invalid-coords {:x -1 :y -1})

(defn invalid? [x y]
  (or (neg? x) (neg? y)))

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
        get-sector #(subvec (get board (+ % x-low)) y-low (+ y-low based))]
    (mark-as-taken possibilities (mapcat get-sector (range based)))))

(defn- possible-values [{:keys [x y] :as coords} board]
  (let [square (get-in board [x y])
        invalid-square? (or (taken? square) (invalid? x y))
        valid-positions #(if (zero? %) false (not invalid-square?))]
    (-> (mapv valid-positions (-> dimension inc range vec))
        (available-by-row board coords)
        (available-by-column board coords)
        (available-by-sector board coords))))

(defn- next-square [board]
  (reduce-kv
    (fn [acc row-idx row]
      (reduce-kv
        (fn [a col-idx square]
          (let [coords {:x row-idx :y col-idx}
                new-count (count (filter true? (possible-values coords board)))]
            (cond (and (zero? new-count) (free? square)) invalid-coords
                  (and (pos? new-count) (free? square)) coords
                  :else a)))
        acc
        row))
    invalid-coords
    board))

(defn- construct-candidates [k board moves]
  (let [true-indices #(if (true? %3) (conj %1 %2) %1)
        {:keys [x y] :as sq} (next-square board)]
    (if (invalid? x y)
      {:candidates [] :moves moves}
      (let [candidates (reduce-kv true-indices [] (possible-values sq board))]
        {:candidates candidates :moves (assoc moves k sq)}))))

(def ^:private board-ref (atom []))
(def ^:private finished (atom false))
(def ^:private steps (atom 0))

(defn- finished-sudoku? [board]
  (do
    (swap! steps inc)
    (zero? (free-count board))))

(defn- update-board [k moves v]
  (let [{:keys [x y]} (moves k)]
    (when (false? @finished)
      (swap! board-ref assoc-in [x y] v))))

(defn- make-move [a k moves]
  (update-board k moves (a k)))

(defn- unmake-move [k moves]
  (update-board k moves 0))

(defn- backtrack [a k board m]
  (if (finished-sudoku? board)
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
    (println "This board has" (free-count board) "open spaces")
    (println "-----------------------")
    (do
      (reset! board-ref board)
      (reset! finished false)
      (reset! steps 0)
      (backtrack a 0 @board-ref (repeat-vec invalid-coords)))
    (println "Finished this sudoku in" @steps "steps")
    @board-ref))
