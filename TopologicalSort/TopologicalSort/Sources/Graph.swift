public class Node: Hashable {
  var edges: [Edge] = []
  var visited = false
  let label: String

  public var hashValue: Int {
    return Array(label.utf8).map { Int($0) }.reduce(0, { $1 + $0 })
  }

  public var neighbors: [Node] {
    return edges.map { $0.neighbor }
  }

  public init(label: String) {
    self.label = label
  }
}

public func == (_ lhs: Node, _ rhs: Node) -> Bool {
  return lhs.label == rhs.label
}

public class Edge {
  let neighbor: Node

  init(_ neighbor: Node) {
    self.neighbor = neighbor
  }
}

public class Graph {
  public var nodes: [Node] = []

  public func addNode(_ value: String) -> Node {
    let node = Node(label: value)
    nodes.append(node)
    return node
  }

  public func addEdge(fromNode from: Node, toNode to: Node) {
    let edge = Edge(to)
    from.edges.append(edge)
  }
}

