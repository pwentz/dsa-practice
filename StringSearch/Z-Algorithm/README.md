#### Z-Algorithm

The Z-Algorithm is a liner-time complexity string searching algorithm used to search for multiple occurences of a
pattern string inside a text string. Let's first start with the very basics of the algorithm and how it
works.


##### Basics

The implementation itself of the Z-Algorithm calculates the frequency of a prefix within the rest of
the string itself. The algorithm returns an array of frequencies, where each index represents the
character in the original string, and the values represent the starting index of the length of
a substring that matches the text's prefix.

To give you an idea, let's say we were searching through a string `"aabxaayaab"`,
since a string's prefix always involve it's first character, we're always going to put
an arbitrary value (we'll use `0`) for the first element before starting on the second character.

```
a a b x a a y a a b

0 ^
```

So for each character in the string, we will compare it with the first character in our prefix (or, the
first element in our entire text string). Since `a` is equal to `a`, we then compare the next incremental
position from our current index with the next incremental position in our prefix. So we would compare `b`
(at index 2) with `a` (at index 1). Since these do not equal, we put a `1` at our original position to
denote the number of chars that this index shares with the prefix.

```
a a b x a a y a a b

0 1 ^
```

Neither `b` nor `x` are equal to the first character in our prefix, so we mark them down as `0`.

```
a a b x a a y a a b

0 1 0 0 ^
```

We can see that our current position is equal to the first character of the prefix, and shifting to
the right, we can see that the next character in line is also equal to the next character in our prefix.
Since this pattern stops when we compare `y` with the `b` character in our prefix, we put a `2` in the
position of `a` (at index 4).

```
a a b x a a y a a b

0 1 0 0 2 ^
```

This next `a` matches the first `a` in our prefix, but the next character, `y`, does not equal the `b` in
our prefix, so we put a `1` for the `a` at index 5.

```
a a b x a a y a a b

0 1 0 0 2 1 0 ^
```

Again, we start by comparing our current character with the first char in the prefix, and, since `a` = `a`,
we move to our next character, `a` which also matches the next character in our prefix. Finally, we get to
`b`, which _also_ matches the next value in our prefix. Since there are no more characters left to compare
at this junction, we put a `3` at the `a` at index 7, because its the start of a `3n` substring that matches
our prefix.

```
a a b x a a y a a b

0 1 0 0 2 1 0 3 ^
```

Moving on to the next `a`, we compare this with the first char in our substring, which is clearly a match.
However, `b` is not equal to the `a` at the second position in our prefix, so this `a` only receives a `1`.

```
a a b x a a y a a b

0 1 0 0 2 1 0 3 1 0
```

Therefore our resulting z-array for `"aabxaayaab"` would be `[0, 1, 0, 0, 2, 1, 0, 3, 1, 0]`.

##### For Searching Strings

Above I explained the basic implementation of a z-array and how it works, but any string search
algorithm would have to take a `text` argument and a `pattern` argument to look for. So implementing
the Z-Algorithm in it's entirety requires a little work before and after to obtain an end result. We want
to utilize this z-array, so first we would pick an arbitrary character that does not appear in neither the
pattern nor the text (we'll go with `$` for this example) and concatenate our `text` string onto our `pattern`
string, with `$` acting as our separator. So if we were searching for `"CATA"` in `"GAGAACATACATGACCAT"`, then
our argument to the z-array function would look like:

```
"CATA$GAGAACATACATGACCAT"
```

So when we get our resulting array back, we want to get the indices (remember, this represent the positions of
the start of pattern) of all the elements that match the length of our original pattern. However these indices
are slightly skewed because we concatenated the strings together, so once we get those values we have to subtract
the length of our pattern + 1 from them (the `+ 1` is to account for the separating `$` character that we added).

```.swift
  for (idx, length) in zeta.enumerated() {
    if length == patternLength {
      result.append(idx - (patternLength + 1))
    }
  }
```

##### Optimizations

Although this is a clever algorithm, one can't help but notice that the current creation of our z-array
contains some inefficiencies that prevent it from performing in linear time. For example, generating a
z-array for a string `"aaaaaaaaaa"` takes quadratic time because you're comparing each character for
each character. This is where the idea of a "z-box" can introduce powerful optimization techniques.

###### Steps:

We first want to identify a `left` and a `right` to act as the left and right bounds of our z-box. We
also need an array, which we'll call `zeta` and initialize with all `0`'s and have a length equal to the
text string. Our main loop is an iteration over the values in our text string, starting with `1` since we
disregard the first value.

```
0  1  2  3  4  5  6  7
a  b  a  x  a  b  a  b
0

k - 1
left, right - 0
```

The first thing we want to do is check to make sure that `k` is greater than `right`. This is because
if `right` is greater than `k`, then that means we are operating out of a z-box and have processed this
value before. Otherwise, we want to first set `right` and `left` equal to `k`. This is to indicate that
we are not in any subsequence calculations, and therefore must compare our current character with the
first character in the input string.

```
0   1   2  3  4  5  6  7
a | b | a  x  a  b  a  b
0

k - 1
left - 1
right - 1
```

We then check to see the character at `k` (`b`) is equal to the first character in our subsequence (`a`, or
`text[right - left]`). It's not, so we set the current position `k` equal to `right - left` (`0`), and
we decrement `right` (WHY?) and finish up this iteration for `k = 1`.

On this second go-round, `k = 2` and `right = 0`, so we again set `left` and `right` equal to `k` and
evaluate `a` against the first char in our original sequence.

```
0  1   2  3  4  5  6  7
a  b | a | x  a  b  a  b
0  0   ^

k - 2
left - 2
right - 2
```

Since `text[right]` is equal to `text[right - left]`, or `text[0]`, we want to increment `right` to extend
the right bound of our temporary "z-box"

```
0  1   2  3   4  5  6  7
a  b | a  x | a  b  a  b
0  0   ^

k - 2
left - 2
right - 3
```

Now when we compare `text[right]`, (`"x"`) against `text[right - left]`, (`"b"`), we can see that the two are
not equal. So again we set our value at `k` equal to `right - left`. Because we're decrementing `right` again,
we indicate that we have not evaluated `x` against `text[0]` yet. Here's what our next iteration looks like
after we set `left` and `right` equal to `k`

```
0  1  2   3   4  5  6  7
a  b  a | x | a  b  a  b
0  0  1   ^

k - 3
left - 3
right - 3
```

Similar to the steps when `k = 1`, `x` is not equal to `text[0]`, so we update `zeta[k]` with `0` and move on
to the next value.

```
0  1  2  3   4   5  6  7
a  b  a  x | a | b  a  b
0  0  1  0   ^

k - 4
left - 4
right - 4
```

Again we can see that `text[right]` is equal to `text[right - left]`, so we can increment `right` and run
another comparison

```
0  1  2  3   4  5   6  7
a  b  a  x | a  b | a  b
0  0  1  0   ^

k - 4
left - 4
right - 5
```

Comparing `text[right]`, or `text[5]`, against `text[right - left]`, or `text[1]`, we can see that the two
are equal. So again we increment `right` to expand our subsequence comparison.

```
0  1  2  3   4  5  6   7
a  b  a  x | a  b  a | b
0  0  1  0   ^

k - 4
left - 4
right - 6
```

Yet again we can see that `text[right]` is equal to `text[right - left]`, or `text[2]`. And again we increment
`right` and keep comparing.

```
0  1  2  3   4  5  6  7
a  b  a  x | a  b  a  b |
0  0  1  0   ^

k - 4
left - 4
right - 7
```

Since `text[right]`, or `b` is not equal to `text[right - left]`, or `x`, we can now update our `zeta` array
at index `k` to equal `right - left`, and we decrement `right` again.

```
0  1  2  3   4  5  6   7
a  b  a  x | a  b  a | b
0  0  1  0   3  ^

k - 5
left - 4
right - 6
```

This is where things get interesting, since `k < right`, we now take a different control flow path than the
one we've been taking. With the way we have established these variables, we know that when `right` is greater
than `k`, then we have evaluated this subsequence before. So we then want to find position `k1`, which is
`k - left`, or the position corresponding value we have to compare against `text[k]`. Before we can just
copy over the value from `text[k1]`, we have to make sure that this particular value doesn't indicate
a subsequence that stretches _beyond_ our z-box. If `text[k1]` has a subsequence that could stretch outside
of our z-box, then we cannot copy since we would have to then evaluate the new characters outside of our
z-box to see if they are included in the subsequence as well.

In this instance, `text[k1]` is equal to `0`, and thus we can copy over this value and end this current
iteration.

```
0  1  2  3   4  5  6   7
a  b  a  x | a  b  a | b
0  0  1  0   3  0  ^

k - 6
left - 4
right - 6
```

It looks like `k` is still not greater than `right`, so we check if `a` can be copied over by seeing
if `zeta[k1]`, or `zeta[2]`, is less than `(right - k) + 1`. Since we had a subsequence length of 1
at `k = 2` and we have no room left in our z-box, we can't copy over the values,
so we have to reposition the left edge of our z-box so that `left = k`

```
0  1  2  3  4  5   6   7
a  b  a  x  a  b | a | b
0  0  1  0  3  0   ^

k - 6
left - 6
right - 6
```

Similar to before, we now go through and see if `text[right]` is equal to `text[right - left]`, and
increment `right` if that's the case.

```
0  1  2  3  4  5   6  7
a  b  a  x  a  b | a  b |
0  0  1  0  3  0   ^

k - 6
left - 6
right - 7
```

And again, we can see that `text[right]` is equal to `text[right - left]`, so we can increment `right`
again.

```
0  1  2  3  4  5   6  7
a  b  a  x  a  b | a  b |
0  0  1  0  3  0   ^

k - 6
left - 6
right - 8
```

Since we're at the edge of our text string, we cannot increment `right` any more. So we set `zeta[k]`
equal to `right - left` and decrement `right` before ending this iteration.

```
0  1  2  3  4  5   6  7
a  b  a  x  a  b | a  b |
0  0  1  0  3  0   2  ^

k - 7
left - 6
right - 7
```

Again, we can see that `k > right`, so we can set `k1` equal to `k - left`, or `1`. And when we check to
see the subsequence length at `zeta[1]`, we can see that it's `0`, meaning that we can simply copy over
the value to finish up this algorithm.

```
0  1  2  3  4  5  6  7
a  b  a  x  a  b  a  b
0  0  1  0  3  0  2  0
```
