func fibonacciNumbers(for n: Int) -> Int {
  if n == 0 {
    return 0
  }

  if n == 1 {
    return 1
  }

  return (fibonacciNumbers(for: n - 1) + fibonacciNumbers(for: n - 2))
}
