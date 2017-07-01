import XCTest
@testable import KruskalsAlgorithm

class UnionFindTests: XCTestCase {
  func testUnionFindFindElement() {
    // setOf will point to element if no parent exists yet
    var unionFind = UnionFind<String>()
    let vertices = ["A", "B", "C", "D", "E", "F", "G"]

    vertices.forEach { unionFind.addSetWith($0) }

    let parentOfB = unionFind.setOf("B")!
    let parentOfC = unionFind.setOf("C")!

    XCTAssertEqual(parentOfB, 1)
    XCTAssertEqual(parentOfC, 2)
  }

  func testUnionFindFindElementAfterUnion() {
    // setOf will point to parent
    var unionFind = UnionFind<String>()
    let vertices = ["A", "B", "C", "D", "E", "F", "G"]

    vertices.forEach { unionFind.addSetWith($0) }
    unionFind.unionSetsContaining("A", and: "B")
    unionFind.unionSetsContaining("A", and: "C")

    let parentOfB = unionFind.setOf("B")!
    let parentOfC = unionFind.setOf("C")!

    XCTAssertEqual(parentOfB, parentOfC)
  }

  func testUnionFindFindNestedElements() {
    // setOf will point to root node if multiple parents in subtree
    var unionFind = UnionFind<String>()
    let vertices = ["A", "B", "C", "D", "E", "F", "G"]

    vertices.forEach { unionFind.addSetWith($0) }
    unionFind.unionSetsContaining("A", and: "B")
    unionFind.unionSetsContaining("A", and: "C")
    unionFind.unionSetsContaining("B", and: "E")
    unionFind.unionSetsContaining("C", and: "G")

    let parentOfE = unionFind.setOf("E")!
    let parentOfG = unionFind.setOf("G")!

    XCTAssertEqual(parentOfE, parentOfG)
  }

  func testUnionFindInSameSet() {
    // can find elements in same set
    var unionFind = UnionFind<String>()
    let vertices = ["A", "B", "C", "D", "E", "F", "G"]

    vertices.forEach { unionFind.addSetWith($0) }
    unionFind.unionSetsContaining("A", and: "B")
    unionFind.unionSetsContaining("A", and: "C")
    unionFind.unionSetsContaining("D", and: "E")

    XCTAssert(unionFind.inSameSet("B", and: "C"))
    XCTAssertFalse(unionFind.inSameSet("D", and: "C"))
  }

  func testUnionFindUnionSets() {
    // order of union does not matter, size of sub-tree taken into account
    var unionFind = UnionFind<String>()
    let vertices = ["A", "B", "C", "D", "E", "F", "G"]

    vertices.forEach { unionFind.addSetWith($0) }
    unionFind.unionSetsContaining("A", and: "B")
    unionFind.unionSetsContaining("A", and: "C")
    unionFind.unionSetsContaining("D", and: "A")

    let parentOfD = unionFind.setOf("D")!
    let parentOfB = unionFind.setOf("B")!

    XCTAssertEqual(parentOfD, parentOfB)
  }
}
