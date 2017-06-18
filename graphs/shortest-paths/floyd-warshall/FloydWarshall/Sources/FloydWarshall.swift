import Foundation
  /**
   Floyd-Warshall algorithm for computing all-pairs shortest paths in a weighted directed graph.

   - precondition: `graph` must have no negative weight cycles
   - returns a `FloydWarshallResult` struct which can be queried for shortest paths and their total weights
   */

private typealias Distances = [[Double]]
private typealias Predecessors = [[Int?]]

public struct FloydWarshall<T> where T: Hashable {

  public typealias Q = T
  public typealias P = FloydWarshallResult<T>

  public static func apply<T>(_ graph: AdjacencyMatrixGraph<T>) -> FloydWarshallResult<T> {

    var previousDistance = constructInitialDistanceMatrix(graph)
    var previousPredecessor = constructInitialPredecessorMatrix(previousDistance)
    for intermediateIdx in 0 ..< graph.vertices.count {
      let nextResult = nextStep(intermediateIdx, previousDistances: previousDistance, previousPredecessors: previousPredecessor, graph: graph)
      previousDistance = nextResult.distances
      previousPredecessor = nextResult.predecessors
    }

    return FloydWarshallResult<T>(weights: previousDistance, predecessors: previousPredecessor)
  }

  /**
   For each iteration of `intermediateIdx`, perform the comparison for dynamic algo,
   check each pair of start/end vertices, and whether a path taken different vertex yields shorter path.

   - returns: a tuple containing the next distance matrix with weights of currently known
   shortest paths and the corresponding predecessor matrix
   */
  static fileprivate func nextStep<T>( _ intermediateIdx: Int, previousDistances: Distances,
                    previousPredecessors: Predecessors, graph: AdjacencyMatrixGraph<T>) -> (distances: Distances, predecessors: Predecessors) {

    // intermediateIdx is current index that we're processing
    let vertexCount = graph.vertices.count
    var nextDistances = Array(repeating: Array(repeating: Double.infinity, count: vertexCount), count: vertexCount)
    var nextPredecessors = Array(repeating: Array<Int?>(repeating: nil, count: vertexCount), count: vertexCount)

    for fromIdx in 0 ..< vertexCount {
      for toIndex in 0 ..< vertexCount {
        // existing "best path" from fromIdx to toIndex
        let originalPathWeight = previousDistances[fromIdx][toIndex]
        // path from starting index to current index
        let newPathWeightBefore = previousDistances[fromIdx][intermediateIdx]
        // path from current index to destination index
        let newPathWeightAfter = previousDistances[intermediateIdx][toIndex]

        let newPathThroughIntermediate = newPathWeightBefore + newPathWeightAfter

        var predecessor: Int?

        if newPathThroughIntermediate < originalPathWeight {
          predecessor = previousPredecessors[intermediateIdx][toIndex]
          nextDistances[fromIdx][toIndex] = newPathThroughIntermediate
        } else {
          predecessor = previousPredecessors[fromIdx][toIndex]
          nextDistances[fromIdx][toIndex] = originalPathWeight
        }

        nextPredecessors[fromIdx][toIndex] = predecessor
      }
    }

    return (nextDistances, nextPredecessors)
  }

  /**
   We need to map the graph's weight domain onto the one required by the algorithm: the graph
   stores either a weight as a `Double` or `nil` if no edge exists between two vertices, but
   the algorithm needs a lack of an edge represented as ∞ for the `min` comparison to work correctly.

   - complexity: `Θ(V^2)` time/space
   - returns: weighted adjacency matrix in form ready for processing with Floyd-Warshall
   */
  static fileprivate func constructInitialDistanceMatrix<T>(_ graph: AdjacencyMatrixGraph<T>) -> Distances {

    let vertices = graph.vertices

    let vertexCount = graph.vertices.count
    var distances = Array(repeating: Array(repeating: Double.infinity, count: vertexCount), count: vertexCount)

    for row in vertices {
      for col in vertices {
        let rowIdx = row.index
        let colIdx = col.index
        if rowIdx == colIdx {
          distances[rowIdx][colIdx] = 0.0
        } else if let w = graph.weightFrom(row, to: col) {
          distances[rowIdx][colIdx] = w
        }
      }
    }

    return distances

  }

  /**
   Make the initial predecessor index matrix. Initially each value is equal to it's row index, it's "from" index when querying into it.

   - complexity: `Θ(V^2)` time/space
  */
  static fileprivate func constructInitialPredecessorMatrix(_ distances: Distances) -> Predecessors {

    let vertexCount = distances.count
    var predecessors = Array(repeating: Array<Int?>(repeating: nil, count: vertexCount), count: vertexCount)

    for fromIdx in 0 ..< vertexCount {
      for toIdx in 0 ..< vertexCount {
        if fromIdx != toIdx && distances[fromIdx][toIdx] < Double.infinity {
          predecessors[fromIdx][toIdx] = fromIdx
        }
      }
    }

    return predecessors

  }

}

/**
 `FloydWarshallResult` encapsulates the result of the computation, namely the
 minimized distance adjacency matrix, and the matrix of predecessor indices.
 */
public struct FloydWarshallResult<T> where T: Hashable {

  fileprivate var weights: Distances
  fileprivate var predecessors: Predecessors

  /**
   - returns: the total weight of the path from a starting vertex to a destination.
   This value is the minimal connected weight between the two vertices, or `nil` if no path exists
   */
  public func distance(fromVertex from: Vertex<T>, toVertex to: Vertex<T>) -> Double? {

    return weights[from.index][to.index]

  }

  /**
   - returns: the reconstructed path from a starting vertex to a destination,
   as an array containing the data property of each vertex, or `nil` if no path exists
   */
  public func path(fromVertex from: Vertex<T>, toVertex to: Vertex<T>, inGraph graph: AdjacencyMatrixGraph<T>) -> [T]? {

    if let path = recursePathFrom(fromVertex: from, toVertex: to, path: [ to ], inGraph: graph) {
      let pathValues = path.map { vertex in
        vertex.data
      }
      return pathValues
    }
    return nil

  }

  /**
   The recursive component to rebuilding the shortest path between
   two vertices using the predecessor matrix.

   - returns: the list of predecessors discovered so far
   */
  fileprivate func recursePathFrom(fromVertex from: Vertex<T>, toVertex to: Vertex<T>, path: [Vertex<T>],
                                          inGraph graph: AdjacencyMatrixGraph<T>) -> [Vertex<T>]? {

    if from.index == to.index {
      return [ from, to ]
    }

    if let predecessor = predecessors[from.index][to.index] {
      let predecessorVertex = graph.vertices[predecessor]
      if predecessor == from.index {
        let newPath = [ from, to ]
        return newPath
      } else {
        let buildPath = recursePathFrom(fromVertex: from, toVertex: predecessorVertex, path: path, inGraph: graph)
        let newPath = buildPath! + [ to ]
        return newPath
      }
    }

    return nil
  }

}
