class SubsetConstructor {
  private let input: Int
  private var solutions: Set<Set<Int>> = []

  init(for input: Int) {
    self.input = input
  }

  func build() -> Set<Set<Int>> {
    var a: [Bool] = Array(repeating: false, count: input + 1)

    backtrack(&a, 0)

    return solutions
  }

  private func isASolution(_ a: [Bool], _ k: Int, _ n: Int) -> Bool {
    return k == n
  }

  private func constructCandidates() -> [Bool] {
    return [true, false]
  }

  private func processSolution(_ a: [Bool], _ k: Int) {
    var newSolution: Set<Int> = []

    for i in 1...k {
      if a[i] {
        newSolution.insert(i)
      }
    }

    solutions.insert(newSolution)
  }

  private func backtrack(_ a: inout [Bool], _ k: Int) {
    if isASolution(a, k, input) {
      processSolution(a, k)
    } else {
      let candidates = constructCandidates()

      for i in 0..<candidates.count {
        a[k + 1] = candidates[i]
        backtrack(&a, k + 1)
      }
    }
  }
}
