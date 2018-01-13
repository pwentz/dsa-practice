public class Edge {
  public var neighbor: Node

  init(_ neighbor: Node) {
    self.neighbor = neighbor
  }
}

public class Node {
  public var visited: Bool
  public var neighbors: [Node]
  public var label: String

  init(label: String) {
    self.label = label
    visited = false
    neighbors = []
  }

  public func addNeighbor(_ node: Node) -> Void {
    self.neighbors.append(node)
  }
}

// public class Graph {
//   public var nodes: [Node] = []

//   public func addNode(_ label: String) -> Node {
//     let node = Node(label: label)
//     nodes.append(node)
//     return node
//   }

//   public func addEdge(_ source: Node, neighbor: Node) {
//     let edge = Edge(neighbor)
//     source.edges.append(edge)
//   }
// }
