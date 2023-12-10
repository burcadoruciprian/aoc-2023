extension String {
  func trim() -> String {
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}

extension Array {
  func chunked(into size: Int) -> [[Element]] {
    return stride(from: 0, to: count, by: size).map {
      Array(self[$0..<Swift.min($0 + size, count)])
    }
  }
}

extension Collection where Element: Equatable {
  func firstDifferentValue(from other: Self) -> (Element, Element)? {
    for (element1, element2) in zip(self, other) {
      if element1 != element2 {
        return (element1, element2)
      }
    }
    return nil
  }
}
