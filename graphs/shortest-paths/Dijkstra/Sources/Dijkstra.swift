public struct Edge<T>: CustomStringConvertible, Equatable {
  public let vertex1: T
  public let vertex2: T
  public let weight: Int

  public var description: String {
    return "[\(vertex1)-\(vertex2), \(weight)]"
  }

  public static func == (lhs: Edge<T>, rhs: Edge<T>) -> Bool {
    return lhs.description == rhs.description
  }

}

public struct Graph<T: Hashable>: CustomStringConvertible {

  public private(set) var edgeList: [Edge<T>]
  public private(set) var vertices: Set<T>
  public private(set) var adjList: [T: [(vertex: T, weight: Int)]]

  public init() {
    edgeList = [Edge<T>]()
    vertices = Set<T>()
    adjList = [T: [(vertex: T, weight: Int)]]()
  }

  public var description: String {
    var description = ""
    for edge in edgeList {
      description += edge.description + "\n"
    }
    return description
  }

  public mutating func addEdge(vertex1 v1: T, vertex2 v2: T, weight w: Int) {
    edgeList.append(Edge(vertex1: v1, vertex2: v2, weight: w))
    vertices.insert(v1)
    vertices.insert(v2)

    adjList[v1] = adjList[v1] ?? []
    adjList[v1]?.append((vertex: v2, weight: w))

    adjList[v2] = adjList[v2] ?? []
    adjList[v2]?.append((vertex: v1, weight: w))
  }

  public mutating func addEdge(_ edge: Edge<T>) {
    addEdge(vertex1: edge.vertex1, vertex2: edge.vertex2, weight: edge.weight)
  }
}

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

func dijkstra<T>(graph: Graph<T>, start: T, end: T) -> (cost: Int, tree: Graph<T>) {
  var cost: Int = 0
  var tree = Graph<T>()

  var visited = Set<T>()
  var priorityQueue = Queue<(vertex: T, weight: Int, parent: T?)>(
    sort: { $0.weight < $1.weight })

  priorityQueue.enqueue((vertex: start, weight: 0, parent: nil))

  while let head = priorityQueue.dequeue() {
    // grab top of queue
    let vertex = head.vertex

    if vertex == end {
      return (cost: cost, tree: tree)
    }

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
