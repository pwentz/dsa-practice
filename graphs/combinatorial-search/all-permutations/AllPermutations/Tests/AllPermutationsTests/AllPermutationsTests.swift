import XCTest
@testable import AllPermutations

public func eval(_ lhs: [Array<Int>], _ rhs: [Array<Int>]) {
  guard lhs.count == rhs.count else {
    XCTFail("Arrays should be same length")
    return
  }

  for (idx, elt) in lhs.enumerated() {
    XCTAssertEqual(elt, rhs[idx])
  }
}

class AllPermutationsTests: XCTestCase {
    func testAllPermutations() {
        let input = 3

        let result = PermutationsConstructor(for: input).build()
        print(result)

        let expectedOutput = [
          [1, 2, 3],
          [1, 3, 2],
          [2, 1, 3],
          [2, 3, 1],
          [3, 1, 2],
          [3, 2, 1]
        ]

        eval(result, expectedOutput)
    }
}
