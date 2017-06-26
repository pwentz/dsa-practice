private var TRUE: Int = 1
private var FALSE: Int = 0
private var BASED: Int = 3
private var MAX_CANDIDATES: Int = 100
private var NMAX: Int = 100
private var DIMENSION: Int { return BASED * BASED }
private var NCELLS: Int { return DIMENSION * DIMENSION }

struct Point {
  var x: Int
  var y: Int
}

struct BoardType {
  var m: [Array<Int>]

  var freeCount: Int = NCELLS

  public var move: [Point] = Array(
    repeating: Point(x: 0, y: 0),
    count: NCELLS + 1
  )

  init(for board: [Array<Int>]) {
    self.m = board
    self.freeCount = board.reduce(0, { freeSpaces, row in
      freeSpaces + row.filter { $0 == 0 }.count
    })
  }

  public mutating func updateMove(at idx: Int, x: Int, y: Int) {
    guard (x >= 0) && (y >= 0) else {
      return
    }

    move[idx] = Point(x: x, y: y)
  }

  func findCell(x: Int, y: Int) -> Int {
    guard (x > 0) && (y > 0) else {
      return FALSE
    }

    return m[x][y]
  }

  public mutating func updateCell(with v: Int, x: Int, y: Int) {
    m[x][y] = v
  }

  public mutating func decrementFreeCount() {
    freeCount -= 1
  }

  public mutating func incrementFreeCount() {
    freeCount += 1
  }
}

class SudokuSolver {
  typealias bool = Int

  private var steps: Int = 0
  private var finished: Bool = false
  private var fast: bool = TRUE
  private var smart: bool = TRUE

  public var solution: BoardType?

  func isASolution(_ a: [Int], _ k: Int, _ board: BoardType) -> Bool {
    self.steps += 1

    if board.freeCount == 0 {
      return true
    }

    return false
  }

  func processSolution(_ a: [Int], _ k: Int, _ board: BoardType) {
    self.finished = true

    self.solution = board
  }

  func possibleValues(_ x: Int, _ y: Int, _ board: BoardType) -> [Int] {
    var possibilities = Array(repeating: FALSE, count: DIMENSION + 1)
    var initiate = FALSE

    let xLow = BASED * (x / BASED)
    let yLow = BASED * (y / BASED)

    if board.findCell(x: x, y: y) != 0 || (x < 0 || y < 0) {
      initiate = FALSE
    } else {
      initiate = TRUE
    }

    for i in 1...DIMENSION {
      possibilities[i] = initiate
    }

    for i in 0..<DIMENSION {
      let cell = board.findCell(x: x, y: i)
      if cell != 0 {
        possibilities[cell] = FALSE
      }
    }

    for i in 0..<DIMENSION {
      let cell = board.findCell(x: i, y: y)
      if cell != 0 {
        possibilities[cell] = FALSE
      }
    }

    for i in xLow..<(xLow + BASED) {
      for j in yLow..<(yLow + BASED) {
        let cell = board.findCell(x: i, y: j)
        if cell != 0 {
          possibilities[cell] = FALSE
        }
      }
    }

    return possibilities
  }

  func possibleCount(_ x: Int, _ y: Int, _ board: BoardType) -> Int {
    var possibilities = possibleValues(x, y, board)
    var count = 0

    for i in 0...DIMENSION {
      if possibilities[i] == TRUE {
        count+=1
      }
    }

    return count
  }

  func nextSquare(_ board: BoardType) -> (Int, Int) {
    var bestCount = DIMENSION + 1
    var newCount = 0
    var doomed = FALSE

    var x = -1
    var y = -1

    for i in 0..<DIMENSION {
      for j in 0..<DIMENSION {
        newCount = possibleCount(i, j, board)

        if newCount == 0 && board.findCell(x: i, y: j) == 0 {
          doomed = TRUE
        }

        if fast == TRUE {
          if newCount < bestCount && 1 <= newCount {
            bestCount = newCount
            x = i
            y = j
          }
        }

        if fast == FALSE {
          if 1 <= newCount && board.findCell(x: i, y: j) == 0 {
            x = i
            y = j
          }
        }
      }
    }

    if doomed == TRUE && smart == TRUE {
      x = -1
      y = -1
    }

    return (x, y)
  }

  func fillSquare(_ x: Int, _ y: Int, _ v: Int, _ board: inout BoardType) {
    if board.findCell(x: x, y: y) == 0 {
      board.decrementFreeCount()
    }

    board.updateCell(with: v, x: x, y: y)
  }

  func freeSquare(_ x: Int, _ y: Int, _ board: inout BoardType) {
    if board.findCell(x: x, y: y) != 0 {
      board.incrementFreeCount()
    }

    board.updateCell(with: 0, x: x, y: y)
  }

  func makeMove(_ a: [Int], _ k: Int, _ board: inout BoardType) {
    let pnt = board.move[k]
    fillSquare(pnt.x, pnt.y, a[k], &board)
  }

  func unmakeMove(_ a: [Int], _ k: Int, _ board: inout BoardType) {
    let pnt = board.move[k]
    freeSquare(pnt.x, pnt.y, &board)
  }

  func constructCandidates(_ a: [Int], _ k: Int, _ board: inout BoardType, _ nCandidates: inout Int) -> [Int] {
    var c: [Int] = Array(repeating: 0, count: DIMENSION + 1)

    let (x, y) = nextSquare(board)

    board.updateMove(at: k, x: x, y: y)

    nCandidates = 0

    if (x < 0 && y < 0) {
      return c
    }

    let possible = possibleValues(x, y, board)

    for i in 1...DIMENSION {
      if possible[i] == TRUE {
        c[nCandidates] = i
        nCandidates += 1
      }
    }

    return c
  }

  func backtrack(_ a: [Int], _ k: Int, board: inout BoardType) {
    var nCandidates = 0

    if isASolution(a, k, board) {
      processSolution(a, k, board)
    } else {
      let j = k + 1
      var c = constructCandidates(a, j, &board, &nCandidates)
      var b = a

      for i in 0..<nCandidates {
        b[j] = c[i]
        makeMove(b, j, &board)

        backtrack(b, j, board: &board)

        if finished { return }

        unmakeMove(b, j, &board)
      }
    }
  }

  func solve(for rows: [Array<Int>]) {
    let a = Array(repeating: FALSE, count: NCELLS + 1)
    var board = BoardType(for: rows)

    while fast >= FALSE {
      while smart >= FALSE {
        backtrack(a, 0, board: &board)
        smart -= 1
      }
      fast -= 1
    }
  }
}
