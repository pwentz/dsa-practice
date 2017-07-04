(ns z-algorithm.core-spec
  (:require [speclj.core :refer :all]
            [z-algorithm.core :as sut]))

(def z-expand #'sut/z-expand)
(def z-array #'sut/z-array)
(def z-algorithm sut/z-algorithm)

(describe "z-expand"
  (it "expands the z-box:"
    (should= [\a \a \b]
             (z-expand "aabxaayaab" 7))))

(describe "z-array"
  (it "can return z-array"
    (should= [0 1 0 0 2 1 0 3 1 0]
             (z-array "aabxaayaab")))

  (it "can return z array again"
    (should= [0 0 1 0 3 0 2 0]
             (z-array "abaxabab"))))

(describe "z-algorithm"
  (it "can handle given args"
    (should= [1 7]
             (z-algorithm "xabcabzabc" "abc")))

  (it "can do other stuff"
    (should= [5]
             (z-algorithm "GAGAACATACATGACCAT" "CATA"))))
