import XCTest
@testable import KruskalsAlgorithm

class KruskalsAlgorithmTests: XCTestCase {
    var graph = Graph<String>()
    let ab = Edge<String>(vertex1: "A", vertex2: "B", weight: 5)
    let ad = Edge<String>(vertex1: "A", vertex2: "D", weight: 7)
    let ag = Edge<String>(vertex1: "A", vertex2: "G", weight: 12)
    let bc = Edge<String>(vertex1: "B", vertex2: "C", weight: 7)
    let bd = Edge<String>(vertex1: "B", vertex2: "D", weight: 9)
    let cd = Edge<String>(vertex1: "C", vertex2: "D", weight: 4)
    let cf = Edge<String>(vertex1: "C", vertex2: "F", weight: 5)
    let de = Edge<String>(vertex1: "D", vertex2: "E", weight: 3)
    let dg = Edge<String>(vertex1: "D", vertex2: "G", weight: 4)
    let ec = Edge<String>(vertex1: "E", vertex2: "C", weight: 2)
    let ef = Edge<String>(vertex1: "E", vertex2: "F", weight: 2)
    let eg = Edge<String>(vertex1: "E", vertex2: "G", weight: 7)

    func graphSetup() {
      let edges = [ab, ad, ag, bc, bd, cd, ec, cf, de, ef, eg, dg]
      edges.forEach { graph.addEdge($0) }
    }

    func testKruskal() {
      graphSetup()
      let result = minimumSpanningTreeKruskal(graph: graph)

      let expectedOutcome = [ec, ef, de, dg, ab, ad]

      XCTAssertEqual(result.cost, 23)
      XCTAssertEqual(result.tree.edgeList, expectedOutcome)
    }
}
