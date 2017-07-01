import XCTest
@testable import DepthFirstSearch

class DepthFirstSearchTests: XCTestCase {

  func directedTreeSetup() -> (Graph, Node) {
    let graph = Graph()

    let nodeA = graph.addNode("a")
    let nodeB = graph.addNode("b")
    let nodeC = graph.addNode("c")
    let nodeD = graph.addNode("d")
    let nodeE = graph.addNode("e")
    let nodeF = graph.addNode("f")
    let nodeG = graph.addNode("g")
    let nodeH = graph.addNode("h")

    graph.addEdge(nodeA, neighbor: nodeB)
    graph.addEdge(nodeA, neighbor: nodeC)
    graph.addEdge(nodeB, neighbor: nodeD)
    graph.addEdge(nodeB, neighbor: nodeE)
    graph.addEdge(nodeC, neighbor: nodeF)
    graph.addEdge(nodeC, neighbor: nodeG)
    graph.addEdge(nodeE, neighbor: nodeH)
    graph.addEdge(nodeE, neighbor: nodeF)
    graph.addEdge(nodeF, neighbor: nodeG)

    return (graph, nodeA)
  }

  func undirectedGraphSetup() -> (Graph, Node) {
    let graph = Graph()

    let nodeA = graph.addNode("a")
    let nodeB = graph.addNode("b")
    let nodeC = graph.addNode("c")
    let nodeD = graph.addNode("d")
    let nodeE = graph.addNode("e")
    let nodeF = graph.addNode("f")
    let nodeG = graph.addNode("g")
    let nodeH = graph.addNode("h")
    let nodeI = graph.addNode("i")

    graph.addEdge(nodeA, neighbor: nodeB)
    graph.addEdge(nodeA, neighbor: nodeH)

    graph.addEdge(nodeB, neighbor: nodeA)
    graph.addEdge(nodeB, neighbor: nodeC)
    graph.addEdge(nodeB, neighbor: nodeH)

    graph.addEdge(nodeC, neighbor: nodeB)
    graph.addEdge(nodeC, neighbor: nodeD)
    graph.addEdge(nodeC, neighbor: nodeF)
    graph.addEdge(nodeC, neighbor: nodeI)

    graph.addEdge(nodeD, neighbor: nodeC)
    graph.addEdge(nodeD, neighbor: nodeE)
    graph.addEdge(nodeD, neighbor: nodeF)

    graph.addEdge(nodeE, neighbor: nodeD)
    graph.addEdge(nodeE, neighbor: nodeF)

    graph.addEdge(nodeF, neighbor: nodeC)
    graph.addEdge(nodeF, neighbor: nodeD)
    graph.addEdge(nodeF, neighbor: nodeE)
    graph.addEdge(nodeF, neighbor: nodeG)

    graph.addEdge(nodeG, neighbor: nodeF)
    graph.addEdge(nodeG, neighbor: nodeH)
    graph.addEdge(nodeG, neighbor: nodeI)

    graph.addEdge(nodeH, neighbor: nodeA)
    graph.addEdge(nodeH, neighbor: nodeB)
    graph.addEdge(nodeH, neighbor: nodeG)
    graph.addEdge(nodeH, neighbor: nodeI)

    graph.addEdge(nodeI, neighbor: nodeC)
    graph.addEdge(nodeI, neighbor: nodeG)
    graph.addEdge(nodeI, neighbor: nodeH)

    return (graph, nodeA)
  }

  // func testExploringTree() {
  //   let setup = directedTreeSetup()
  //   let tree = setup.0
  //   let nodeA = setup.1

  //   let nodesExplored = depthFirstSearch(tree, source: nodeA)
  //   // let nodeLabels = nodesExplored.map { $0.label }

  //   XCTAssertEqual(nodesExplored, ["a", "b", "d", "e", "h", "f", "g", "c"])
  // }

  func testExploringGraph() {
    let setup = undirectedGraphSetup()
    let graph = setup.0
    let nodeA = setup.1
    let nodesExplored = depthFirstSearch(graph, source: nodeA)
    // let nodeLabels = nodesExplored.map { $0.label }

    XCTAssertEqual(nodesExplored, ["a", "b", "c", "d", "e", "f", "g", "h", "i"])
  }

  // func testExploringGraphWithASingleNode() {
  //   let graph = Graph()
  //   let node = graph.addNode("a")

  //   let nodesExplored = breadthFirstSearch(graph, source: node)

  //   XCTAssertEqual(nodesExplored, ["a"])
  // }
}
