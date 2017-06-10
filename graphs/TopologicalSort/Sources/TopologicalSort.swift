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

extension Graph {
  func calculateInDegreeOfNodes() -> [Node : Int] {
    var inDegrees = nodes.reduce([:], { acc, n -> [Node: Int] in
      var m = acc
      m[n] = 0
      return m
    })

    nodes.forEach { node in
      node.neighbors.forEach { n in
        inDegrees[n] = (inDegrees[n] ?? 0) + 1
      }
    }

    return inDegrees
  }

  private func depthFirstSearch(_ source: Node) -> [Node] {
    var nodesExplored = [source]
    source.visited = true

    for edge in source.edges {
      if !edge.neighbor.visited {
        nodesExplored += depthFirstSearch(edge.neighbor)
      }
    }

    return nodesExplored
  }

  public func topologicalSort() -> [Node] {
    let nodeDegrees = calculateInDegreeOfNodes()
    let startNodes = Array(nodeDegrees.keys).filter { nodeDegrees[$0] == 0 }

    return startNodes.reduce([], { acc, node in depthFirstSearch(node) + acc })
  }
}
