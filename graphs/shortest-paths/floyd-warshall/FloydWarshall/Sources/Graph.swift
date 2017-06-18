public class Graph<T> where T: Hashable {
  var adjMatrix: [Array<Double>] = []
  var vertices: [Int: T] = [:]

  public func createVertex(_ v: T) -> T {
    adjMatrix.append(Array(repeating: Double.infinity, count: vertices.count))

    vertices[vertices.count] = v

    for (idx, _) in adjMatrix.enumerated() {
      adjMatrix[idx].append(Double.infinity)
    }

    return v
  }

  public func addDirectedEdge(_ v1: T, to v2: T, withWeight: T) {
    let r = vertices.first(where: { $0.1 == v1 })
    let column = vertices.first(where: { $0.1 == v2 })

    guard let weight = withWeight as? Int, let row = r, let col = column else {
      return
    }

    for idx in vertices.keys {
      adjMatrix[idx][idx] = 0
    }

    adjMatrix[row.0][col.0] = Double(weight)
  }
}
