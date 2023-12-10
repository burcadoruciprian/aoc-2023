import Algorithms
import Foundation

struct Day05: AdventDay {
  init(data: String) {
    let lines = data.split(separator: "\n\n").map { String($0) }
    seeds = lines[0].split(separator: ": ")[1].split(separator: " ").map { Int($0)! }
    tranzitions = lines[1...].map { FromToMap($0) }
  }

  var seeds: [Int] = []
  var tranzitions: [FromToMap] = []

  func part1() -> Any {
    return self.seeds.map { self.seed_to_location($0) }.min()!
  }

  func part2() -> Any {
    var newSeeds = Set<Int>();

    for c in self.seeds.chunked(into: 2) {
      let l = c[0]
      let r = c[1]
      newSeeds.formUnion(l...l+r)
    }
    print(newSeeds.count)
    return self.seeds.map { self.seed_to_location($0) }.min()!

  }

  private func seed_to_location(_ seed: Int) -> Int {
    var location = seed
    for tranzition in self.tranzitions {
      location = tranzition.to(location)
    }
    return location
  }
}

struct FromToMap {
  var name: String
  var fromToRanges = [Range]()

  init(_ chunk: String) {
    let lines = chunk.split(separator: "\n")
    name = String(lines[0].split(separator: " ")[0])
    for line in lines[1...] {
      let tokens = line.split(separator: " ")
      assert(tokens.count == 3)
      fromToRanges.append(Range(Int(tokens[1])!, Int(tokens[0])!, Int(tokens[2])!))
      fromToRanges.sort()
    }
  }

  func to(_ value: Int) -> Int {
    for range in fromToRanges {
      if range.contains(value) {
        return range.to(value)
      }
    }
    return value
  }
}

struct Range: Comparable {
  var fromStart: Int
  var fromEnd: Int
  var toStart: Int
  var toEnd: Int

  init(_ fromStart: Int, _ endStart: Int, _ range: Int) {
    self.fromStart = fromStart
    self.fromEnd = fromStart + range
    self.toStart = endStart
    self.toEnd = endStart + range
  }

  func to(_ value: Int) -> Int {
    return toStart + value - fromStart
  }

  func contains(_ value: Int) -> Bool {
    return fromStart <= value && value <= fromEnd
  }

  static func < (lhs: Range, rhs: Range) -> Bool {
    return lhs.fromStart < rhs.fromStart
  }
}
