public struct Edge<T: Equatable>: Equatable {
  public let vertex1: T
  public let vertex2: T
  public let weight: Int

  public static func == (lhs: Edge<T>, rhs: Edge<T>) -> Bool {
    return (lhs.vertex1 == rhs.vertex1) &&
            (lhs.vertex2 == rhs.vertex2) &&
             (lhs.weight == rhs.weight)
  }

}

public struct Graph<T: Hashable> {

  public private(set) var edgeList: [Edge<T>]
  public private(set) var vertices: Set<T>
  public private(set) var adjList: [T: [(vertex: T, weight: Int)]]

  public init() {
    edgeList = [Edge<T>]()
    vertices = Set<T>()
    adjList = [T: [(vertex: T, weight: Int)]]()
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

