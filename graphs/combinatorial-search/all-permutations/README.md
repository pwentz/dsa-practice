#### All Permutations

A permutation is a specific variation of a set, except each "combination" is defined by
the order of it's elements. The algorithm employed to get the permutations of `n` relies
on the same primary backtracking algorithm employed in the subset problem. The variables
are mainly going to represent the same idea:
  - `a` represents a collection of possible candidates (represented as numbers here)
  - `k` represents our current position in the iteration process
  - `n` is our user input

The backtracking algorithm itself typically relies on a handful of functions for most of
it's variability. The ones we need for simple combination problems are as follows:

  - `isASolution(a, k, n)` - decides whether a full solution has been found
  - `processSolution(a, k)` - constructs solution given list of candidates and `k`
  - `constructCandidates(a, k)` - constructs a list of potential candidates (or neighbors of `k`) that
    (in this case) can be combined with `a` in some way

Other, more complex use cases of this algorithm may include a `makeMove` and `unmakeMove`, but they
won't be necessary for this problem.

Given our variables and those functions, we can pseudocode our use of the backtracking algorithm
as the following set of directions:
  - if `isASolution(a, k, n)`, then pass `a` and `k` to `processSolution`
  - otherwise, `constructCandidates`
    - for each of these candidates `i`:
      - set `a[k + 1] = i`
      - recursively call `backtrack`, passing in the updated `a` and `k + 1`

The main difference between this algorithm and the combinations solution, is how the candidates are
constructed. This algorithm uses a clever technique of constructing an `inPerm` array of all elements up to the input,
where each index represent a different up to the input, and the values themselves are a binary flag where
`1` means that a number is already in the current partial solution `a`, and `0` means that they are not.

The `constructCandidates` function iterates through all explored numbers (up to `k`) thus far and setting
numbers already included in the partial solution `a` to the `TRUE` flag in `inPerm`:

```.swift
for i in 0..<k {
  let explored = a[i]
  inPerm[explored] = TRUE
}
```

Next, the function goes through the numbers starting from `1` up to the `input` and adds any element to the
`candidates` collection where `inPerm[i] == FALSE`. We start from `1` because we've mainly been ignoring the
0th elements of `a`, they are simply there to prevent index overflow (**LOOK INTO WHETHER THIS IS NEEDED**).

```.swift
for i in 1...input {
  if inPerm[i] == FALSE {
    c[nCandidates] = i
    nCandidates += 1
  }
}
```
The `nCandidates` is needed to keep track of only valid candidates (array buffers skew `count` as a metric)

The last difference between this algorithm and combination algorithm is the `processSolution` function. In
the combinations solution, we were storing `a` as an array of booleans, so we needed to make that check. However
this time we simply need to iterate through `a` up to `k` to get our partial solution.
