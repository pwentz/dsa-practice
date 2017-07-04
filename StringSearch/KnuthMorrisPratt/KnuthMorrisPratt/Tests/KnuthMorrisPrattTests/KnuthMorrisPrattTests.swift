import XCTest
@testable import KnuthMorrisPratt

class KnuthMorrisPrattTests: XCTestCase {
  func testSuffixPrefixArray() {
    let pattern = "ACTGACTA"

    // Z-array for pattern
    // [0, 0, 0, 0, 3, 0, 0, 1]
    // [0, 0, 0, 0, 0, 0, 3, 1]

    // suffix-prefix in problem
    // A  C  T  G  A  C  T  A
    // 0  0  0  0  0  0  3  1

    XCTAssertEqual([0, 0, 0, 0, 0, 0, 3, 1], getSuffixPrefix(for: pattern))
  }

  func testCanHandleGivenArguments() {
    let text = "xabcabzabc"
    let pattern = "abc"

    XCTAssertEqual([1, 7], text.indicesOf(pattern))
  }

  func testCanHandleWeirdDnaStrands() {
    let text = "GAGAACATACATGACCAT"
    let pattern = "CATA"

    XCTAssertEqual([5], text.indicesOf(pattern))
  }


  func testCanHandleMoreWeirdDnaStrands() {
    let text = "GCACTGACTGACTGACTAG"
    let pattern = "ACTGACTA"

    XCTAssertEqual([10], text.indicesOf(pattern))
  }
}
