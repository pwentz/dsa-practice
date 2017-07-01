public class Edge {
  public var neighbor: Node

  init(_ neighbor: Node) {
    self.neighbor = neighbor
  }
}

public class Node {
  public var visited: Bool
  public var edges: [Edge]
  public var label: String

  init(label: String) {
    self.label = label
    visited = false
    edges = []
  }
}

public class Graph {
  public var nodes: [Node] = []

  public func addNode(_ label: String) -> Node {
    let node = Node(label: label)
    nodes.append(node)
    return node
  }

  public func addEdge(_ source: Node, neighbor: Node) {
    let edge = Edge(neighbor)
    source.edges.append(edge)
  }
}
