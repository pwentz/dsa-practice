import XCTest
@testable import Graph

class GraphTests: XCTestCase {

  func testAdjacencyListGraphDescription() {

    let graph = AdjacencyListGraph<String>()

    let a = graph.createVertex("a")
    let b = graph.createVertex("b")
    let c = graph.createVertex("c")

    graph.addDirectedEdge(a, to: b, withWeight: 1.0)
    graph.addDirectedEdge(b, to: c, withWeight: 2.0)
    graph.addDirectedEdge(a, to: c, withWeight: -5.5)

    let expectedValue = "a -> [(b: 1.0), (c: -5.5)]\nb -> [(c: 2.0)]"
    XCTAssertEqual(graph.description, expectedValue)
  }

  func testAddingPreexistingVertex() {
    let adjacencyList = AdjacencyListGraph<String>()

    let a = adjacencyList.createVertex("a")
    let b = adjacencyList.createVertex("a")

    XCTAssertEqual(a, b, "Should have returned the same vertex when creating a new one with identical data")
    XCTAssertEqual(adjacencyList.vertices.count, 1, "Graph should only contain one vertex after trying to create two vertices with identical data")
  }

  func testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(_ graphType: AbstractGraph<Int>.Type) {
    let graph = graphType.init()

    let a = graph.createVertex(1)
    let b = graph.createVertex(2)

    graph.addDirectedEdge(a, to: b, withWeight: 1.0)

    let edgesFromA = graph.edgesFrom(a)
    let edgesFromB = graph.edgesFrom(b)

    XCTAssertEqual(edgesFromA.count, 1)
    XCTAssertEqual(edgesFromB.count, 0)

    XCTAssertEqual(edgesFromA.first?.to, b)
  }

  func testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(_ graphType: AbstractGraph<Int>.Type) {
    let graph = graphType.init()

    let a = graph.createVertex(1)
    let b = graph.createVertex(2)

    graph.addUndirectedEdge((a, b), withWeight: 1.0)

    let edgesFromA = graph.edgesFrom(a)
    let edgesFromB = graph.edgesFrom(b)

    XCTAssertEqual(edgesFromA.count, 1)
    XCTAssertEqual(edgesFromB.count, 1)

    XCTAssertEqual(edgesFromA.first?.to, b)
    XCTAssertEqual(edgesFromB.first?.to, a)
  }

  func testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(_ graphType: AbstractGraph<Int>.Type) {
    let graph = graphType.init()

    let a = graph.createVertex(1)
    let b = graph.createVertex(2)

    XCTAssertEqual(graph.edgesFrom(a).count, 0)
    XCTAssertEqual(graph.edgesFrom(b).count, 0)
  }

  func testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedGraphWithType(_ graphType: AbstractGraph<Int>.Type) {
    let graph = graphType.init()
    let verticesCount = 100
    var vertices: [Vertex<Int>] = []

    for i in 0..<verticesCount {
      vertices.append(graph.createVertex(i))
    }

    for i in 0..<verticesCount {
      for j in i+1..<verticesCount {
        graph.addDirectedEdge(vertices[i], to: vertices[j], withWeight: 1)
      }
    }

    for i in 0..<verticesCount {
      let outEdges = graph.edgesFrom(vertices[i])
      let toVertices = outEdges.map {return $0.to}
      XCTAssertEqual(outEdges.count, verticesCount - i - 1)
      for j in i+1..<verticesCount {
        XCTAssertTrue(toVertices.contains(vertices[j]))
      }
    }
  }

  func testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedListGraph() {
    testEdgesFromReturnsCorrectEdgeInSingleEdgeDirecedGraphWithType(AdjacencyListGraph<Int>.self)
  }

  func testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedListGraph() {
    testEdgesFromReturnsCorrectEdgeInSingleEdgeUndirectedGraphWithType(AdjacencyListGraph<Int>.self)
  }

  func testEdgesFromReturnsNoInNoEdgeListGraph() {
    testEdgesFromReturnsNoEdgesInNoEdgeGraphWithType(AdjacencyListGraph<Int>.self)
  }

  func testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedListGraph() {
    testEdgesFromReturnsCorrectEdgesInBiggerGraphInDirectedGraphWithType(AdjacencyListGraph<Int>.self)
  }
}
