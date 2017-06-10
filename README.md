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

More coming soon...

###### Notes
Until I take the time and re-configure the directory structure of the `graphs` repo, `graphs/BreadthFirstSearch` contains BreadthFirstSearch AND DepthFirstSearch.
`graphs/breadth-first-search` contains breadth, depth, and topological algos
