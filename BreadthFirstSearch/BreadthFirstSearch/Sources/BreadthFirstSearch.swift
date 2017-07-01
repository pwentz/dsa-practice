public func breadthFirstSearch(_ tree: Graph, source: Node) -> [String] {
  var nodes: [Node] = [source]
  var nodesToSearch = Queue<Node>()

  nodesToSearch.enqueue(source)
  source.visited = true

  while let current = nodesToSearch.dequeue() {
    current.edges.forEach { e in
      if !e.neighbor.visited {
        nodes.append(e.neighbor)
        e.neighbor.visited = true
        nodesToSearch.enqueue(e.neighbor)
      }
    }
  }

  return nodes.map { $0.label }
}

public struct Queue<T> {
  var q: [T] = []

  public mutating func enqueue(_ elt: T) {
    q.append(elt)
  }

  public mutating func dequeue() -> T? {
    return q.isEmpty ? nil : q.removeFirst()
  }
}
