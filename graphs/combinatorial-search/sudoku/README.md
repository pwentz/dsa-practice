#### Data Structures:

The board should represent a struct with the following ivars:
  - 9x9 2D Array to serve as the representation of sudoku board
  - a `moves` array to store `(x, y)` tuples
    - this structure is necessary to keep track of the viable moves to be taken
      so that they persist through backtracking. The indices in this moves array
      matches up to values in `a` so that we can easily access correct answer when
      we want to make move.
  - count of how many open 0's are left

The backtrack function itself takes the same arguments as subsets and permutations:
  - `a` : array to hold correct numbers
  - `k` : our current position through the backtracking, used to access correct
          values from `moves` arr and `a`
  - `board` : to hold the board

Other variables that must be available are:
  - `finished` : boolean to represent whether game is finished or not, should be global
                 so that it can be referenced throughout stack


This algorithm employs a few more low-level functions than subsets or permutations,
the most important in this instance is `possible-values` and `next-square`:

##### Possible Values
- Given `x` and `y`
- create a 10-item possibilities vector, where each index represents a different
  number that can be implemented at `x, y`
  - the `0` position in this vector must remain false since `0` is not a valid sudoku number
- If square at `x`, `y` is taken, or coords given are invalid, then the remaining
  9 items in `possibilties` are all `false` - otherwise `true`
- Go through all of the numbers in the current square's row, column, and sector - marking
  `false` at the indices in which these different numbers appear

##### Next Square
- Go through all 81 squares in board
  - For each, get the number of `possible-values` that exist
  - If there are no possible values for a square, and the current square is not taken,
    then you're in an unwinnable position, and immediately return invalid coords
    - pruning technique. Iterating further would be wasted effort
  - If there are possible values an current square is not taken, then save current square
    to return at end of function
    - current implementations select the last valid open square, for some reason this
      yields much better performance than simple returning the first valid open square

##### Construct Candidates
- This implementation is similar to subsets and permutations, with a little added bookkeeping.
- Get the next square:
  - If this square is invalid, then return empty array (pruning...)
  - Otherwise, update the `moves` array at `k` for later access (or return moves with candidates, as in functional implementation)
  - Get all possible values for square
- Add the indices of these possible candidates to the candidates array and return it

##### Backtrack
This backtracking algorithm requires a few extra steps than the one in subsets and permutations.
The general idea is the same, we're going to try each candidate at `moves[k]` out and see if
they yield valid results. This time, however, we must unmake the move after we realize that it
did not lead to a winning solution.


- If the board has no free spaces, then marked `finished`
- Otherwise, increment `k` and grab next `candidates`
- For each candidates:
  - update `a` with candidate at `k`
  - update the board with the candidate at `moves[k]`
  - call backtrack recursively with new board, new a, and k
  - if `finished` is true (ie. the selected candidate eventually led to a complete solution), then return early
  - otherwise, update the board with `0` at `moves[k]`
    - this is a new step, since we must unmake the move if a candidate was poor
    - `construct-candidates` will return us an empty array if we should prune,
      in which case `backtrack` will immediately return

Keep in mind that there are only two ways for `backtrack` to return if finished is false:
  - we found a winning solution
  - there are no viable candidates (a result of pruning from `next-square->construct-candidates`)

Therefore, we can assume that if a backtrack has resolved, and the finished flag is still `false`,
then we have made a bad move and must unmake that move.
