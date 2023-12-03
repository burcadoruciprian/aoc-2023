struct Point: Hashable {
  var x: Int
  var y: Int

  func north() -> Point {
    return Point(x: x, y: y - 1)
  }

  func south() -> Point {
    return Point(x: x, y: y + 1)
  }

  func east() -> Point {
    return Point(x: x + 1, y: y)
  }

  func west() -> Point {
    return Point(x: x - 1, y: y)
  }

  func northeast() -> Point {
    return Point(x: x + 1, y: y - 1)
  }

  func northwest() -> Point {
    return Point(x: x - 1, y: y - 1)
  }

  func southeast() -> Point {
    return Point(x: x + 1, y: y + 1)
  }

  func southwest() -> Point {
    return Point(x: x - 1, y: y + 1)
  }

  func neighbors() -> [Point] {
    return [
      north(),
      south(),
      east(),
      west(),
      northeast(),
      northwest(),
      southeast(),
      southwest(),
    ]
  }
}
