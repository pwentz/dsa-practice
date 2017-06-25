class PermutationsConstructor {
  public var solutions: [Array<Int>] = []
  private let input: Int
  private let TRUE: Int = 1
  private let FALSE: Int = 0

  private var defaultArr: [Int] {
    return Array(repeating: FALSE, count: input + 1)
  }

  init(for input: Int) {
    self.input = input
  }

  func build() -> PermutationsConstructor {
    var a = defaultArr
    backtrack(&a, 0)

    return self
  }

  private func isASolution(_ a: [Int], _ k: Int, _ n: Int) -> Bool {
    return k == n
  }

  private func constructCandidates(_ a: [Int], _ k: Int) -> [Int] {
    var inPerm: [Int] = defaultArr
    var c: [Int] = []

    for i in 0..<k {
      let explored = a[i]
      inPerm[explored] = TRUE
    }

    for i in 1...input {
      if inPerm[i] == FALSE {
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

  private func backtrack(_ a: inout [Int], _ k: Int) {
    if isASolution(a, k, input) {
      processSolution(a, k)
    } else {
      let candidates = constructCandidates(a, k + 1)

      candidates.forEach { candidate in
        a[k + 1] = candidate
        backtrack(&a, k + 1)
      }
    }
  }
}
