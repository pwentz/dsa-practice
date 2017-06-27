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
}

