#### Binomial Coefficient

You'll notice 2 different implementations. The "quick" version is a terse way to get the
bc of two numbers. However this particular implementation is prone to integer overflow.

The second implementation (labeled "binomial coefficient") can handle much larger inputs,
and recreates Pascal's Triangle, making it a bit more flexible as a solution.

```
0:               1
1:             1   1
2:           1   2   1
3:         1   3   3   1
4:       1   4   6   4   1
5:     1   5  10   10  5   1
6:   1   6  15  20   15  6   1
```

It does this by initializing an nXn 2D array, where the rows contain all zeros. We then loop
through all numbers up through n and set the first value of each row to `1` as well is the
`i`th value of each `i` row:

```.swift
for i in 0...n {
  bc[i][0] = 1
  bc[i][i] = 1
}
```

This is to fill in the 1s at the outer edges of the triangle.

The main part of the algorithm loops from numbers `1` through `n`, and then loops again
from `1` up to `i`. These loops calculate each number in the triangle by adding up the two
numbers from the previous row:

```.swift
for i in 1...n {
  for j in i..<i {
    bc[i][j] = bc[i - 1][j - 1] + bc[i - 1][j]
  }
}
```

In the inner loop, `bc[i - 1][j - 1]` represent the number in the row above, and one cell to the left.
`bc[i - 1][j]` represent the value directly above.

This particular implementation returns the actual number, `bc[n][k]` but the logic can be tweaked to just
return the triangle if that functionality is desired.
