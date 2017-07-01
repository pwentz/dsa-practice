(ns all-permutations.core-spec
  (:require [speclj.core :refer :all]
            [all-permutations.core :refer :all]))

(describe "construct-solution"
  (it "constructs a solution"
    (should= [1 2]
             (construct-solution [0 3 0 0] 2 3))))

(describe "all-permutations"
  (it "returns all permutations of given input n"
    (let [result [[1 2 3]
                  [1 3 2]
                  [2 1 3]
                  [2 3 1]
                  [3 1 2]
                  [3 2 1]]]
      (should= result
               (all-permutations 3)))))
