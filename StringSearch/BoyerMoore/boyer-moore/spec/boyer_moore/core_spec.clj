(ns boyer-moore.core-spec
  (:require [speclj.core :refer :all]
            [boyer-moore.core :as bm]))

(def index-from #'bm/index-from)
(def skip-table #'bm/skip-table)
(def boyer-moore bm/boyer-moore)

(describe "index-from"
  (it "returns index of start of substring"
    (let [s           "Hello, World!"
          pattern     "World"
          pattern-end 4
          idx 11]
      (should= 7
               (index-from s idx pattern pattern-end))))

  (it "returns nil if no match"
    (let [s           "Hello from down under!"
          pattern     "World"
          pattern-end 4
          idx 11]
      (should= nil
               (index-from s idx pattern pattern-end)))))


(describe "skip table"
  (it "forms a skip table from given string"
    (should= {\W 4 \o 3 \r 2 \l 1 \d 0}
             (skip-table "World")))

  (it "takes value closest to end when recurring characters"
    (should= {\f 3 \e 1 \l 0}
             (skip-table "feel"))))

(describe "boyer-moore"
  (it "returns the index of a given substring"
    (should= 7
             (boyer-moore "Hello, World!" "World")))

  (it "returns -1 if a given substring is not present"
    (should= -1
             (boyer-moore "Hello from down under!" "World")))

  (it "returns -1 if pattern is longer than string"
    (should= -1
             (boyer-moore "Check" "Check it out!")))

  (it "returns 0 if pattern is equal to string"
    (should= 0
             (boyer-moore "howdy" "howdy"))
    (should= 1
             (boyer-moore "0howdy" "howdy"))))
