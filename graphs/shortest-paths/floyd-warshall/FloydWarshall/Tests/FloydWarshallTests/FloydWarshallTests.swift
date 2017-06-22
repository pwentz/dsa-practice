import XCTest
@testable import FloydWarshall

public func eval(_ lhs: [[Double?]], _ rhs: [[Double?]]) {
  XCTAssertEqual(lhs.count, rhs.count, "Given arrays have mismatched length")

  for (rowIdx, elt) in lhs.enumerated() {
    for (colIdx, val) in elt.enumerated() {
      XCTAssertEqual(rhs[rowIdx][colIdx], val)
    }
  }

}

class FloydWarshallTests: XCTestCase {

  func testFloydWarshallSmallGraph() {
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

    let expected = [[0.0, 4.0, 1.0, -4.0],
                    [inf, 0.0, 8.0, -2.0],
                    [inf, inf, 0.0, -5.0],
                    [inf, inf, inf, 0.0]]

    let result = floydWarshall(graph: graph)

    eval(expected, result)
  }

  func testFloydWarshallLargerGraph() {
    let graph = Graph<Int>()
    let v1 = graph.createVertex(1)
    let v2 = graph.createVertex(2)
    let v3 = graph.createVertex(3)
    let v4 = graph.createVertex(4)
    let v5 = graph.createVertex(5)

    graph.addDirectedEdge(v1, to: v2, withWeight: 3)
    graph.addDirectedEdge(v1, to: v5, withWeight: -4)
    graph.addDirectedEdge(v1, to: v3, withWeight: 8)

    graph.addDirectedEdge(v2, to: v4, withWeight: 1)
    graph.addDirectedEdge(v2, to: v5, withWeight: 7)

    graph.addDirectedEdge(v3, to: v2, withWeight: 4)

    graph.addDirectedEdge(v4, to: v1, withWeight: 2)
    graph.addDirectedEdge(v4, to: v3, withWeight: -5)

    graph.addDirectedEdge(v5, to: v4, withWeight: 6)


    let expected = [[0.0,  1.0, -3.0,  2.0, -4.0],
                    [3.0,  0.0, -4.0,  1.0, -1.0],
                    [7.0,  4.0,  0.0,  5.0,  3.0],
                    [2.0, -1.0, -5.0,  0.0, -2.0],
                    [8.0,  5.0,  1.0,  6.0,  0.0]]

    let result = floydWarshall(graph: graph)

    eval(expected, result)
  }
}
