func binomialCoefficient(_ n: Int, choose k: Int) -> Int {
  var bc = Array(
    repeating: Array(repeating: 0, count: n + 1),
    count: n + 1
  )

  for i in 0...n {
    bc[i][0] = 1
    bc[i][i] = 1
  }

  for i in 1...n {
    for j in 1..<i {
      bc[i][j] = bc[i - 1][j - 1] + bc[i - 1][j]
    }
  }

  return bc[n][k]
}
