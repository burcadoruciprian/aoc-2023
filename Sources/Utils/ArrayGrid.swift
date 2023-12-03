import Collections

struct ArrayGrid<T> {
  var grid: [[T]]

  init(_ grid: [[T]]) {
    self.grid = grid
  }

  var width: Int {
    grid[0].count
  }

  var height: Int {
    grid.count
  }

  subscript(point: Point) -> T? {
    guard point.y >= 0, point.y < height, point.x >= 0, point.x < width else {
      return nil
    }
    return grid[point.y][point.x]
  }

  func neighbors(of point: Point, matching predicate: (T) -> Bool) -> [(Point, T)] {
    neighbors(of: point).filter { predicate($0.1) }
  }

  func neighbors(of point: Point) -> [(Point, T)] {
    point.neighbors().compactMap { neighbor in
      if let char = self[neighbor] {
        return (neighbor, char)
      }
      return nil
    }
  }

  func east(from point: Point) -> (Point, T)? {
    let nextPoint = Point(x: point.x + 1, y: point.y)
    if let nextChar = self[nextPoint] {
      return (nextPoint, nextChar)
    }
    return nil
  }

  func west(from point: Point) -> (Point, T)? {
    let previousPoint = Point(x: point.x - 1, y: point.y)
    if let previousChar = self[previousPoint] {
      return (previousPoint, previousChar)
    }
    return nil
  }

  func south(from point: Point) -> (Point, T)? {
    let nextPoint = Point(x: point.x, y: point.y + 1)
    if let nextChar = self[nextPoint] {
      return (nextPoint, nextChar)
    }
    return nil
  }

  func north(from point: Point) -> (Point, T)? {
    let previousPoint = Point(x: point.x, y: point.y - 1)
    if let previousChar = self[previousPoint] {
      return (previousPoint, previousChar)
    }
    return nil
  }

  func northEast(from point: Point) -> (Point, T)? {
    let northEastPoint = Point(x: point.x + 1, y: point.y - 1)
    if let northEastChar = self[northEastPoint] {
      return (northEastPoint, northEastChar)
    }
    return nil
  }

  func northWest(from point: Point) -> (Point, T)? {
    let northWestPoint = Point(x: point.x - 1, y: point.y - 1)
    if let northWestChar = self[northWestPoint] {
      return (northWestPoint, northWestChar)
    }
    return nil
  }

  func southEast(from point: Point) -> (Point, T)? {
    let southEastPoint = Point(x: point.x + 1, y: point.y + 1)
    if let southEastChar = self[southEastPoint] {
      return (southEastPoint, southEastChar)
    }
    return nil
  }

  func southWest(from point: Point) -> (Point, T)? {
    let southWestPoint = Point(x: point.x - 1, y: point.y + 1)
    if let southWestChar = self[southWestPoint] {
      return (southWestPoint, southWestChar)
    }
    return nil
  }
}

typealias CharsGrid = ArrayGrid<Character>
extension CharsGrid {
    init(_ grid: String) {
    self.grid = grid.split(separator: "\n").map { Array($0) }
  }

  init(_ grid: String, filter: (T) -> Bool) {
    let lines = grid.split(separator: "\n")
    self.grid = lines.map { line in
      line.filter(filter)
    }
  }
}

