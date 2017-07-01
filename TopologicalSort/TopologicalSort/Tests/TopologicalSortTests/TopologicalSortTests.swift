import Foundation
import XCTest
@testable import TopologicalSort

extension Graph {
  public func loadEdgeList(_ lines: [String]) {
    for line in lines {
      let items = line.components(separatedBy: " ").filter { s in !s.isEmpty }
      let firstNode = Node(label: items[0])
      let nextNode = Node(label: items[1])
      if firstNode.edges.isEmpty {
        let _ = addNode(items[0])
      }
      if nextNode.edges.isEmpty {
        let _ = addNode(items[1])
      }
      addEdge(fromNode: firstNode, toNode: nextNode)
    }
  }
}

class TopologicalSort: XCTestCase {
  // The topological sort is valid if a node does not have any of its
  // predecessors in its adjacency list.
  func checkIsValidTopologicalSort(_ graph: Graph, _ a: [String]) {
    for i in stride(from: (a.count - 1), to: 0, by: -1) {
      let node = graph.nodes.first(where: { $0.label == a[i] })
      if let neighbors = node?.neighbors, !neighbors.isEmpty {
        for j in stride(from: (i - 1), through: 0, by: -1) {
          XCTAssertFalse(neighbors.map { $0.label }.contains(a[j]), "\(a) is not a valid topological sort")
        }
      }
    }
  }

  func testTopologicalSort() {
    let graph = Graph()

    let node5 = graph.addNode("5")
    let node7 = graph.addNode("7")
    let node3 = graph.addNode("3")
    let node11 = graph.addNode("11")
    let node8 = graph.addNode("8")
    let node2 = graph.addNode("2")
    let node9 = graph.addNode("9")
    let node10 = graph.addNode("10")

    graph.addEdge(fromNode: node5, toNode: node11)
    graph.addEdge(fromNode: node7, toNode: node11)
    graph.addEdge(fromNode: node7, toNode: node8)
    graph.addEdge(fromNode: node3, toNode: node8)
    graph.addEdge(fromNode: node3, toNode: node10)
    graph.addEdge(fromNode: node11, toNode: node2)
    graph.addEdge(fromNode: node11, toNode: node9)
    graph.addEdge(fromNode: node11, toNode: node10)
    graph.addEdge(fromNode: node8, toNode: node9)

    let result = topologicalSort(graph).map { $0.label }

    let sol1 = ["5", "7", "11", "2", "3", "10", "8", "9"]
    let sol2 = ["7", "5", "11", "2", "3", "10", "8", "9"]
    let sol3 = ["7", "5", "11", "2", "3", "8", "9", "10"]
    let sol4 = ["5", "7", "11", "2", "3", "8", "9", "10"]
    let sol5 = ["3", "7", "5", "10", "8", "11", "9", "2"]
    let sol6 = ["3", "7", "5", "8", "11", "2", "9", "10"]
    let possibleSolutions = [sol1, sol2, sol3, sol4, sol5, sol6]

    let verdict = possibleSolutions.filter { result == $0 }.count == 1

    checkIsValidTopologicalSort(graph, result)
    XCTAssert(verdict)
  }

  func testTopologicalSortEdgeLists() {
    let p1 = ["A B", "A C", "B C", "B D", "C E", "C F", "E D", "F E", "G A", "G F"]
    let p2 = ["B C", "C D", "C G", "B F", "D G", "G E", "F G", "F G"]
    let p3 = ["S V", "S W", "V T", "W T"]
    let p4 = ["5 11", "7 11", "7 8", "3 8", "3 10", "11 2", "11 9", "11 10", "8 9"]

    let data = [ p1, p2, p3, p4 ]

    for d in data {
      let graph = Graph()
      graph.loadEdgeList(d)

      let sorted1 = topologicalSort(graph).map { $0.label }
      checkIsValidTopologicalSort(graph, sorted1)
    }
  }
}
