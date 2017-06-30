public var BASED: Int = 3
public var DIMENSION: Int { return BASED * BASED }
public var NCELLS: Int { return DIMENSION * DIMENSION }

class SudokuSolver {
  private var finished = false
  private var steps = 0

  func processSolution(_ a: [Int], _ k: Int, _ board: BoardType) {
    printBoard(board)
    print("This solution took \(steps) steps to complete")
    self.finished = true
  }

  func isASolution(_ a: [Int], _ k: Int, _ board: BoardType) -> Bool {
    steps += 1
    return board.freeCount == 0
  }

  func possibleValues(_ x: Int, _ y: Int, _ board: BoardType) -> [Bool] {
    var possibilities = Array(repeating: false, count: DIMENSION + 1)
    let isSquareInvalid = board.m[x][y] != 0 || (x < 0 || y < 0)

    for i in 1...DIMENSION {
      possibilities[i] = !isSquareInvalid
    }

    for i in 0..<DIMENSION {
      let cellToRight = board.m[x][i]
      let cellBelow = board.m[i][y]

      if cellToRight != 0 {
        possibilities[cellToRight] = false
      }

      if cellBelow != 0 {
        possibilities[cellBelow] = false
      }
    }

    let xLow = BASED * (x / BASED)
    let yLow = BASED * (y / BASED)

    for i in xLow..<(xLow + BASED) {
      for j in yLow..<(yLow + BASED) {
        let cellInSector = board.m[i][j]

        if cellInSector != 0 {
          possibilities[cellInSector] = false
        }
      }
    }

    return possibilities
  }

  func possibleCount(_ x: Int, _ y: Int, _ board: BoardType) -> Int {
    return possibleValues(x, y, board).filter { $0 }.count
  }

  func nextSquare(_ board: BoardType) -> (Int, Int) {
    var x = -1
    var y = -1

    for i in 0..<DIMENSION {
      for j in 0..<DIMENSION {
        let possibilitiesForSquare = possibleCount(i, j, board)

        if possibilitiesForSquare == 0 && board.m[i][j] == 0 {
          return (-1, -1)
        }

        if 0 < possibilitiesForSquare && board.m[i][j] == 0 {
          x = i
          y = j
        }

      }
    }

    return (x, y)
  }

  func constructCandidates(_ a: [Int], _ k: Int, _ board: inout BoardType) -> [Int] {
    var c: [Int] = []

    let (x, y) = nextSquare(board)

    if (x < 0 && y < 0) {
      return c
    }

    board.moves[k] = (x, y)

    let possibilities = possibleValues(x, y, board)

    for i in 1...DIMENSION {
      if possibilities[i] {
        c.append(i)
      }
    }

    return c
  }

  func makeMove(_ a: [Int], _ k: Int, _ board: inout BoardType) {
    let (x, y) = board.moves[k]

    if board.m[x][y] == 0 {
      board.freeCount -= 1
    }

    board.m[x][y] = a[k]
  }

  func unmakeMove(_ a: [Int], _ k: Int, _ board: inout BoardType) {
    let (x, y) = board.moves[k]

    if board.m[x][y] != 0 {
      board.freeCount += 1
    }


    board.m[x][y] = 0
  }

  func backtrack(_ a: [Int], _ k: Int, _ board: inout BoardType) {
    if isASolution(a, k, board) {
      processSolution(a, k, board)
    } else {
      let j = k + 1
      var b = a
      var candidates = constructCandidates(a, j, &board)

      for i in 0..<candidates.count {
        b[j] = candidates[i]

        makeMove(b, j, &board)

        backtrack(b, j, &board)

        if finished { return }

        unmakeMove(b, j, &board)
      }
    }
  }

  func solve(for rows: [Array<Int>]) -> [Array<Int>] {
    var board = BoardType(for: rows)
    printBoard(board)
    let a = Array(repeating: 0, count: NCELLS + 1)

    backtrack(a, 0, &board)

    return board.m
  }
}
