(ns fibonacci-numbers.core-spec
  (:require [speclj.core :refer :all]
            [fibonacci-numbers.core :refer :all]
            [fibonacci-numbers.caching :as cache]
            [fibonacci-numbers.dp :as dp]))

(describe "fibonacci"
  (it "does first 20"
    (should= 6765
             (fibonacci 20)))

  (xit "doess first 45"
    ; 230.8s ~= 4 minutes
    (should= 1134903170
             (time (fibonacci 45)))))

(describe "fibonacci-caching"
  (before (reset! cache/f []))
  (after (reset! cache/f []))

  (it "does first 45"
    ; 0.07ms
    (should= 1134903170
             (time (cache/driver 45)))))

(describe "fibonacci-dp"
  ; 0.27ms
  (it "does first 45"
    (should= 1134903170
             (time (dp/fibonacci 45)))))
