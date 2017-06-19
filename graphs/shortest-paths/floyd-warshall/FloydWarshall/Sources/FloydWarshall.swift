public func createParentMatrix(from matrix: [[Double]]) -> [[Double?]] {
  var result: [[Double?]] = Array(
    repeating: Array(repeating: Double.infinity, count: matrix.count),
    count: matrix.count
  )

  for (rowIdx, row) in matrix.enumerated() {
    for (colIdx, col) in row.enumerated() {
      guard col < Double.infinity else {
        continue
      }

      let parent = col != 0.0 ? Double(rowIdx) : nil

      result[rowIdx][colIdx] = parent
    }
  }

  return result
}

public func floydWarshall<T>(graph: Graph<T>) -> [[Double]] {
  var parents = createParentMatrix(from: graph.adjMatrix)
  var distances = graph.adjMatrix

  for intermediateIdx in 0..<graph.size {
    for (startIdx, row) in distances.enumerated() {
      for (destinationIdx, currentDistance) in row.enumerated() {
        let newDistance = distances[startIdx][intermediateIdx] + distances[intermediateIdx][destinationIdx]

        if newDistance < currentDistance {
          distances[startIdx][destinationIdx] = newDistance
          parents[startIdx][destinationIdx] = Double(intermediateIdx)
        }
      }
    }
  }

  return distances
}
