import Algorithms
import Foundation

struct Day01: AdventDay {
  var data: String

  var lines: [String] {
    data.trim().components(separatedBy: .newlines)
  }

  func part1() -> Any {
    return lines.map({ (s: String) -> Int in
      let start = s.first(where: { $0.isNumber })!
      let end = s.last(where: { $0.isNumber })!
      return Int(String(start))! * 10 + Int(String(end))!
    }).reduce(0, +)

  }

  func part2() -> Any {
    return lines.map({ calibration($0) }).reduce(0, +)
  }

  func str2digit(string: String) -> Int? {
    let w = [
      "zero": 0, "one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7,
      "eight": 8, "nine": 9,
    ].first(where: { string.starts(with: $0.key) })

    return w != nil ? w!.value : nil
  }

  func calibration(_ s: String) -> Int {
    var digits: [Int] = []
    for (i, c) in s.enumerated() {
      if c.isNumber {
        digits.append(Int(String(c))!)
      } else {
        let index = s.index(s.startIndex, offsetBy: i)
        let remaining = String(s[index...])
        if let num = str2digit(string: String(remaining)) {
          digits.append(num)
        }
      }
    }
    return digits.first! * 10 + digits.last!
  }

}
