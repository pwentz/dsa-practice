import XCTest
@testable import BinomialCoefficient

class BinomialCoefficientTests: XCTestCase {
    func testItDoesBasicNumbers() {
        XCTAssertEqual(28, binomialCoefficient(8, choose: 2))
    }

    func testItDoesLargerNumbers() {
        XCTAssertEqual(155117520, binomialCoefficient(30, choose: 15))
    }

    func testQuickDoesBasicNumbers() {
        XCTAssertEqual(28, quickBinomialCoefficient(8, choose: 2))
    }

    func testQuickDoesLargerNumbers() {
        XCTAssertEqual(155117520, quickBinomialCoefficient(30, choose: 15))
    }
}
