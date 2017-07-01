#### Construct All Subsets

The problem here is a specific combinatorial one, find all of the subsets of a set
`{1 ... n}}` where `n` is the given input. For example, if `n` was equal to 1,
then the resulting subsets would be `#{}, #{1}`.

This algorithm can be a bit tricky if the implementation isn't explained sufficiently.

- The primary backtracking function takes 3 inputs:
  - `a`: an array of booleans with a length of `k + 1` (we're ignoring the first element of `a`)
  - `k`: our current position in the iteration process
  - `input`: the original user input
- The algorithm also relies on 2 global constants:
  - `candidates` which is an array of possible values for elements in `a` (`candidates = [true, false]`)
  - `n-candidates` which is the length of `candidates` (`n-candidates = 2`)

- Starting `k` at 0
- Check is `k` is equal to input `n`
- If `k` is equal to `n`, then construct a subset from `a`, where the integers
  in the subset are equal to the indices of `a` (ignoring `0`) that are set to `true`
- If `k` is NOT equal to `n`, then for each value up to (but not including) `n-candidates`, `i`,
  calling backtrack recursively, except `a[k + 1] = candidates[i]`, and `k = k + 1`
  - This is the primary logic for the backtracking algorithm, the idea is that the values in `a`
    which are true represent combinations which are acceptable for a new subset of the original input.
    Setting `a[k + 1] = candidates[i]` will ensure that new subsets are constructed beginning with
    a different number each time. So through the first iteration of `n-candidates`, where `a[k + 1]`
    is set to `true`, will construct all subsets that start with 1, then the next iteration would be
    remaining subsets starting with `2`, and so on.

For example, if `n = 3`, then our output would be ordered like so:

```
[1 2 3]
[1 2]
[1 3]
[1]
[2 3]
[2]
[3]
[]
```

Below is a high-level stack trace for how the implementation works:
```.swift
// BTRACK-1 - k = 0 / a = [false, false, false] / solutions = []
//    FOR i in 0...1
//      i = 0/TRUE
//      BTRACK-1.1 - k = 1 / a = [true, false, false] / sol's = []
//        FOR i in 0...1
//          i = 0/TRUE
//          BTRACK-1.1.1 - k = 2 / a = [true, true, false] / sol's = []
 //           FOR i in 0...1
 //            i = 0/TRUE
 //            BTRACK-1.1.1.1 - k = 3 / a = [true, true, true] / sol's = []
 //              k == 3 -> RETURNS (new sol = [1 2 3])
 //            i = 1/FALSE
 //            BTRACK-1.1.1.2 - k = 3 / a = [true, true, FALSE] / sol's = [[1 2 3]]
 //              k == 3 -> RETURNS (new sol = [1 2])
 //           ENDFOR (1.1.1)
//          i = 1/FALSE
//          BTRACK-1.1.2 - k = 2 / a = [true, FALSE, FALSE] / sol's = [[1 2 3], [1 2]]
//            FOR i in 0...1
//             i = 0/TRUE (a[k+1] = true)
//             BTRACK-1.1.2.1 - k = 3 / a = [true, FALSE, true] / sol's = [[1 2 3], [1 2]]
//               k == 3 -> RETURNS (new sol = [1 3])
//             i = 1/FALSE (a[k+1] = false
//             BTRACK -1.1.2.2 - k = 3 / a = [true, FALSE, FALSE] / sol's = [[1 2 3], [1 2], [1 3]]
//               k == 3 -> RETURNS (new sol = [1])
//            ENDFOR (1.1.2)
//        ENDFOR (1.1)
//      i = 1/FALSE (a[1] = false)
//      BTRACK-1.2 - k = 1 / a = [FALSE, FALSE, FALSE] / sol's = [[1 2 3], [1 2], [1 3], [1]
//        FOR i in 0...1
//         i = 0/TRUE (a[2] = true)
//         BTRACK-1.2.1 - k = 2 / a = [FALSE, true, FALSE] / sol's = [[1 2 3], [1 2], [1 3], [1]
//          FOR i in 0...1
//            i = 0/TRUE (a[3] = true)
//            BTRACK-1.2.1.1 - k = 3 / a = [FALSE, true, true] / sol's = [[1 2 3], [1 2], [1 3], [1]
//              k == 3 -> RETURNS (new sol = [2 3])
//            i = 1/FALSE (a[3] = FALSE)
//            BTRACK-1.2.1.1 - k = 3 / a = [FALSE, true, FALSE] / sol's = [[1 2 3], [1 2], [1 3], [1], [2 3]]
//              k == 3 -> RETURNS (new sol = [2])
//          ENDFOR (1.2.1)
//         i = 1/FALSE (a[2] = FALSE)
//         BTRACK-1.2.2 - k = 2 / a = [FALSE, FALSE, FALSE] / sol's = [[1 2 3], [1 2], [1 3], [1], [2 3], [2]]
//           FOR i in 0...1
  //           i = 0/TRUE (a[3] = true)
  //           BTRACK-1.2.2.1 - k = 3 / a = [FALSE, FALSE, true] / sol's = [[1 2 3], [1 2], [1 3], [1], [2 3], [2]]
  //             k == 3 -> RETURNS (new sol = [3])
  //           i = 1/FALSE (a[3] = FALSE)
  //           BTRACK-1.2.2.1 - k = 3 / a = [FALSE, FALSE, FALSE] / sol's = [[1 2 3], [1 2], [1 3], [1], [2 3], [2], [3]
  //             k == 3 -> RETURNS (new sol = [])
//           ENDFOR (1.2.2)
//        ENDFOR (1.2)
//    ENDFOR (1)
// FINAL SOLUTION - [[1 2 3], [1 2], [1 3], [1], [2 3], [2], [3], []]
```
