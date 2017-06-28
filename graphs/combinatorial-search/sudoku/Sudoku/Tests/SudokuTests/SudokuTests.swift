import XCTest
@testable import Sudoku

public func eval(_ lhs: [Array<Int>], _ rhs: [Array<Int>]) {
  guard lhs.count == rhs.count else {
    XCTFail("Arrays should be same length")
    return
  }

  for (idx, elt) in lhs.enumerated() {
    XCTAssertEqual(elt, rhs[idx])
  }
}


class SudokuTests: XCTestCase {
  func testEasyPuzzle() throws {
    // 46 Openings
    // 56 steps
    let originalBoard = [
      [8, 0, 0, 0, 0, 0, 3, 2, 0],
      [0, 7, 0, 3, 0, 4, 9, 6, 8],
      [3, 0, 0, 0, 6, 0, 5, 0, 0],
      [0, 0, 0, 8, 3, 1, 4, 0, 0],
      [4, 0, 0, 0, 9, 0, 0, 0, 2],
      [0, 0, 1, 4, 2, 5, 0, 0, 0],
      [0, 0, 8, 0, 5, 0, 0, 0, 6],
      [1, 2, 3, 6, 0, 7, 0, 5, 0],
      [0, 5, 7, 0, 0, 0, 0, 0, 4]
    ]

    let solutionBoard = [
      [8, 6, 4, 5, 7, 9, 3, 2, 1],
      [5, 7, 2, 3, 1, 4, 9, 6, 8],
      [3, 1, 9, 2, 6, 8, 5, 4, 7],
      [2, 9, 6, 8, 3, 1, 4, 7, 5],
      [4, 3, 5, 7, 9, 6, 1, 8, 2],
      [7, 8, 1, 4, 2, 5, 6, 9, 3],
      [9, 4, 8, 1, 5, 2, 7, 3, 6],
      [1, 2, 3, 6, 4, 7, 8, 5, 9],
      [6, 5, 7, 9, 8, 3, 2, 1, 4]
    ]

    let solver = SudokuSolver()

    let result = solver.solve(for: originalBoard)

    eval(result, solutionBoard)
  }

  func testEasyMediumPuzzle() {
    // // 42 Openings
    // // 142 steps
    // let original = [
    //   [8, 0, 0, 7, 5, 0, 0, 0, 3],
    //   [0, 3, 0, 0, 4, 8, 0, 2, 0],
    //   [1, 0, 0, 0, 0, 0, 0, 0, 6],
    //   [3, 4, 0, 0, 7, 0, 0, 0, 8],
    //   [7, 9, 0, 4, 8, 0, 0, 3, 1],
    //   [2, 0, 8, 0, 0, 0, 0, 7, 4],
    //   [5, 0, 0, 8, 1, 4, 0, 0, 7],
    //   [0, 8, 0, 3, 2, 7, 0, 4, 0],
    //   [4, 0, 0, 5, 6, 9, 0, 0, 2]
    // ]

    // let solution = [
    //   [8, 6, 2, 7, 5, 1, 4, 9, 3],
    //   [9, 3, 7, 6, 4, 8, 1, 2, 5],
    //   [1, 5, 4, 2, 9, 3, 7, 8, 6],
    //   [3, 4, 6, 1, 7, 2, 9, 5, 8],
    //   [7, 9, 5, 4, 8, 6, 2, 3, 1],
    //   [2, 1, 8, 9, 3, 5, 6, 7, 4],
    //   [5, 2, 9, 8, 1, 4, 3, 6, 7],
    //   [6, 8, 1, 3, 2, 7, 5, 4, 9],
    //   [4, 7, 3, 5, 6, 9, 8, 1, 2]
    // ]

    // let solver = SudokuSolver()

    // let result = solver.solve(for: original)

    // eval(result, solution)
  }

  func testMediumPuzzle() {
    // // 54 Openings
    // // ~2300 steps
    // let problem = [
    //   [0, 7, 0, 0, 0, 0, 0, 0, 9],
    //   [0, 0, 0, 7, 0, 0, 5, 0, 0],
    //   [0, 3, 2, 0, 5, 0, 0, 8, 0],
    //   [0, 0, 7, 6, 3, 0, 0, 5, 4],
    //   [0, 0, 0, 0, 8, 0, 0, 0, 0],
    //   [3, 6, 0, 0, 9, 5, 2, 0, 0],
    //   [0, 2, 0, 0, 1, 0, 7, 3, 0],
    //   [0, 0, 4, 3, 0, 0, 0, 0, 0],
    //   [1, 0, 0, 0, 0, 0, 0, 9, 0]
    // ]

    // let solution = [
    //   [5, 7, 1, 8, 2, 6, 3, 4, 9],
    //   [8, 9, 6, 7, 4, 3, 5, 1, 2],
    //   [4, 3, 2, 9, 5, 1, 6, 8, 7],
    //   [9, 1, 7, 6, 3, 2, 8, 5, 4],
    //   [2, 4, 5, 1, 8, 7, 9, 6, 3],
    //   [3, 6, 8, 4, 9, 5, 2, 7, 1],
    //   [6, 2, 9, 5, 1, 4, 7, 3, 8],
    //   [7, 8, 4, 3, 6, 9, 1, 2, 5],
    //   [1, 5, 3, 2, 7, 8, 4, 9, 6]
    // ]

    // let solver = SudokuSolver()

    // let result = solver.solve(for: problem)

    // eval(result, solution)
  }
}
