import Algorithms
import Foundation

struct Day03: AdventDay {
  var data: String

  var grid: CharsGrid {
    CharsGrid(data.trim())
  }

  func part1() -> Any {
    var p1 = 0
    var y = 0
    while y < grid.height {
      var x = 0
      while x < grid.width {
        let p = Point(x: x, y: y)
        let (number, part) = getNumberNearSpecialSymbol(p)
        if !number.isEmpty {
          p1 += part ? Int(number)! : 0
          x += number.count
          continue
        }
        x += 1
      }
      y += 1
    }
    return p1
  }

  func part2() -> Any {
    var y = 0
    var gears = [Point: [Int]]()
    while y < grid.height {
      var x = 0
      while x < grid.width {
        let p = Point(x: x, y: y)
        let (number, nearbyGears) = getNumberNearGears(p)
        if !number.isEmpty {
          if !nearbyGears.isEmpty {
            nearbyGears.forEach({ gears[$0] = gears[$0] == nil ? [Int(number)!] : gears[$0]! + [Int(number)!] })
          }
          x += number.count
          continue
        }
        x += 1
      }
      y += 1
    }

    return gears.values
      .filter { $0.count == 2 }
      .map { $0.reduce(1, *) }
      .reduce(0, +)

  }

  private func isSpecialSymbol(_ c: Character) -> Bool {
    return !c.isNumber && c != "."
  }

  public func getNumberNearSpecialSymbol(_ p: Point) -> (String, Bool) {
    var acc = ""
    var crt = p
    var nearSpecialChar = false
    repeat {
      if let c = grid[crt], c.isNumber {
        acc.append(c)
        nearSpecialChar =
          nearSpecialChar || grid.neighbors(of: crt).contains { isSpecialSymbol($0.1) }
      } else {
        break
      }
      crt = crt.east()
    } while true
    return (acc, nearSpecialChar)
  }

  public func getNumberNearGears(_ p: Point) -> (String, Set<Point>) {
    var acc = ""
    var crt = p
    var nearbyGears = Set<Point>()
    repeat {
      if let c = grid[crt], c.isNumber {
        acc.append(c)
        nearbyGears.formUnion(grid.neighbors(of: crt, matching: { $0 == "*"}  ).map { $0.0 })
      } else {
        break
      }
      crt = crt.east()
    } while true
    return (acc, nearbyGears)
  }
}
