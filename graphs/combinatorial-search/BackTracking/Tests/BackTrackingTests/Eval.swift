import XCTest

func eval(_ lhs: [Array<Int>], _ rhs: [Array<Int>]) {
  guard lhs.count == rhs.count else {
    XCTFail("Arrays should be equal length")
    return
  }

  for (idx, elt) in lhs.enumerated() {
    XCTAssertEqual(elt, rhs[idx])
  }
}
