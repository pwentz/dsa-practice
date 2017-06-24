let TRUE: Int = 1
let FALSE: Int = 0

class PermutationsConstructor {
  private let input: Int
  private var solutions: [Array<Int>] = []

  init(for input: Int) {
    self.input = input
  }

  func build() -> [Array<Int>] {
    var a: [Int] = Array(repeating: FALSE, count: input + 1)

    backtrack(&a, 0)

    return solutions
  }

  private func isASolution(_ a: [Int], _ k: Int, _ n: Int) -> Bool {
    return k == n
  }

  private func constructCandidates(_ a: [Int], _ k: Int, c: inout [Int], nCandidates: inout Int) {
    var inPerm: [Int] = Array(repeating: FALSE, count: input + 1)

    for i in 1..<inPerm.count {
      inPerm[i] = FALSE
    }

    for i in 0..<k {
      inPerm[a[i]] = TRUE
    }

    nCandidates = 0

    for i in 1...input {
      if inPerm[i] == FALSE {
        c[nCandidates] = i
        nCandidates+=1
      }
    }
  }

  private func processSolution(_ a: [Int], _ k: Int) {
    var newSolution: [Int] = []

    for i in 1...k {
      newSolution.append(a[i])
    }

    solutions.append(newSolution)
  }

  private func backtrack(_ a: inout [Int], _ k: Int) {
    print("K", k)
    print("A", a.dropFirst())
    print("------------")
    var candidates = Array(repeating: FALSE, count: input + 1)
    var nCandidates = 0

    if isASolution(a, k, input) {
      processSolution(a, k)
    } else {

      constructCandidates(a, k + 1, c: &candidates, nCandidates: &nCandidates)

      for i in 0..<nCandidates {
        a[k + 1] = candidates[i]
        backtrack(&a, k + 1)
      }
    }
  }
}
