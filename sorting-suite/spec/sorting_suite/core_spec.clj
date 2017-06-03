(ns sorting-suite.core-spec
  (:require [speclj.core :refer :all]
            (sorting-suite [merge-sort :refer :all]
                           [selection-sort :refer :all])))

(describe "merge-sort"
  (it "sorts"
    (should= [1 2 3]
             (merge-sort [2 1 3]))
    (should= [1 2 3 4 5 6 7 8 9 10]
             (merge-sort (shuffle (range 1 11))))))

(describe "selection-sort"
  (it "sorts"
    (should= [1 2 3 4 5 6 7 8 9 10]
             (selection-sort (shuffle (range 1 11))))))
