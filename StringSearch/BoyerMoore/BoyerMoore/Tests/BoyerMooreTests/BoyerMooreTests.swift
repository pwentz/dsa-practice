import XCTest
@testable import BoyerMoore

class BoyerMooreTests: XCTestCase {
  func testItGetsTheIndex() {
    let s = "Hello, World!"

    let res = s.index(s.startIndex, offsetBy: 7)

    XCTAssertEqual(res, s.indexOf("World"))
  }
}
