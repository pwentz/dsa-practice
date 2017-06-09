public func depthFirstSearch(_ tree: Graph, source: Node) -> [String] {
  var nodesExplored = [source.label]
  source.visited = true

  for edge in source.edges {
    if !edge.neighbor.visited {
      nodesExplored.append(contentsOf: depthFirstSearch(tree, source: edge.neighbor))
    }
  }

  return nodesExplored
}
