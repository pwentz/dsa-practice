extension String {

    // Helper function that steps backwards through both strings
    // until we find a character that doesn't match or until we've
    // reached the beginning of the pattern.
  private func backwards(_ p: Index, _ i: Index, _ pattern: String) -> Index? {
      var q = p
      var j = i
      while q > pattern.startIndex {
        j = index(before: j)
        q = index(before: q)

        if self[j] != pattern[q] { return nil }
      }

      return j
  }

  func indexOf(_ pattern: String) -> String.Index? {
    // Cache length of search pattern in order to reduce
    // expense of future calculations
    let patternLength = pattern.characters.count

    // if substring is empty or less than original -> nil
    guard patternLength > 0, patternLength <= characters.count else {
      return nil
    }

    // "skip" table to judge distance to skip ahead when character in pattern is found
    var skipTable: [Character: Int] = [:]

    for (i, c) in pattern.characters.enumerated() {
      skipTable[c] = patternLength - i - 1
    }

    let p = pattern.index(before: pattern.endIndex)
    let lastChar = pattern[p]

    // Pattern scanned right-to-left, skip ahead in string by
    // the length of the pattern. (Subtract 1 since startIndex already points
    // to the first character in the source string.)
    var i  = index(startIndex, offsetBy: patternLength - 1)

    // main loop. Keep going until the end of the string is reached.
    while i < endIndex {
      let c = self[i]

      // Does the current char match the last char from the pattern?
      if c == lastChar {

        // There is a possible match. Do brute-force search backwards
        if let k = backwards(p, i, pattern) { return k }

        // If no match, we can only safely skip one char ahead.
        i = index(after: i)
      } else {
        // Chars are not equal, so skip ahead. The amount to skip is
        // detemrind by the skip table. if the character is not present
        // int he pattern, we can skip ahead by the full pattern length.
        // However, if the char *IS* peresent in the pattern,
        // there may be a match up ahead and we can't skip as far.

        i = index(i, offsetBy: skipTable[c] ?? patternLength, limitedBy: endIndex) ?? endIndex
      }
    }

    return nil
  }
}
