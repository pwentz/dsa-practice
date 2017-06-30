struct BoardType {
  var m: [Array<Int>]

  var freeCount: Int = NCELLS

  public var moves: [(x: Int, y: Int)] = Array(
    repeating: (x: 0, y: 0),
    count: NCELLS + 1
  )

  init(for board: [Array<Int>]) {
    self.m = board
    self.freeCount = board.reduce(0, { freeSpaces, row in
      freeSpaces + row.filter { $0 == 0 }.count
    })
  }
}

