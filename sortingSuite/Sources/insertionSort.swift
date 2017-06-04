func insertionSort(_ numbers: [Int]) -> [Int] {
  var arr = numbers

  for i in 1..<arr.count {
    var y = i

    // placeholder var
    let elt = arr[i]

    while y > 0 && elt < arr[y - 1] {
      // shift greater elements right
      arr[y] = arr[y - 1]
      y -= 1
    }

    // set placeholder in new position
    arr[y] = elt
  }

  return arr
}
