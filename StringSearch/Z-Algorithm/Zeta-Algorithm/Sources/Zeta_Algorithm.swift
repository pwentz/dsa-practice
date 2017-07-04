// public func zetaAlgorithm(for text: String) -> [Int] {
//   guard let firstTextChar = text.characters.first else {
//     return []
//   }

//   var zeta: [Int] = [0]

//   for (idx, char) in text.characters.enumerated() {
//     guard idx > 0 else {
//       continue
//     }

//     if char == firstTextChar {
//       var score = 0

//       var patternCompareIdx = text.index(text.startIndex, offsetBy: idx)
//       var textCompareIdx = text.startIndex

//       while patternCompareIdx < text.endIndex {
//         guard text[textCompareIdx] == text[patternCompareIdx] else {
//           break
//         }

//         score += 1
//         patternCompareIdx = text.index(after: patternCompareIdx)
//         textCompareIdx = text.index(after: textCompareIdx)
//       }

//       zeta.append(score)
//     } else {
//       zeta.append(0)
//     }
//   }

//   return zeta
// }

func doesRightMatchPattern(_ text: String, _ right: Int, _ left: Int) -> Bool {
  let textLength = text.characters.count
  let rightIdx = text.index(text.startIndex, offsetBy: right)
  let patternIdx = text.index(text.startIndex, offsetBy: right - left)

  return right < textLength &&
          text.characters[rightIdx] == text.characters[patternIdx]
}

func zetaAlgorithm(for text: String) -> [Int]? {
  var rightBound = 0
  var leftBound = 0
  var zeta = Array(repeating: 0, count: text.characters.count)

  for k in 1..<text.characters.count {
    if k > rightBound {
      // right and left create "z-box" from beginning patterns
      // that match text[k]
      leftBound = k
      rightBound = k

      while doesRightMatchPattern(text, rightBound, leftBound) {
        rightBound += 1
      }

      zeta[k] = rightBound - leftBound
      rightBound -= 1
    } else {
      let k1 = k - leftBound

      // does zeta[k1] touch the right boundary of z-box?
      // since zeta[k1] is the # of common values from pattern,
      // we need to see if value will stretch out of z-box
      if zeta[k1] < rightBound - k + 1 {
        zeta[k] = zeta[k1]
      } else {
        // if value stretches out of z-box, then create a new
        // z-box with just text[k] and see if we can extend it
        leftBound = k

        while doesRightMatchPattern(text, rightBound, leftBound) {
          rightBound += 1
        }

        zeta[k] = rightBound - leftBound
        rightBound -= 1
      }
    }
  }

  return zeta
}

public func zAlgorithm(for pattern: String, in text: String) -> [Int] {
  let stringToSearch = pattern + "$" + text
  let patternLength = pattern.characters.count
  let fillerLength = patternLength + 1

  guard let zeta = zetaAlgorithm(for: stringToSearch), !zeta.isEmpty else {
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
