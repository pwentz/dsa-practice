fileprivate func calculateInDegreeOfNodes(for graph: Graph) -> [Node : Int] {
  var inDegrees = graph.nodes.reduce([:], { acc, n -> [Node: Int] in
    var m = acc
    m[n] = 0
    return m
  })

  graph.nodes.forEach { node in
    node.neighbors.forEach { n in
      inDegrees[n] = (inDegrees[n] ?? 0) + 1
    }
  }

  return inDegrees
}

fileprivate func depthFirstSearch(_ source: Node) -> [Node] {
  var nodesExplored = [source]
  source.visited = true

  source.edges.forEach { edge in
    if !edge.neighbor.visited {
      nodesExplored += depthFirstSearch(edge.neighbor)
    }
  }

  return nodesExplored
}

public func topologicalSort(_ graph: Graph) -> [Node] {
  let nodeDegrees = calculateInDegreeOfNodes(for: graph)
  let startNodes = Array(nodeDegrees.keys).filter { nodeDegrees[$0] == 0 }

  return startNodes.reduce([], { acc, node in depthFirstSearch(node) + acc })
}
