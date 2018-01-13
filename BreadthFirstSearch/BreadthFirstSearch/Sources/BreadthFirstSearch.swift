public func breadthFirstSearch(source: Node, _ pred: ((_ src: Node) -> Bool)?) -> (Node?, [Node]) {
  var nodes: [Node] = [source]
  var nodesToSearch = Queue<Node>()

  nodesToSearch.enqueue(source)
  source.visited = true

  while let current = nodesToSearch.dequeue() {
    if let isAMatch = pred, isAMatch(current) {
      return (current, nodes)
    }

    for neighbor in current.neighbors {
      if !neighbor.visited {
        nodes.append(neighbor)
        neighbor.visited = true
        nodesToSearch.enqueue(neighbor)
      }
    }
  }

  return (nil, nodes)
}

public struct Queue<T> {
  private var q: [T] = []

  public mutating func enqueue(_ elt: T) -> Void {
    q.append(elt)
  }

  public mutating func dequeue() -> T? {
    return q.isEmpty ? nil : q.removeFirst()
  }
}
