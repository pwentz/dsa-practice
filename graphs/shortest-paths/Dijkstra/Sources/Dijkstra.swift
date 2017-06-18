struct Queue<T> {
  var elements: [T] = []
  let sort: (T, T) -> Bool

  public init(sort: @escaping (T, T) -> Bool) {
    self.sort = sort
  }

  public mutating func enqueue(_ elt: T) {
    elements.append(elt)
    elements = elements.sorted(by: sort)
  }

  public mutating func dequeue() -> T? {
    return elements.isEmpty ? nil : elements.removeFirst()
  }
}

func buildShortestPath<T>(graph: Graph<T>, parents: [T: T], start: T, end: T) -> Graph<T> {
  var tree = Graph<T>()
  var curr = end
  var result: [Edge<T>] = []
  var cost = 0

  // traverse through parents starting with end and back to beginning
  // to get shortest path
  while curr != start, let nextNode = parents[curr] {
    let edge = graph.edgeList.first(where: { ($0.vertex1 == nextNode || $0.vertex1 == curr) &&
                                             ($0.vertex2 == nextNode || $0.vertex2 == curr) })

    edge.map { e in
      result.insert(e, at: 0)
      cost += e.weight
    }

    curr = nextNode
  }

  result.forEach { tree.addEdge($0) }

  return tree
}

func dijkstra<T>(graph: Graph<T>, start: T, end: T) -> Graph<T> {
  // Needs to keep track of three things:
  var costs: [T: Int] = [:] // current shortest paths to neighboring nodes
  var parents: [T: T] = [:] // keys are neighboring nodes, vals are adjacent vertex on shortest path (breadcrumb)
  var visited: Set<T> = [] // keeps track of nodes we've already explored

  var priorityQueue = Queue<(vertex: T, weight: Int, parent: T?)>(
    sort: { $0.weight < $1.weight })

  priorityQueue.enqueue((vertex: start, weight: 0, parent: nil))

  // grab shortest edge
  while let head = priorityQueue.dequeue() {
    if visited.contains(head.vertex) {
      continue
    }

    guard let neighbors = graph.adjList[head.vertex] else {
      visited.insert(head.vertex)
      continue
    }

    // iterate through all neighbors
    for neighbor in neighbors {
      // newCost is distance to take this path
      let newCost = neighbor.weight + head.weight
      let bestPath = costs[neighbor.vertex] ?? Int.max

      // if newCost is lower then best existing cost to get to node, then update
      if newCost < bestPath {
        costs[neighbor.vertex] = newCost
        parents[neighbor.vertex] = head.vertex

        if !visited.contains(neighbor.vertex) {
          priorityQueue.enqueue((vertex: neighbor.vertex, weight: newCost, parent: head.vertex))
        }
      }
    }

    visited.insert(head.vertex)
  }

  return buildShortestPath(graph: graph, parents: parents, start: start, end: end)
}
