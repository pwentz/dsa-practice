
protocol Backtrackable {
  var finished: Bool { get }

  func constructCandidates(_ a: [Int], _ k: Int, _ input: inout Any) -> [Int]

  func processSolution(_ a: [Int], _ k: Int, _ input: Any)

  func isASolution(_ a: [Int], _ k: Int, _ input: Any) -> Bool

  func makeMove(_ a: [Int], _ k: Int, _ input: inout Any)

  func unmakeMove(_ a: [Int], _ k: Int, _ input: inout Any)
}

extension Backtrackable {
  func backtrack(_ a: [Int], _ k: Int, _ input: inout Any) {
    if isASolution(a, k, input) {
      processSolution(a, k, input)
    } else {
      let j = k + 1
      let candidates = constructCandidates(a, k, &input)
      var b = a

      for i in 0..<candidates.count {
        b[j] = candidates[i]

        makeMove(b, j, &input)

        backtrack(b, j, &input)

        if finished { return }

        unmakeMove(b, j, &input)
      }
    }
  }
}
