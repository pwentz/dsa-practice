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

