import XCTest
@testable import QuickSort

class QuickSortTests: XCTestCase {

  func testShortLists() {
    var shortList = [2, 3, 4, 1]
    let shortResult = [1, 2, 3, 4]

    quicksortHoare(&shortList, low: 0, high: shortList.count - 1)
    XCTAssertEqual(shortResult, shortList)
  }

  func testMedLists() {
    var medList = [35, 4, 15, 12, 1, 3, 7, 22, 7, 23, 20, 18, 13]
    let medRes = [1, 3, 4, 7, 7, 12, 13, 15, 18, 20, 22, 23, 35]

    quicksortHoare(&medList, low: 0, high: medList.count - 1)
    XCTAssertEqual(medRes, medList)
  }
}
