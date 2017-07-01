import XCTest
@testable import MergeSort

class MergeSortTests: XCTestCase {

  let shortList = [2, 3, 4, 1]
  let shortResult = [1, 2, 3, 4]

  let medList = [35, 4, 15, 12, 1, 3, 7, 22, 7, 23, 20, 18, 13]
  let medRes = [1, 3, 4, 7, 7, 12, 13, 15, 18, 20, 22, 23, 35]

  func testShortLists() {
    XCTAssertEqual(shortResult, mergeSort(shortList))
  }

  func testMediumLists() {
    XCTAssertEqual(medRes, mergeSort(medList))
  }
}
