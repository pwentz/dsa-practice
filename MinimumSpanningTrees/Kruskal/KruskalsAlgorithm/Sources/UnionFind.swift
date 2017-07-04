public struct UnionFind<T: Hashable> {
  private var nodes: [T: Int] = [:]
  private var parents: [Int] = []
  private var treeSize: [Int] = []

  public mutating func addSetWith(_ node: T) {
    nodes[node] = parents.count
    parents.append(parents.count)
    treeSize.append(1)
  }

  private mutating func getParent(of nodeIdx: Int) -> Int {
    guard nodeIdx != parents[nodeIdx] else {
      return nodeIdx
    }

    // additional optimization that flattens the tree structure,
    // so root parent is now direct parent and we don't have to traverse
    // back up tree to parent of this specific node
    parents[nodeIdx] = getParent(of: parents[nodeIdx])
    return parents[nodeIdx]
  }

  public mutating func setOf(_ node: T) -> Int? {
    return nodes[node].map { getParent(of: $0) }
  }

  public mutating func unionSetsContaining(_ firstNode: T, and secondNode: T) {
    if let firstSet = setOf(firstNode), let secondSet = setOf(secondNode), firstSet != secondSet {

      let edge = treeSize[firstSet] >= treeSize[secondSet] ? (parent: firstSet, child: secondSet)
                                                           : (parent: secondSet, child: firstSet)

      parents[edge.child] = edge.parent
      treeSize[edge.parent] += 1
    }
  }

  public mutating func inSameSet(_ firstNode: T, and secondNode: T) -> Bool {
    guard let firstSet = setOf(firstNode), let secondSet = setOf(secondNode) else {
      return false
    }

    return firstSet == secondSet
  }
}
