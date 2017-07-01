func merge(leftParts: [Int], rightParts: [Int]) -> [Int] {
  var leftIndex = 0
  var rightIndex = 0

  var result: [Int] = []

  while leftIndex < leftParts.count && rightIndex < rightParts.count {
    if leftParts[leftIndex] < rightParts[rightIndex] {
      result.append(leftParts[leftIndex])
      leftIndex+=1
    }
    else if leftParts[leftIndex] > rightParts[rightIndex] {
      result.append(rightParts[rightIndex])
      rightIndex+=1
    }
    else {
      result.append(leftParts[leftIndex])
      leftIndex+=1
      result.append(rightParts[rightIndex])
      rightIndex+=1
    }
  }

  while leftIndex < leftParts.count {
    result.append(leftParts[leftIndex])
    leftIndex+=1
  }

  while rightIndex < rightParts.count {
    result.append(rightParts[rightIndex])
    rightIndex+=1
  }

  return result
}

func mergeSort(_ nums: [Int]) -> [Int] {
  guard nums.count > 1 else { return nums }

  let middle = nums.count / 2

  let leftParts = mergeSort(Array(nums[0..<middle]))
  let rightParts = mergeSort(Array(nums[middle..<nums.count]))

  return merge(leftParts: leftParts, rightParts: rightParts)
}
