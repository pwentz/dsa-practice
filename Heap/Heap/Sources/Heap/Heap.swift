import Foundation

public struct Heap<T: Comparable> {
  public var nodes: [T]
  private let hasPriority: (T, T) -> Bool

  public var isEmpty: Bool {
    return nodes.isEmpty
  }

  public var count: Int {
    return nodes.count
  }

  private var indices: [Int] {
    return Array(nodes.indices)
  }

  public init(array: [T], sort: @escaping (T, T) -> Bool) {
    self.nodes = array
    self.hasPriority = sort
    configureHeap()
  }

  private mutating func configureHeap() -> Void {
    // because we know that leaves are from `floor(n/2)` to `n-1`, we can skip them
    // as they will get re-ordered during the `shiftDown` fn
    for i in stride(from: floor(Double(nodes.count/2)) - 1, through: 0, by: -1) {
      shiftDown(Int(i))
    }
  }

  public init(sort: @escaping (T, T) -> Bool) {
    self.nodes = []
    self.hasPriority = sort
  }

  public func peek() -> T? {
    return nodes.first
  }

  @discardableResult public mutating func remove() -> T? {
    guard count > 0 else {
      return nil
    }

    if count == 1 {
      return nodes.removeLast()
    }

    // save initial root value
    let rootNode = nodes[0]
    // take last value, stick it at top
    nodes[0] = nodes.removeLast()
    // shift down starting from root
    shiftDown(0)

    return rootNode
  }

  @discardableResult public mutating func remove(at idx: Int) -> T? {
    guard idx < count else {
      return nil
    }

    let size = count - 1

    // if node is last node, then we can safely remove without invalidating...
    if idx != size {
      // otherwise, we want to swap the node we want to remove with the last node
      nodes.swapAt(idx, size)
      // now we want to shiftDown the element we swapped with because it is now out of order
      // notice how we are using the size to dictate when to stop shifting...
      // we want to leave last value alone since we're removing it anyway
      shiftDown(from: idx, to: size)

      // want to shiftUp in instance where shiftDown has cause a child to have higher
      // priority over parent
      shiftUp(idx)
    }

    return nodes.removeLast()
  }

  public mutating func insert(_ x: T) -> Void {
    nodes.append(x)
    shiftUp(count - 1)
  }

  private mutating func shiftUp(_ idx: Int) -> Void {
    shiftUp(nodes[idx], parentIdx: parentIdx(ofIdx: idx), childIdx: idx)
  }

  private mutating func shiftUp(_ newNode: T, parentIdx: Int, childIdx: Int) -> Void {
    // when the child is no longer dominating parent, then we set the new node and return
    if childIdx == 0 || hasPriority(nodes[parentIdx], newNode) {
      nodes[childIdx] = newNode
      return
    }

    // otherwise we set the parent at child idx
    nodes[childIdx] = nodes[parentIdx]
    // parentIdx is really the new child/new node index here
    shiftUp(newNode, parentIdx: self.parentIdx(ofIdx: parentIdx), childIdx: parentIdx)
  }

  private mutating func shiftDown(from idx: Int, to endIdx: Int) -> Void {
    let children = [leftChildIdx(ofIdx: idx), rightChildIdx(ofIdx: idx)]

    let rootIdx = children.reduce(idx, { (rootIdx, childIdx) in
      // if left or right child has priority over root, then they are new root
      if childIdx < endIdx && hasPriority(nodes[childIdx], nodes[rootIdx]) {
        return childIdx
      }

      return rootIdx
    })

    // if neither right or left children have priority over root, then we're done
    if rootIdx == idx { return }

    // otherwise, swap current idx with new root and recur
    nodes.swapAt(idx, rootIdx)
    shiftDown(rootIdx)
  }

  private mutating func shiftDown(_ idx: Int) -> Void {
    shiftDown(from: idx, to: nodes.count)
  }

  public mutating func replace(index: Int, value: T) -> Void {
    remove(at: index)
    insert(value)
  }

  public func parentIdx(ofIdx idx: Int) -> Int {
    return Int(floor(Double((idx - 1)/2)))
  }

  public func leftChildIdx(ofIdx idx: Int) -> Int {
    return (2*idx) + 1
  }

  public func rightChildIdx(ofIdx idx: Int) -> Int {
    return (2*idx) + 2
  }
}
