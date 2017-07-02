// Explicit caching of results provides most benefits of DP
// including usually the same running time - but we can
// improve our solution with very subtle changes

let UNKNOWN = -1
var f = [0, 1]

func fibonacciCaching(for n: Int) -> Int {
  if f[n] == UNKNOWN {
    f[n] = fibonacciCaching(for: n - 1) + fibonacciCaching(for: n - 2)
  }

  return f[n]
}

func fibonacciCachingDriver(for n: Int) -> Int {
  for i in 2...n {
    f.append(UNKNOWN)
  }

  return fibonacciCaching(for: n)
}
