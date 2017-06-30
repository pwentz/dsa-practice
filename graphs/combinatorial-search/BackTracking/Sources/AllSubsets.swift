class SubsetConstructor: Backtrackable {
  private let input: Int
  private var solutions: Set<Set<Int>> = []
  private let TRUE: Int = 1
  private let FALSE: Int = 0
  var finished = false

  init(for input: Int) {
    self.input = input
  }

  func build() -> Set<Set<Int>> {
    var a = Array(repeating: FALSE, count: input + 1)

    var temp: Any = input

    backtrack(a, 0, &temp)

    return solutions
  }

  func makeMove(_ a: [Int], _ k: Int, _ input: inout Any) { }
  func unmakeMove(_ a: [Int], _ k: Int, _ input: inout Any) { }

  func isASolution(_ a: [Int], _ k: Int, _ input: Any) -> Bool {
    let n: Int = input as! Int
    return k == n
  }

  func constructCandidates(_ a: [Int], _ k: Int, _ input: inout Any) -> [Int] {
    return [TRUE, FALSE]
  }

  func processSolution(_ a: [Int], _ k: Int, _ input: Any) {
    var newSolution: Set<Int> = []

    for i in 1...k {
      if a[i] == TRUE {
        newSolution.insert(i)
      }
    }

    solutions.insert(newSolution)
  }
}
