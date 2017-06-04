import XCTest
@testable import sortingSuite

class sortingSuiteTests: XCTestCase {
  let shortList = [2, 3, 4, 1]
  let shortResult = [1, 2, 3, 4]

  let medList = [35, 4, 15, 12, 1, 3, 7, 22, 7, 23, 20, 18, 13]
  let medRes = [1, 3, 4, 7, 7, 12, 13, 15, 18, 20, 22, 23, 35]



  func testMergeSort() {
    XCTAssertEqual(shortResult, mergeSort(shortList))
  }

  func testSelectionSort() {
    XCTAssertEqual(shortResult, selectionSort(shortList))
    XCTAssertEqual(medRes, selectionSort(medList))
  }

  func testInsertionSort() {
    XCTAssertEqual(shortResult, insertionSort(shortList))
  }
}
