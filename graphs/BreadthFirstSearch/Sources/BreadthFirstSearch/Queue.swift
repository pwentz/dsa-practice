public struct Queue<T> {
  var q: [T] = []

  public mutating func enqueue(_ elt: T) {
    q.append(elt)
  }

  public mutating func dequeue() -> T? {
    return q.isEmpty ? nil : q.removeFirst()
  }
}
