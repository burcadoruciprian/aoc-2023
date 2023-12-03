import Algorithms
import Foundation

struct Day02: AdventDay {
  var data: String

  var lines: [String] {
    data.trim().components(separatedBy: .newlines)
  }
  func part1() -> Any {
    return lines.map { possible(String($0)) }.reduce(0, +)
  }

  func part2() -> Any {
    return lines.map { power(String($0)) }.reduce(0, +)
  }

  func possible(_ line: String) -> Int {
    let parts = line.split(separator: ": ")
    let id = Int(parts[0].split(separator: " ")[1])!
    for subset in parts[1].split(separator: "; ") {
      let colors = subset.split(separator: ", ")
      for color in colors {
        let vals = color.split(separator: " ")
        var r = 0
        var g = 0
        var b = 0
        switch vals[1] {
        case "red":
          r += Int(vals[0])!
        case "green":
          g += Int(vals[0])!
        case "blue":
          b += Int(vals[0])!
        default:
          break
        }

        if r > 12 || g > 13 || b > 14 {
          return 0
        }
      }

    }
    return id
  }

  func power(_ line: String) -> Int {
    let parts = line.split(separator: ": ")
    var r = 0
    var g = 0
    var b = 0
    for subset in parts[1].split(separator: "; ") {
      let colors = subset.split(separator: ", ")
      for color in colors {
        let vals = color.split(separator: " ")
        switch vals[1] {
        case "red":
          r = max(r, Int(vals[0])!)
        case "green":
          g = max(g, Int(vals[0])!)
        case "blue":
          b = max(b, Int(vals[0])!)
        default:
          break
        }
      }

    }

    return r * g * b
  }

}
