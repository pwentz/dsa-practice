### Knuth-Morris-Pratt

KMP is a string search algorithm that, like the Z-Algorithm, returns
the indices of a substring within a text field.

KMP is widely regarded as one of the best algorithms for solving
the string search problem. Although Boyer-Moore is more widely used
in practice and usually preferred, KMP produces all the indices of
a given pattern in the same (linear) running time as Boyer-Moore.


This algorithm relies heavily on a single array referred
to as `suffix-prefix`. The `suffix-prefix` array is a slight
variation on the `z-array`, and KMP even employs the `z-array`
in practice during the construction of `suffix-prefix`.

#### Suffix-Prefix

The `suffix-prefix` array is exactly like the `z-array`, except that
the values are in different places. If the position is a `z-array` represents
the _beginning_ at which a prefix matches the current character, or the _start_
of a subsequence, then the positions in `suffix-prefix` indicates the _end_ of
a subsequence at that particular index. The values themselves are the same, number
of characters matching prefix, but the positions are different.

Suppose we had a pattern `"ACTGACTA"`, the `z-array` array would look like this:

```
// z-array

0  1  2  3  4  5  6  7
A  C  T  G  A  C  T  A
0  0  0  0  3  0  0  1
```

While the `suffix-prefix` array looks like this:

```
// suffix prefix

0  1  2  3  4  5  6  7
A  C  T  G  A  C  T  A
0  0  0  0  0  0  3  1
```

Notice how, in the `z-array`, the `3` is positioned at index `4`. That's because `4` marks
the beginning of the substring `ACT` that matches the prefix of the text string. In the `suffix-prefix`
array, the `3` is instead at position `6`, because the end of substring `ACT` that matches
the prefix of the text is at position `6`.

Both the `z-array` and the `suffix-prefix` array both have `1` at position `7` because it
is the last element in the text, and therefore acts as both the start and the end of the
substring `A` that matches the prefix of the text string.

#### Steps

Once we have our suffix-prefix array, the steps themselves are surprisingly simple. First
we want to compare the first element of our `text` to the first element of our `pattern`.
So we would have a `patternIndex` variable and a `textIndex` variable that would both initially
equal `0`.

```
0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8
G C A C T G A C T G A C T G A C T A G
^
A C T G A C T A
0 1 2 3 4 5 6 7

0 0 0 0 0 0 3 1
```

On top we have our original text string, and below it we have our pattern text string. The
numbers aligned at the bottom is the `suffix-prefix` array and how it lines up with our pattern
string.

So we can see that `A` is not equal to `G`, so we increment our `textIndex` so that we're now
comparing the first char in our pattern against the next char in the text.

```
0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8
G C A C T G A C T G A C T G A C T A G
  ^
  A C T G A C T A
  0 1 2 3 4 5 6 7

  0 0 0 0 0 0 3 1
```

These two aren't equal either, so we move on the the next char in the text by incrementing
`textIndex`.

```
0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8
G C A C T G A C T G A C T G A C T A G
    ^
    A C T G A C T A
    0 1 2 3 4 5 6 7

    0 0 0 0 0 0 3 1
```

We found a match! So now we increment both `textIndex` and `patternIndex` to continue our
substring comparison

```
0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8
G C A C T G A C T G A C T G A C T A G
      ^
    A C T G A C T A
    0 1 2 3 4 5 6 7

    0 0 0 0 0 0 3 1
```

We keep incrementing `textIndex` and `patternIndex` until there is a mismatch.

```
0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8
G C A C T G A C T G A C T G A C T A G
                  ^
    A C T G A C T A
    0 1 2 3 4 5 6 7

    0 0 0 0 0 0 3 1
```

When there is a mismatch, we check the length of the match to see if it matches the pattern,
in which case we can record this in our final answer. However this is not the case, because our
match has a length of `7`, and our pattern has a length of `8`.

Although this substring doesn't completely match our pattern, there is a subtle optimization that
we can take advantage of using the `suffix-prefix` array. If we're looking at just the last 7 characters
that we matched against, we want to take a look at the last matching element in regards to it's position
in the `suffix-prefix` array, or `suffix-prefix[6]`. Right now we can take advantage of a few things that
we know to be true.

  - The chars in `text[2..8]` are equal to the chars in `pattern[0...6]`
  - If this is true, then the chars in `pattern[4..6]` must be equal to the chars in `text[6..8]`
  - Because `suffix-prefix[6]` has a value of `3`, we know that `pattern[4..6]` is equal to `pattern[0..2]`
    (if this is not obvious, please read `suffix-prefix` section above)


Since we know that `pattern[0..2]` is the same as `pattern[4..6]`, we can assume that the `3` (or whatever
the value is at `suffix-prefix[patternIndex - 1]`) characters before the last non-matching character at
`text[9]`, or `G`, are also equal to `pattern[0...2]`. We can use this knowledge to then "shift" the
pattern index so that the last non-matching char in `text` lines up with the last non-matching char in
`pattern`. So our `textIndex` will stay the same, but our `patternIndex` will be set to `3`.

```
0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8
G C A C T G A C T G A C T G A C T A G
                  ^
            A C T G A C T A
            0 1 2 3 4 5 6 7

            0 0 0 0 0 0 3 1
```

We have another match, so let's keep increasing both `textIndex` and `patternIndex` until we have a mismatch!

```
0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8
G C A C T G A C T G A C T G A C T A G
                          ^
            A C T G A C T A
            0 1 2 3 4 5 6 7

            0 0 0 0 0 0 3 1
```

It looks like this is another substring that doesn't quite match our pattern length.  Operating under the same
assumptions as before, we can adjust our `patternIndex` to equal `suffix-prefix[patternIndex] - 1 = 3`.

```
0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8
G C A C T G A C T G A C T G A C T A G
                          ^
                    A C T G A C T A
                    0 1 2 3 4 5 6 7

                    0 0 0 0 0 0 3 1
```

Again, we have a match and continue to increment `patternIndex` and `textIndex` until we have a mismatch
or until our pattern string runs out

```
0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8
G C A C T G A C T G A C T G A C T A G
                                  ^
                    A C T G A C T A
                    0 1 2 3 4 5 6 7

                    0 0 0 0 0 0 3 1
```

It looks like all the values in are pattern are a match! So we can record this match as `textIndex - patternIndex`,
or `10` since that's where the initial substring started. At this point, we wouldn't bother entering another
loop because the length of the pattern minus the new `patternIndex`, `1`, would be too long for another substring
to fit, so we end the comparisons here. However if we were to keep going, we would continue by comparing
`text[18]` with `pattern[1]`, since we know that `text[17]` is equal to `pattern[1]`
