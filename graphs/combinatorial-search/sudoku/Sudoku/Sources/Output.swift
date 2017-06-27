public func printT(_ x: Any) {
  print(x, terminator: "")
}

func printBoard(_ board: BoardType) {
  printT("\nThere are \(board.freeCount) free board positions.\n")

  for i in 0..<DIMENSION {
    for j in 0..<DIMENSION {
      let cell = board.m[i][j]

      if cell == 0 {
        printT(" ")
      } else {
        printT("\(cell)")
      }

      if (j+1) % BASED == 0 {
        printT("|")
      }
    }
    printT("\n")

    if (i + 1) % BASED == 0 {
      for j in 0..<DIMENSION+BASED-1 {
        printT("-")
      }
      printT("\n")
    }
  }
}

