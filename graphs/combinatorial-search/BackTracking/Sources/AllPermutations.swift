class PermutationsConstructor {
  public var solutions: [Array<Int>] = []
  var finished = false

  private func defaultArr(_ n: Int) -> [Int] {
    return Array(repeating: 0, count: n + 1)
  }

  func build(for input: Int) -> [Array<Int>] {
    var a = defaultArr(input)
    backtrack(a, 0, input)

    return solutions
  }

  private func isASolution(_ a: [Int], _ k: Int, _ n: Int) -> Bool {
    return k == n
  }

  private func constructCandidates(_ a: [Int], _ k: Int, _ input: Int) -> [Int] {
    var inPerm = Array(repeating: false, count: input + 1)
    var c: [Int] = []

    for i in 0..<k {
      let explored = a[i]
      inPerm[explored] = true
    }

    for i in 1...input {
      if inPerm[i] == false {
        c.append(i)
      }
    }

    return c
  }

  private func processSolution(_ a: [Int], _ k: Int) {
    var newSolution: [Int] = []

    for i in 1...k {
      newSolution.append(a[i])
    }

    solutions.append(newSolution)
  }

  private func backtrack(_ a: [Int], _ k: Int, _ input: Int) {
    if isASolution(a, k, input) {
      processSolution(a, k)
    } else {
      let candidates = constructCandidates(a, k + 1, input)
      var b = a

      candidates.forEach { candidate in
        b[k + 1] = candidate
        backtrack(b, k + 1, input)
      }
    }
  }
}
