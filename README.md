### Data Structures & Algorithms Practice

#### Build Instructions
###### Swift
  - clone the repo
  - make sure that you have Swift 3.0 installed
  - `cd` into one of the Swift directories (camelCased dir names)
  - run `swift build` to build the project
  - `swift test` runs the test suites

###### Clojure
  - clone the repo
  - `cd` into any of the Clojure repos (kebab-cased dir names)
  - `lein spec` will run the tests

#### Overview
This repo is used as practice for learning the various data structures and algorithms that are out there.
In order to really understand how these algorithms are implemented, I decided to first implement the
algorithm in Swift using an imperative/object-oriented approach, then I implement the algorithm
in Clojure using a functional, immutable appraoch.

The imperative solutions are heavily influenced from the [Swift Algorithms Club repo](https://github.com/raywenderlich/swift-algorithm-club).

#### Algorithms
##### Sorting
 - [selection sort](https://en.wikipedia.org/wiki/Selection_sort)
 - [insertion sort](https://en.wikipedia.org/wiki/Insertion_sort)
 - [merge sort](https://en.wikipedia.org/wiki/Merge_sort)
 - [quick sort](https://en.wikipedia.org/wiki/Quicksort)

##### Graphs
  - [breadth-first search](https://en.wikipedia.org/wiki/Breadth-first_search)
  - [depth-first search](https://en.wikipedia.org/wiki/Depth-first_search)
  - [topological sort](https://en.wikipedia.org/wiki/Topological_sorting)
  - [minimum spanning trees](https://en.wikipedia.org/wiki/Minimum_spanning_tree)
    - [prims](https://en.wikipedia.org/wiki/Prim%27s_algorithm)
    - [kruskals](https://en.wikipedia.org/wiki/Kruskal%27s_algorithm)
  - [dijkstra's](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm)
  - [floyd-warshall](https://en.wikipedia.org/wiki/Floyd%E2%80%93Warshall_algorithm)

##### Combinatorial Search
  - [construct all subsets](https://www8.cs.umu.se/kurser/TDBA77/VT06/algorithms/BOOK/BOOK2/NODE85.HTM#SECTION02511000000000000000)
  - [construct all permutations]()

More coming soon...

###### Notes
Until I have enough solutions to make a reasonable assumption about how the directory structure should unfold, the directories themselves are inconsistently grouped. All the graphing algorithms are in the `graphs` repo, `graphs/BreadthFirstSearch` contains BreadthFirstSearch AND DepthFirstSearch.
`graphs/breadth-first-search` contains breadth, depth, and topological algos
