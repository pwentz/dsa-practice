#### Z-Algorithm

The Z-Algorithm is a string searching algorithm used to search for multiple occurences of a
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
