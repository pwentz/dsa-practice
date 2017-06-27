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
  func testExample() {
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

    let board = BoardType(for: originalBoard)
    XCTAssertEqual(board.freeCount, 46)
  }

  func testEasyPuzzle() throws {
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

    solver.solve(for: originalBoard)

    let result = solver.solution!.m

    eval(result, solutionBoard)
  }

  func testMediumPuzzle() {
    let original = [
      [8, 0, 0, 7, 5, 0, 0, 0, 3],
      [0, 3, 0, 0, 4, 8, 0, 2, 0],
      [1, 0, 0, 0, 0, 0, 0, 0, 6],
      [3, 4, 0, 0, 7, 0, 0, 0, 8],
      [7, 9, 0, 4, 8, 0, 0, 3, 1],
      [2, 0, 8, 0, 0, 0, 0, 7, 4],
      [5, 0, 0, 8, 1, 4, 0, 0, 7],
      [0, 8, 0, 3, 2, 7, 0, 4, 0],
      [4, 0, 0, 5, 6, 9, 0, 0, 2]
    ]

    let solution = [
      [8, 6, 2, 7, 5, 1, 4, 9, 3],
      [9, 3, 7, 6, 4, 8, 1, 2, 5],
      [1, 5, 4, 2, 9, 3, 7, 8, 6],
      [3, 4, 6, 1, 7, 2, 9, 5, 8],
      [7, 9, 5, 4, 8, 6, 2, 3, 1],
      [2, 1, 8, 9, 3, 5, 6, 7, 4],
      [5, 2, 9, 8, 1, 4, 3, 6, 7],
      [6, 8, 1, 3, 2, 7, 5, 4, 9],
      [4, 7, 3, 5, 6, 9, 8, 1, 2]
    ]

    let solver = SudokuSolver()

    solver.solve(for: original)

    let result = solver.solution!.m

    eval(result, solution)
  }
}
