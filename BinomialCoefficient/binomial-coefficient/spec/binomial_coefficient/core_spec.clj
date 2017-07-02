(ns binomial-coefficient.core-spec
  (:require [speclj.core :refer :all]
            [binomial-coefficient.core :refer :all]))

(describe "quick-bc"
  (it "calculates basic numbers"
    (should= 28
             (time
               (quick-bc 8 2))))

  (it "calculates larger numbers"
    (should= 155117520
             (time
               (quick-bc 30 15)))))

(describe "binomial-coefficient"
  (it "calculates basic numbers"
    (should= 28
             (time
               (binomial-coefficient 8 2))))

  (it "calculates larger numbers"
    (should= 155117520
             (time
               (binomial-coefficient 30 15)))))
