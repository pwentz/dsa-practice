import XCTest
@testable import Zeta_Algorithm

class Zeta_AlgorithmTests: XCTestCase {
  func testCanFormZArray() {
    let a = "aabxaayaab"
    let z = [0, 1, 0, 0, 2, 1, 0, 3, 1, 0]

    XCTAssertEqual(z, zetaAlgorithm(for: a)!)
  }

  func testCanFormZArray1() {
    let a = "abaxabab"
    let z = [0, 0, 1, 0, 3, 0, 2, 0]

    XCTAssertEqual(z, zetaAlgorithm(for: a)!)
  }

  func testCanHandleGivenArguments() {
    let text = "xabcabzabc"
    let pattern = "abc"

    XCTAssertEqual([1, 7], zAlgorithm(for: pattern, in: text))
  }

  func testCanHandleWeirdDnaStrands() {
    let text = "GAGAACATACATGACCAT"
    let pattern = "CATA"

    XCTAssertEqual([5], zAlgorithm(for: pattern, in: text))
  }
}
