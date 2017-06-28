#### Data Structures:

The board should represent a struct with the following ivars:
  - 9x9 2D Array to serve as the representation of sudoku board
  - a moves array to store (x, y) tuples
    - this structure is necessary to keep track of the viable moves to be taken
      so that they persist through backtracking. The indices in this moves array
      matches up to values in `a` so that we can easily access correct answer when
      we want to make move.
  - count of how many open 0's are left


#### Steps:
BACKTRACK
  - Data Structures:
    - `a` : array to hold correct numbers
    - `k` : our current position through the backtracking, used to access correct
            values from `moves` arr and `a`
    - `board` : to hold the board

  - if board has no free spaces left, process solution.
  - otherwise, construct candidates...
  CONSTRUCT CANDIDATES
    - Find the x and y coords of the next square

      NEXT SQUARE
      - Going through all 81 cells, find the possible count for each (newCount)
        POSSIBLE COUNT
          - Return number of values that are true for possible values
          POSSIBLE VALUES
            - Given an x and a y
            - If current square is taken, or coords are invalid, then initiate a 10-item
              possibilities vector filled with true, where indices represent positions
            - If neither, then possibilities vector is all false
            - Going through numbers 0 - 8
              - find the number that is one square to the right of given square (m[x][i]),
                - if this number is taken, then set that position in possibilities to be false
              - find the number that is one square below given square (m[i][y]):
                - if this number is taken, then set that position in possibilities to be false
            - Then go through the sector (3x3 grid) and set all possibilities that are taken to false
      - if there are no possible squares to take, and the square that you're on is taken, then
        return invalid coords
      - if there are squares to take and the square you're on isn't taken, then return those coords

    - if x and y are invalid coords, then return empty array (pruning strategy)

    - create struct with points of x and y and add it at k in board moves array
    - grab possible values of square (x, y)
    - go through numbers 1 to 9 and append all true values to c that are possible

  - and increment k
  - for each of these candidates:
    - insert candidates into a at position k
    - pass a, k, and board to make move
    - recursively call backtrack
    - if finished is true, then return
    - otherwise, pass a, k, and board to unmakeMove
