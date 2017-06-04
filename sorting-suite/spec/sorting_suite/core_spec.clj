(ns sorting-suite.core-spec
  (:require [speclj.core :refer :all]
            (sorting-suite [merge-sort :refer :all]
                           [selection-sort :refer :all]
                           [insertion-sort :refer :all]
                           [quick-sort :refer :all])))

(def result [1 2 3 4 5 6 7 8 9 10])
(def stress-test (range 100000))

(defn get-time [f]
  (let [full-out (with-out-str (time (doall (f))))
        time-str (subs full-out (inc (.indexOf full-out ":")) (.indexOf full-out "msecs"))]
    (/ (read-string time-str) 1000)))

(describe "merge-sort"
  (it "sorts"
    (should= [1 2 3]
             (merge-sort [2 1 3]))
    (should= result
             (merge-sort (shuffle (range 1 11))))
    (should= true
             (-> (get-time #(merge-sort (shuffle stress-test)))
                 (< 4.5)))))

(describe "selection-sort"
  (it "sorts"
    (should= result
             (selection-sort (shuffle (range 1 11))))))

(describe "insertion-sort"
  (it "sorts"
      (should= [1 3 5 7 10]
             (insert [1 3 5 7] 10))
    (should= result
             (insertion-sort (shuffle (range 1 11))))))

(describe "quick-sort"
  (it "sorts"
    (should= result
             (quick-sort (shuffle (range 1 11))))
    (should= true
             (-> (get-time #(quick-sort (shuffle stress-test)))
                 (< 4.5)))))
