private func doesRightMatchPattern(_ text: String, _ right: Int, _ left: Int) -> Bool {
  let textLength = text.characters.count
  let rightIdx = text.index(text.startIndex, offsetBy: right)
  let patternIdx = text.index(text.startIndex, offsetBy: right - left)

  return right < textLength &&
          text.characters[rightIdx] == text.characters[patternIdx]
}

func zArray(for text: String) -> [Int] {
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
