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

  func testInit() throws {
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
}

// ORIGINAL BOARD
// 800 | 000 | 320
// 070 | 304 | 968
// 300 | 060 | 500
// ----------------
// 000 | 831 | 400
// 400 | 090 | 002
// 001 | 425 | 000
// ----------------
// 008 | 050 | 006
// 123 | 607 | 050
// 057 | 000 | 004

// SOLUTION
// 864 | 579 | 321
// 572 | 314 | 968
// 319 | 268 | 547
// ----------------
// 296 | 831 | 475
// 435 | 796 | 182
// 781 | 425 | 693
// ----------------
// 948 | 152 | 736
// 123 | 647 | 859
// 657 | 983 | 214
