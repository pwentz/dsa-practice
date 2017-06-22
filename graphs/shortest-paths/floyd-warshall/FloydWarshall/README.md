#### Floyd-Warshall Algorithm

Floyd-Warshall is an algorithm that can be used to efficiently find the shortest
path for all pairs in a weighted (directed or undirected) graph.

Floyd-Warshall is similar to Dijkstra's algorithm, with a few key differences:
 - FW finds the shortest path for all pairs, Dijkstra finds shortest path between two given pairs
 - FW employs an adjacency matrix instead of an adjacency list, making the algorithm more
   efficient than running Dijsktra's for all pairs of vertices
 - FW can work with negative weight edges

Floyd-Warshall's implementation relies on the adjacency matrix data structure.
Where it employs one to represent the shortest distance between nodes, and another to represent
the neighboring vertex for that path.

##### Adjacency Matrix

An Adjacency Matrix is a 2D array where a graph vertex is represented by an
index in this 2D array. The rows within the array represent the vertex as a
starting point, and each individual column within a row represents the
cost it takes to get to a separate vertex.

If the column index is the same as the current row index,
the value is represented by a 0 since it cost nothing to get to the
vertex that you start from.

If two vertices have no paths connecting one another, then the value
is represented by infinity.

![example_graph](./img/example_graph.png)

The graph above has an initial distance adjacency matrix of:

```
[[0.0,  4.0,  1.0,  3.0],
 [inf,  0.0,  8.0, -2.0],
 [inf,  inf,  0.0, -5.0],
 [inf,  inf,  inf,  0.0]]
```

and an initial parent/neighboring adjacency matrix of:
```
[[nil, 0.0, 0.0, 0.0],
 [inf, nil, 1.0, 1.0],
 [inf, inf, nil, 2.0],
 [inf, inf, inf, nil]]
```
where the value in each position represents the neighboring node
taken to achieve the value represented in the distance matrix

Therefore, the resulting adjacency matrix of the graph would look like:
```
[[0.0, 4.0, 1.0, -4.0],
 [inf, 0.0, 8.0, -2.0],
 [inf, inf, 0.0, -5.0],
 [inf, inf, inf, 0.0]]
```

##### Implementation

The steps Floyd-Warshall takes to produce the final matrix are as follows:
  - Get initial distance adjacency matrix from graph
  - Create initial parent/neighboring matrix
  - Traverse through each vertex which will act as the intermediary
    - For each intermediary, traverse through each vertex - where vertices will serve as starting points
      - For each starting vertex, traverse through each vertex - where vertices will serve as destination
      - If startVertex -> intermediary -> destination is less expensive than startVertex -> destination...
        - update distance matrix to represent cost of startVertex -> intermediary -> destination
        - update parent matrix of destination to point to intermediary vertex
