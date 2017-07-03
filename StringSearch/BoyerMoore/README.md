##### Boyer-Moore String Search

The Boyer-Moore search algorithm is widely regarded as the benchmark for
string searching algorithms. Instead of using a brute force search,
Boyer-Moore lines up the search by first comparing the last element of the
pattern string with the equivalent position in the original.
So if you were searching for "World" in "Hello, World!", the algorithm
would start the comparison process like so:

```
Hello, World!
    ^
World
```

There are three possible scenarios that can be taken at this point:
  1. The two characters are a match
  2. The two characters are NOT a match, but the comparing character in
    the original string matches a different character in the pattern
  3. The comparing character appears nowhere in pattern

Although `d` is not equal to `o` in our first comparison, `o` does appear
in our comparing pattern. When this happens, we can then expedite our search
by lining up the `o` we just compared against with the `o` in our pattern.

This is done by creating a "skip" table, which is just a dictionary of
characters pointing to integer, which is simply a reverse-index So a skip table
for "World" would look like:

```
W: 4
o: 3
r: 2
l: 1
d: 0
```

These values are there to make it easy to figure out how many positions we can "skip"
when statement #2 is fulfilled. So when we're about to line up the `o` in our pattern
with the `o` in the original, we find the value for `o` in our skip table, and know
to jump ahead 3 positions.

```
// 1
Hello, World!
    |
 World
```

```
// 2
Hello, World!
    |
  World
```

```
// 3
Hello, World!
    |
   World
```

If a character appears more than once in a pattern, then the one nearest the end of the
pattern determines the skip value for that character.


Again, we compare the last character in our pattern with the character it lines
up with. We can see that the two don't match, but again the comparing character
in our original string `W` matches one in the pattern. So we line up
the characters like we did before:

```
Hello, World!
       ^
   World
```

```
Hello, World!
           ^
       World
```

Now that the two characters are a match, we can do a right-to-left, character-by-character
comparison of our pattern against the substring that it lines up with in the original string.

```
Hello, |World|!
           ^
       |World|
```

When they match we just return our current index. If the comparing character is neither equal
to the last element in our pattern nor present anywhere in the pattern (we can easily find this
out in O[1] time by going into our steps dictionary), then we can just skip over all the elements
lining up against our pattern:
```
The fox quickly jumped
    ^
puppy
```

So the next iteration would start like this

```
The fox quickly jumped
         ^
     puppy
```

And we would compare the last element in our pattern, `y`, with `u` and repeat the process over again.
