extension String {
  func indexOf(_ sub: String) -> String.Index? {
    for i in characters.indices {
      var j = i
      var found = true

      for p in sub.characters.indices {
        if j == characters.endIndex || self[j] != sub[p] {
          found = false
          break
        }

        j = characters.index(after: j)
      }

      if found {
        return i
      }
    }

    return nil
  }
}
