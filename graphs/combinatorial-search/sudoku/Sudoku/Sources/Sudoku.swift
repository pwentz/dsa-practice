public var BASED: Int = 3
public var MAX_CANDIDATES: Int = 100
public var NMAX: Int = 100
public var DIMENSION: Int { return BASED * BASED }
public var NCELLS: Int { return DIMENSION * DIMENSION }

class SudokuSolver {
  private var steps: Int = 0
  private var finished: Bool = false

  func isASolution(_ a: [Int], _ k: Int, _ board: BoardType) -> Bool {
    self.steps += 1

    if board.freeCount == 0 {
      return true
    }

    return false
  }

  func processSolution(_ a: [Int], _ k: Int, _ board: BoardType) {
    self.finished = true

    printBoard(board)
  }

  func possibleValues(_ x: Int, _ y: Int, _ board: BoardType) -> [Bool] {
    var possibilities = Array(repeating: false, count: DIMENSION + 1)

    let isSquareInvalid = board.m[x][y] != 0 || (x < 0 || y < 0)

    let initiate = isSquareInvalid ? false : true

    // TODO: THIS STEP SAVES PERFORMANCE BY ORDERS OF MAGNITUDE THAN SIMPLY
    // Array(repeating: isSquareInitialized ? false : true)
    for i in 1...DIMENSION {
      possibilities[i] = initiate
    }

    for i in 0..<DIMENSION {
      let cellInRow = board.m[x][i]
      let cellInCol = board.m[i][y]

      if cellInRow != 0 {
        possibilities[cellInRow] = false
      }

      if cellInCol != 0 {
        possibilities[cellInCol] = false
      }
    }

    // coords to top left of sector that x,y square is in
    let xLow = BASED * (x / BASED)
    let yLow = BASED * (y / BASED)

    // Search the sector for taken cells
    for i in xLow..<(xLow + BASED) {
      for j in yLow..<(yLow + BASED) {
        let cell = board.m[i][j]
        if cell != 0 {
          possibilities[cell] = false
        }
      }
    }

    return possibilities
  }

  func possibleCount(_ x: Int, _ y: Int, _ board: BoardType) -> Int {
    return possibleValues(x, y, board).filter { $0 }.count
  }

  func nextSquare(_ board: BoardType) -> (Int, Int) {
    var shouldPrune = false

    var x = -1
    var y = -1

    for i in 0..<DIMENSION {
      for j in 0..<DIMENSION {
        // PRUNING
        let newCount = possibleCount(i, j, board)

        // If no possible candidates, and value is empty...set to false

        //TODO: TAKES MORE STEPS WHEN EARLY RETURNING THAN IF SETTING VARS TO LAST INSTANCE
        // LEADS TO CLOSER PROXIMITY BETWEEN ANSWERS?!?!
        if newCount == 0 && board.m[i][j] == 0 {
          shouldPrune = true
          // return (-1, -1)
        }

        // If possible candidates and space is open, then update x and y
        if 0 < newCount && board.m[i][j] == 0 {
          x = i
          y = j
          //return (i, j)
        }
      }
    }

    // negative values (in constructCandidates) to be skipped
    if shouldPrune {
      x = -1
      y = -1
    }

    return (x, y)
  }

  func makeMove(_ a: [Int], _ k: Int, _ board: inout BoardType) {
    let (x, y) = board.move[k]

    if board.m[x][y] == 0 {
      board.freeCount -= 1
    }

    board.m[x][y] = a[k]
  }

  func unmakeMove(_ a: [Int], _ k: Int, _ board: inout BoardType) {
    let (x, y) = board.move[k]

    if board.m[x][y] != 0 {
      board.freeCount += 1
    }

    board.m[x][y] = 0
  }

  func constructCandidates(_ k: Int, _ board: inout BoardType) -> [Int] {
    var c: [Int] = []

    let (x, y) = nextSquare(board)

    board.move[k].x = x
    board.move[k].y = y

    if (x < 0 && y < 0) {
      return c
    }

    let possible = possibleValues(x, y, board)

    for i in 1...DIMENSION {
      if possible[i] {
        c.append(i)
      }
    }

    return c
  }

  func backtrack(_ a: [Int], _ k: Int, board: inout BoardType) {
    if isASolution(a, k, board) {
      processSolution(a, k, board)
    } else {
      let j = k + 1
      var candidates = constructCandidates(j, &board)
      var b = a

      for i in 0..<candidates.count {
        b[j] = candidates[i]
        makeMove(b, j, &board)

        backtrack(b, j, board: &board)

        if finished { return }

        unmakeMove(b, j, &board)
      }
    }
  }

  func solve(for rows: [Array<Int>]) -> [Array<Int>] {
    let a = Array(repeating: 0, count: NCELLS + 1)
    var board = BoardType(for: rows)

    printBoard(board)

    printT("-----------------------------------\n")
    steps = 0
    finished = false
    backtrack(a, 0, board: &board)

    printT("It took \(steps) steps to find this solution")

    return board.m
  }
}
