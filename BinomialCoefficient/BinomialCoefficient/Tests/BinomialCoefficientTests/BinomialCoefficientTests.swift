import XCTest
@testable import BinomialCoefficient

class BinomialCoefficientTests: XCTestCase {
    func testItDoesBasicNumbers() {
        XCTAssertEqual(28, binomialCoefficient(8, choose: 2))
    }

    func xtestItDoesLargerNumbers() {
        XCTAssertEqual(155117520, binomialCoefficient(30, choose: 15))
    }
}
