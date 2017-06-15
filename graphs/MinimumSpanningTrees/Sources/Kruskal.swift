public func minimumSpanningTreeKruskal<T>(graph: Graph<T>) -> (cost: Int, tree: Graph<T>) {
  var tree = Graph<T>()
  var unionFind = UnionFind<T>()
  var cost = 0

  let edgesByWeight = graph.edgeList.sorted(by: { $0.weight < $1.weight })

  graph.vertices.forEach { v in
    unionFind.addSetWith(v)
  }

  edgesByWeight.forEach { edge in
    let v1 = edge.vertex1
    let v2 = edge.vertex2

    if !unionFind.inSameSet(v1, and: v2) {
      tree.addEdge(edge)
      cost += edge.weight
      unionFind.unionSetsContaining(v1, and: v2)
    }
  }

  return (cost: cost, tree: tree)
}
