public func zetaAlgorithm(for text: String) -> [Int] {
  guard let firstTextChar = text.characters.first else {
    return []
  }

  var zeta: [Int] = [0]

  for (idx, char) in text.characters.enumerated() {
    guard idx > 0 else {
      continue
    }

    if char == firstTextChar {
      var score = 0

      var patternCompareIdx = text.index(text.startIndex, offsetBy: idx)
      var textCompareIdx = text.startIndex

      while patternCompareIdx < text.endIndex {
        guard text[textCompareIdx] == text[patternCompareIdx] else {
          break
        }

        score += 1
        patternCompareIdx = text.index(after: patternCompareIdx)
        textCompareIdx = text.index(after: textCompareIdx)
      }

      zeta.append(score)
    } else {
      zeta.append(0)
    }
  }

  return zeta
}

public func zAlgorithm(for pattern: String, in text: String) -> [Int] {
  let stringToSearch = pattern + "$" + text
  let patternLength = pattern.characters.count
  let fillerLength = patternLength + 1

  let zeta = zetaAlgorithm(for: stringToSearch)

  guard !zeta.isEmpty else {
    return []
  }

  var result: [Int] = []

  for (idx, length) in zeta.enumerated() {
    if length == patternLength {
      result.append(idx - fillerLength)
    }
  }

  return result
}
