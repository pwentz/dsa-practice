(ns all-subsets.core-spec
  (:require [speclj.core :refer :all]
            [all-subsets.core :refer :all]))

(describe "all-subsets"
  (it "constructs all subsets when n = 3"
    (let [result #{#{1 2 3} #{1 2}
                   #{1 3} #{2 3} #{1}
                   #{2} #{3} #{}}]
      (should= result
               (all-subsets 3))))

  (it "constructs subsets when n = 4"
    (let [result #{
           #{1 2 3 4}, #{2 3 4}, #{1 3 4}, #{1 2 4},
           #{1 2 3}, #{1 2}, #{1 3}, #{1 4},
           #{2 3}, #{2 4}, #{3 4}, #{1},
           #{2}, #{3}, #{4}, #{}
         }]
      (should= result
               (all-subsets 4)))))
