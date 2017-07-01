(ns insertion-sort.core-spec
  (:require [speclj.core :refer :all]
            [insertion-sort.core :refer :all]))

(describe "insertion-sort"
  (it "sorts"
    (should= [1 3 5 7 10]
           (insert [1 3 5 7] 10))
    (should= [1 2 3 4 5 6 7 8 9 10]
             (insertion-sort (shuffle (range 1 11))))))
