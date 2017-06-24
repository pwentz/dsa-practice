import XCTest
@testable import AllSubsets

class AllSubsetsTests: XCTestCase {
    func testAllSubsetsWhereNIs3() {
      let input = 3

      let subsetConstructor = SubsetConstructor(for: input)

      let output: Set<Set<Int>> = [[], [1], [1, 2], [2], [2, 3], [1, 2, 3], [1, 3], [3]]

      XCTAssertEqual(subsetConstructor.build(), output)
    }

    func testAllSubsetsWhereNIs4() {
      let input = 4

      let subsetConstructor = SubsetConstructor(for: input)


      let output: Set<Set<Int>> = [
        [1, 2, 3, 4], [2, 3, 4], [1, 3, 4], [1, 2, 4],
        [1, 2, 3], [1, 2], [1, 3], [1, 4],
        [2, 3], [2, 4], [3, 4], [1],
        [2], [3], [4], []
      ]

      XCTAssertEqual(subsetConstructor.build(), output)
    }
}
