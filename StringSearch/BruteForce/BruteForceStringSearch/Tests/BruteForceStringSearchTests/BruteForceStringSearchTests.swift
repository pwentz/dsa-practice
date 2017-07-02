import XCTest
@testable import BruteForceStringSearch

class BruteForceStringSearchTests: XCTestCase {
  func testItReturnsIndexOfSubstring() {
    let s = "Hello, World!"
    let res = s.index(s.startIndex, offsetBy: 7)
    XCTAssertEqual(res, s.indexOf("World"))
  }
}
