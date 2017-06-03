func selectionSort(_ nums: [Int]) -> [Int] {
  guard nums.count > 1 else {
    return nums
  }

  var arr = nums

  for i in 0..<arr.count {
    var lowestElt = i

    // find lowest
    for j in i+1..<arr.count {
      if arr[j] < arr[lowestElt] {
        lowestElt = j
      }
    }

    if arr[i] != arr[lowestElt] {
      swap(&arr[i], &arr[lowestElt])
    }
  }

  return arr
}
