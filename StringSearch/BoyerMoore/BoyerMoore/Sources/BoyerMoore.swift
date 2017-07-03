extension String {
  func backwards(_ lastIdx: String.Index, _ pattern: String, _ currentIdx: String.Index) -> String.Index? {
    var patternIdx = lastIdx
    var stringIdx = currentIdx

    while patternIdx > pattern.startIndex {
      guard pattern[patternIdx] == self[stringIdx] else {
        return nil
      }

      patternIdx = pattern.index(before: patternIdx)
      stringIdx = self.index(before: stringIdx)
    }

    return stringIdx
  }

  func indexOf(_ pattern: String) -> String.Index? {
    let patternLength = pattern.characters.count

    guard patternLength > 0 && patternLength <= characters.count else {
      return nil
    }

    var skipTable: [Character: Int] = [:]

    for (idx, char) in pattern.characters.enumerated() {
      skipTable[char] = patternLength - idx - 1
    }

    let lastPatternIdx = pattern.index(before: pattern.endIndex)
    let lastPatternChar = pattern[lastPatternIdx]

    var idx = self.index(self.startIndex, offsetBy: patternLength - 1)

    while idx < self.endIndex {
      if self[idx] == lastPatternChar {
        if let resultIdx = backwards(lastPatternIdx, pattern, idx) {
          return resultIdx
        }

        idx = self.index(after: idx)
      } else {
        idx = self.index(idx, offsetBy: skipTable[self[idx]] ?? patternLength, limitedBy: self.endIndex) ?? self.endIndex
      }
    }

    return nil
  }
}
