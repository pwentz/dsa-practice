func fibonacciDP(for n: Int) -> Int {
  // we can derive same benefits of caching by specifying the order of evaluation
  // of the recurrence relation instead of using mundane recursion

  // we only care about last 2 numbers since fibonacci is sum of last two
  var backTwo = 0
  var backOne = 1

  if n == 0 {
    return 0
  }

  for _ in 2..<n {
    let next = backOne + backTwo
    backTwo = backOne
    backOne = next
  }

  return backOne + backTwo
}
