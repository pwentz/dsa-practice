import XCTest
@testable import BoyerMoore

class BoyerMooreTests: XCTestCase {

  func testBackwards() {
    let s = "Hello, World!"
    let p = "World"

    let idx = s.index(s.startIndex, offsetBy: 11)
    let res = s.index(s.startIndex, offsetBy: 7)

    let output = s.backwards(p.index(before: p.endIndex), p, idx)

    XCTAssertEqual(res, output)
  }

  func testBackwardsOne() {
    let s = "Hello from down under!"
    let p = "World"

    let idx = s.index(s.startIndex, offsetBy: 11)

    let output = s.backwards(p.index(before: p.endIndex), p, idx)

    XCTAssertNil(output)
  }

  func testItGetsTheIndex() {
    let s = "Hello, World!"

    let res = s.index(s.startIndex, offsetBy: 7)

    XCTAssertEqual(res, s.indexOf("World"))
  }
}

// Hello, World!
//     ^
// World

// Hello, World!
//     ^
//    World

// Hello, World!
//            ^
//        World
