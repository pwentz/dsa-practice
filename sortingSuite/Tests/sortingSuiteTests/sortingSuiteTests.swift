import XCTest
@testable import sortingSuite

class sortingSuiteTests: XCTestCase {

  func testMergeSort() {
    let shortList = [2, 3, 4, 1]

    XCTAssertEqual([1, 2, 3, 4], mergeSort(shortList))
  }
}
