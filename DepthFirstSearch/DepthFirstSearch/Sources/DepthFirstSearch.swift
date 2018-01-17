public func depthFirstSearch(source: Node, _ pred: ((_ src: Node) -> Bool)?) -> (Node?, [Node]) {
  var nodesExplored: [Node] = [source]
  source.visited = true

  if let isAMatch = pred, isAMatch(source) {
    return (source, nodesExplored)
  }

  for neighbor in source.neighbors {
    if !neighbor.visited {
      var (node, nodesToExplore) = depthFirstSearch(source: neighbor, pred)
      nodesExplored += nodesToExplore

      if let matchingNode = node {
        return (node, nodesExplored)
      }
    }
  }

  return (nil, nodesExplored)
}
