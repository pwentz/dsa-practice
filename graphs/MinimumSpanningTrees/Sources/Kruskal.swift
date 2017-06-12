func minimumSpanningTreeKruskal<T>(graph: Graph<T>) -> (cost: Int, tree: Graph<T>) {
  var cost: Int = 0
  var tree = Graph<T>()
  let sortedEdgeListByWeight = graph.edgeList.sorted(by: { $0.weight < $1.weight })

  var unionFind = UnionFind<T>()
  for vertex in graph.vertices {
    unionFind.addSetWith(vertex)
  }

  for edge in sortedEdgeListByWeight {
    print("V1", edge.vertex1)
    print("V2", edge.vertex2)
    print("UNION", unionFind)
    let v1 = edge.vertex1
    let v2 = edge.vertex2
    if !unionFind.inSameSet(v1, and: v2) {
      cost += edge.weight
      tree.addEdge(edge)
      unionFind.unionSetsContaining(v1, and: v2)
    }
  }

  return (cost: cost, tree: tree)
}
