public func getSuffixPrefix(for pattern: String) -> [Int] {
  let zeta = zArray(for: pattern)
  var suffixPrefix = Array(repeating: 0, count: pattern.characters.count)

  for i in 1..<pattern.characters.count {
    let t = i + zeta[i] - 1
    suffixPrefix[t] = zeta[i]
  }

  return suffixPrefix
}

extension String {
  func indicesOf(_ ptrn: String) -> [Int] {
    let text = Array(self.characters)
    let pattern = Array(ptrn.characters)

    let textLength = text.count
    let patternLength = pattern.count

    guard patternLength > 0 else {
      return []
    }

    let suffixPrefix = getSuffixPrefix(for: ptrn)
    var indices: [Int] = []

    var textIndex = 0
    var patternIndex = 0

    // main loop
    while textIndex + (patternLength - patternIndex - 1) < textLength {

      // increment text and pattern index so long as chars match
      while patternIndex < patternLength && pattern[patternIndex] == text[textIndex]  {
        textIndex += 1
        patternIndex += 1
      }

      // if we found a complete substring match, add to final result
      if patternIndex == patternLength {
        indices.append(textIndex - patternIndex)
      }

      // if chars don't match, move 1 char to the right
      if patternIndex == 0 {
        textIndex += 1
      } else {
        // otherwise, skip pattern to equal substring
        patternIndex = suffixPrefix[patternIndex - 1]
      }
    }

    return indices
  }
}
