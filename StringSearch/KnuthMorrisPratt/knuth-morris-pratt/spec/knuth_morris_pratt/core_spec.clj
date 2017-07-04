(ns knuth-morris-pratt.core-spec
  (:require [speclj.core :refer :all]
            [knuth-morris-pratt.core :as sut]))

(def suffix-prefix #'sut/suffix-prefix)
(def knuth-morris-pratt sut/knuth-morris-pratt)

(describe "suffix-prefix"
  (it "takes pattern and returns suffix-prefix"
    (should= [0 0 0 0 0 0 3 1]
             (suffix-prefix "ACTGACTA"))))

(describe "knuth-morris-pratt"
  (it "can do short patterns"
    (should= [1 7]
             (knuth-morris-pratt "xabcabzabc" "abc")))

  (it "can do short patterns"
    (should= [5]
             (knuth-morris-pratt "GAGAACATACATGACCAT" "CATA")))

  (it "can do short patterns"
    (should= [10]
             (knuth-morris-pratt "GCACTGACTGACTGACTAG" "ACTGACTA"))))
