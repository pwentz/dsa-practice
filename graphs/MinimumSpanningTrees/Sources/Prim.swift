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

func minimumSpanningTreePrim<T>(graph: Graph<T>) -> (cost: Int, tree: Graph<T>) {
  var cost: Int = 0
  var tree = Graph<T>()

  guard let start = graph.vertices.first else {
    return (cost: cost, tree: tree)
  }

  var visited = Set<T>()
  var priorityQueue = Queue<(vertex: T, weight: Int, parent: T?)>(
    sort: { $0.weight < $1.weight })

  priorityQueue.enqueue((vertex: start, weight: 0, parent: nil))

  while let head = priorityQueue.dequeue() {
    // grab top of queue
    let vertex = head.vertex
    // if visited, continue...
    if visited.contains(vertex) {
      continue
    }
    // otherwise, mark visited
    visited.insert(vertex)

    // add cost
    cost += head.weight

    // add new edge to tree
    if let prev = head.parent {
      tree.addEdge(vertex1: prev, vertex2: vertex, weight: head.weight)
    }

    // add all non-visited neighbors to queue
    if let neighbours = graph.adjList[vertex] {
      for neighbour in neighbours {
        let nextVertex = neighbour.vertex
        if !visited.contains(nextVertex) {
          priorityQueue.enqueue((vertex: nextVertex, weight: neighbour.weight, parent: vertex))
        }
      }
    }
  }

  return (cost: cost, tree: tree)
}
