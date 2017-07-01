(ns sudoku-solver.core-spec
  (:require [speclj.core :refer :all]
            [sudoku-solver.core :as sut]))

(def easy-board
  [[8 0 0 0 0 0 3 2 0]
   [0 7 0 3 0 4 9 6 8]
   [3 0 0 0 6 0 5 0 0]
   [0 0 0 8 3 1 4 0 0]
   [4 0 0 0 9 0 0 0 2]
   [0 0 1 4 2 5 0 0 0]
   [0 0 8 0 5 0 0 0 6]
   [1 2 3 6 0 7 0 5 0]
   [0 5 7 0 0 0 0 0 4]])

(def easy-medium-board
  [[8 0 0 7 5 0 0 0 3]
   [0 3 0 0 4 8 0 2 0]
   [1 0 0 0 0 0 0 0 6]
   [3 4 0 0 7 0 0 0 8]
   [7 9 0 4 8 0 0 3 1]
   [2 0 8 0 0 0 0 7 4]
   [5 0 0 8 1 4 0 0 7]
   [0 8 0 3 2 7 0 4 0]
   [4 0 0 5 6 9 0 0 2]])

(def medium-board
  [[0 7 0 0 0 0 0 0 9]
   [0 0 0 7 0 0 5 0 0]
   [0 3 2 0 5 0 0 8 0]
   [0 0 7 6 3 0 0 5 4]
   [0 0 0 0 8 0 0 0 0]
   [3 6 0 0 9 5 2 0 0]
   [0 2 0 0 1 0 7 3 0]
   [0 0 4 3 0 0 0 0 0]
   [1 0 0 0 0 0 0 9 0]])

(def free-count #'sut/free-count)
(def possible-values #'sut/possible-values)
(def next-square #'sut/next-square)
(def construct-candidates #'sut/construct-candidates)

(describe "board"
  (it "can return number of openings"
    (should= 46
             (free-count easy-board))))

(describe "possible-values"
  (it "returns all possible values given x and y"
      (should= [false false true false false true false false false false]
               (possible-values {:x 1 :y 2} easy-board))))

(describe "next-square"
  (it "returns the last legal open square that can be taken"
      (should= {:x 8 :y 7}
               (next-square easy-board))))

(describe "construct-candidates"
  (it "returns the possible candidates for the next square"
    (let [{:keys [candidates moves]} (construct-candidates 0 easy-board [])]
      (should= [1 3 8 9]
               candidates)
      (should= [{:x 8 :y 7}]
               moves))))

(describe "easy puzzle"
  (it "has 46 openings"
    (let [soln [[8 6 4 5 7 9 3 2 1]
                [5 7 2 3 1 4 9 6 8]
                [3 1 9 2 6 8 5 4 7]
                [2 9 6 8 3 1 4 7 5]
                [4 3 5 7 9 6 1 8 2]
                [7 8 1 4 2 5 6 9 3]
                [9 4 8 1 5 2 7 3 6]
                [1 2 3 6 4 7 8 5 9]
                [6 5 7 9 8 3 2 1 4]]]
      (should= soln
               (sut/solve easy-board)))))

(describe "easy-medium puzzle"
  (it "has 42 openings"
    (let [soln [[8 6 2 7 5 1 4 9 3]
                [9 3 7 6 4 8 1 2 5]
                [1 5 4 2 9 3 7 8 6]
                [3 4 6 1 7 2 9 5 8]
                [7 9 5 4 8 6 2 3 1]
                [2 1 8 9 3 5 6 7 4]
                [5 2 9 8 1 4 3 6 7]
                [6 8 1 3 2 7 5 4 9]
                [4 7 3 5 6 9 8 1 2]]]
      (should= soln
               (sut/solve easy-medium-board)))))

(describe "medium puzzle"
  (it "has 54 openings"
    (let [soln [[5 7 1 8 2 6 3 4 9]
                [8 9 6 7 4 3 5 1 2]
                [4 3 2 9 5 1 6 8 7]
                [9 1 7 6 3 2 8 5 4]
                [2 4 5 1 8 7 9 6 3]
                [3 6 8 4 9 5 2 7 1]
                [6 2 9 5 1 4 7 3 8]
                [7 8 4 3 6 9 1 2 5]
                [1 5 3 2 7 8 4 9 6]]]
      (should= soln
               (sut/solve medium-board)))))
