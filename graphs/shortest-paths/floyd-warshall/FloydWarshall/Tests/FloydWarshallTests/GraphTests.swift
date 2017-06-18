import XCTest
@testable import FloydWarshall

public func eval(_ lhs: [Array<Double>], _ rhs: [Array<Double>]) {
  XCTAssertEqual(lhs.count, rhs.count, "Given arrays have mismatched length")

  for (idx, elt) in lhs.enumerated() {
    XCTAssertEqual(elt, rhs[idx])
  }

}

class GraphTests: XCTestCase {
  func testGraphCanCreateAdjacencyMatrix() {
    let graph = Graph<Int>()
    let v1 = graph.createVertex(1)
    let v2 = graph.createVertex(2)
    let v3 = graph.createVertex(3)
    let v4 = graph.createVertex(4)

    graph.addDirectedEdge(v1, to: v2, withWeight: 4)
    graph.addDirectedEdge(v1, to: v3, withWeight: 1)
    graph.addDirectedEdge(v1, to: v4, withWeight: 3)

    graph.addDirectedEdge(v2, to: v3, withWeight: 8)
    graph.addDirectedEdge(v2, to: v4, withWeight: -2)

    graph.addDirectedEdge(v3, to: v4, withWeight: -5)

    let inf = Double.infinity

    let expected = [[0.0, 4.0, 1.0, 3.0],
                    [inf, 0.0, 8.0, -2.0],
                    [inf, inf, 0.0, -5.0],
                    [inf, inf, inf, 0.0]]

    eval(expected, graph.adjMatrix)
  }
}
