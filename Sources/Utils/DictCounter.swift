struct DictCounter<Element: Hashable> {
  private var counts: [Element: Int] = [:]

  init<S: Sequence>(_ sequence: S) where S.Element == Element {
    for element in sequence {
      counts[element, default: 0] += 1
    }
  }

  func count_of(_ element: Element) -> Int {
    return counts[element, default: 0]
  }

  func size() -> Int {
    return counts.count
  }

  func values() -> [Int] {
    return Array(counts.values)
  }

  func keys() -> [Element] {
    return Array(counts.keys)
  }

  mutating func increment(for element: Element) {
    counts[element, default: 0] += 1
  }

  func mostCommon(n: Int? = nil) -> [(Element, Int)] {
        let sortedCounts = counts.sorted { $0.value > $1.value }
        if let n = n {
            return Array(sortedCounts.prefix(n))
        } else {
            return sortedCounts
        }
    }

    mutating func subtract<S: Sequence>(_ sequence: S) where S.Element == Element {
        for element in sequence {
            counts[element, default: 0] -= 1
            if counts[element]! <= 0 {
                counts.removeValue(forKey: element)
            }
        }
    }
}