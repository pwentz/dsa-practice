import XCTest
@testable import BreadthFirstSearch

class BreadthFirstSearchTests: XCTestCase {
  func directedTreeSetup() -> Node {
    let nodeA = Node(label: "a")
    let nodeB = Node(label: "b")
    let nodeC = Node(label: "c")
    let nodeD = Node(label: "d")
    let nodeE = Node(label: "e")
    let nodeF = Node(label: "f")
    let nodeG = Node(label: "g")
    let nodeH = Node(label: "h")

    nodeA.addNeighbor(nodeB)
    nodeA.addNeighbor(nodeC)
    nodeB.addNeighbor(nodeD)
    nodeB.addNeighbor(nodeE)
    nodeC.addNeighbor(nodeF)
    nodeC.addNeighbor(nodeG)
    nodeE.addNeighbor(nodeH)
    nodeE.addNeighbor(nodeF)
    nodeF.addNeighbor(nodeG)
    // tree.addEdge(nodeA, neighbor: nodeB)
    // tree.addEdge(nodeA, neighbor: nodeC)
    // tree.addEdge(nodeB, neighbor: nodeD)
    // tree.addEdge(nodeB, neighbor: nodeE)
    // tree.addEdge(nodeC, neighbor: nodeF)
    // tree.addEdge(nodeC, neighbor: nodeG)
    // tree.addEdge(nodeE, neighbor: nodeH)
    // tree.addEdge(nodeE, neighbor: nodeF)
    // tree.addEdge(nodeF, neighbor: nodeG)

    return nodeA
  }

//   func undirectedGraphSetup() -> Node {
//     let graph = Graph()

//     let nodeA = graph.addNode("a")
//     let nodeB = graph.addNode("b")
//     let nodeC = graph.addNode("c")
//     let nodeD = graph.addNode("d")
//     let nodeE = graph.addNode("e")
//     let nodeF = graph.addNode("f")
//     let nodeG = graph.addNode("g")
//     let nodeH = graph.addNode("h")
//     let nodeI = graph.addNode("i")

//     graph.addEdge(nodeA, neighbor: nodeB)
//     graph.addEdge(nodeA, neighbor: nodeH)

//     graph.addEdge(nodeB, neighbor: nodeA)
//     graph.addEdge(nodeB, neighbor: nodeC)
//     graph.addEdge(nodeB, neighbor: nodeH)

//     graph.addEdge(nodeC, neighbor: nodeB)
//     graph.addEdge(nodeC, neighbor: nodeD)
//     graph.addEdge(nodeC, neighbor: nodeF)
//     graph.addEdge(nodeC, neighbor: nodeI)

//     graph.addEdge(nodeD, neighbor: nodeC)
//     graph.addEdge(nodeD, neighbor: nodeE)
//     graph.addEdge(nodeD, neighbor: nodeF)

//     graph.addEdge(nodeE, neighbor: nodeD)
//     graph.addEdge(nodeE, neighbor: nodeF)

//     graph.addEdge(nodeF, neighbor: nodeC)
//     graph.addEdge(nodeF, neighbor: nodeD)
//     graph.addEdge(nodeF, neighbor: nodeE)
//     graph.addEdge(nodeF, neighbor: nodeG)

//     graph.addEdge(nodeG, neighbor: nodeF)
//     graph.addEdge(nodeG, neighbor: nodeH)
//     graph.addEdge(nodeG, neighbor: nodeI)

//     graph.addEdge(nodeH, neighbor: nodeA)
    // graph.addEdge(nodeH, neighbor: nodeB)
    // graph.addEdge(nodeH, neighbor: nodeG)
    // graph.addEdge(nodeH, neighbor: nodeI)

    // graph.addEdge(nodeI, neighbor: nodeC)
    // graph.addEdge(nodeI, neighbor: nodeG)
    // graph.addEdge(nodeI, neighbor: nodeH)

    // return nodeA
  // }

  func testExploringTree() {
    let nodeA = directedTreeSetup()

    let (matchingNode, nodesExplored) = breadthFirstSearch(source: nodeA, nil)

    XCTAssertEqual(nodesExplored.map { $0.label }, ["a", "b", "c", "d", "e", "f", "g", "h"])
  }

//   func testExploringGraph() {
//     let nodeA = undirectedGraphSetup()
//     let nodesExplored = breadthFirstSearch(source: nodeA, nil).1

//     XCTAssertEqual(nodesExplored.map { $0.label }, ["a", "b", "h", "c", "g", "i", "d", "f", "e"])
//   }

//   func testExploringGraphWithASingleNode() {
//     let node = Graph().addNode("a")

//     let nodesExplored = breadthFirstSearch(source: node, nil).1

//     XCTAssertEqual(nodesExplored.map { $0.label }, ["a"])
//   }
}
