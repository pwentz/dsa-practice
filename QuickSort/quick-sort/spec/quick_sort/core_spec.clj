(ns quick-sort.core-spec
  (:require [speclj.core :refer :all]
            [quick-sort.core :refer :all]))

(def result [1 2 3 4 5 6 7 8 9 10])
(def stress-test (range 100000))

(defn get-time [f]
  (let [full-out (with-out-str (time (doall (f))))
        time-str (subs full-out (inc (.indexOf full-out ":")) (.indexOf full-out "msecs"))]
    (/ (read-string time-str) 1000)))

(describe "quick-sort"
  (it "sorts lists"
    (should= result
             (q-sort-custom (shuffle (range 1 11)))))

  (it "can sort 100,000 items in under 2s"
    (should= true
             (-> (get-time #(q-sort-custom (shuffle stress-test)))
                 (< 2)))))
