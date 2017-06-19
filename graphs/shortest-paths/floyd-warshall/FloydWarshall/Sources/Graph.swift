public class Graph<T> where T: Hashable {
  var adjMatrix: [[Double]] = []
  var vertexPositions: [T: Int] = [:] // vertex values and their indices in matrix
  var size: Int { return vertexPositions.count }

  public func createVertex(_ vertex: T) -> T {
    adjMatrix.append(Array(repeating: Double.infinity, count: size))

    vertexPositions[vertex] = size

    for (idx, _) in adjMatrix.enumerated() {
      adjMatrix[idx].append(Double.infinity)
    }

    return vertex
  }

  public func addDirectedEdge(_ v1: T, to v2: T, withWeight weight: Double) {
    guard let row = vertexPositions[v1], let col = vertexPositions[v2] else {
      return
    }

    vertexPositions.values.forEach { idx in
      adjMatrix[idx][idx] = 0
    }

    adjMatrix[row][col] = weight
  }
}
