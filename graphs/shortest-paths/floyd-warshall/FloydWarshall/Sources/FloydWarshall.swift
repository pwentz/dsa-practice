public func floydWarshall<T>(graph: Graph<T>) -> [[Double]] {
  var distances = graph.adjMatrix

  for intermediateIdx in 0..<graph.size {
    for (startIdx, row) in distances.enumerated() {
      for (destinationIdx, currentDistance) in row.enumerated() {
        let newDistance = distances[startIdx][intermediateIdx] + distances[intermediateIdx][destinationIdx]

        if newDistance < currentDistance {
          distances[startIdx][destinationIdx] = newDistance
        }
      }
    }
  }

  return distances
}
