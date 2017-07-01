import XCTest
@testable import FibonacciNumbers

class FibonacciNumbersTests: XCTestCase {
  func testTen() {
    XCTAssertEqual(fibonacciNumbers(for: 10), 55)
  }

  func testTwentyOne() {
    XCTAssertEqual(fibonacciNumbers(for: 20), 6765)
  }

  func xtestFortyFive() {
    // 16 seconds
    XCTAssertEqual(fibonacciNumbers(for: 45), 1134903170)
  }

  func testCaching() {
    // .093 seconds
    XCTAssertEqual(fibonacciCachingDriver(for: 45), 1134903170)
  }

  func testDP() {
    // 0.001 seconds
    XCTAssertEqual(fibonacciDP(for: 45), 1134903170)
  }
}
