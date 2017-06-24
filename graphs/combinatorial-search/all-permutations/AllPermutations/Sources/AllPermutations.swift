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

  private func constructCandidates(_ a: [Int], _ k: Int) -> (nCandidates: Int, candidates: [Int]) {
    var inPerm: [Int] = defaultArr
    var c: [Int] = defaultArr
    var nCandidates = 0

    for i in 0..<k {
      inPerm[a[i]] = TRUE
    }

    for i in 1...input {
      if inPerm[i] == FALSE {
        c[nCandidates] = i
        nCandidates+=1
      }
    }

    return (nCandidates: nCandidates, candidates: c)
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
      let (nCandidates, candidates) = constructCandidates(a, k + 1)

      for i in 0..<nCandidates {
        a[k + 1] = candidates[i]
        backtrack(&a, k + 1)
      }
    }
  }
}
