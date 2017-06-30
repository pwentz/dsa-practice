import XCTest
@testable import BackTracking

class AllPermutationsTests: XCTestCase {
    func testAllPermutations() {
        let input = 3

        let permutations = PermutationsConstructor().build(for: input)

        let expectedOutput = [
          [1, 2, 3],
          [1, 3, 2],
          [2, 1, 3],
          [2, 3, 1],
          [3, 1, 2],
          [3, 2, 1]
        ]

        eval(permutations, expectedOutput)
    }
}
