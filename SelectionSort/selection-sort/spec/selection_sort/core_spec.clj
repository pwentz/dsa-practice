(ns selection-sort.core-spec
  (:require [speclj.core :refer :all]
            [selection-sort.core :refer :all]))

(describe "selection-sort"
  (it "sorts"
    (should= (range 1 11)
             (selection-sort (shuffle (range 1 11))))))
