struct DictGrid<T> {
  var cells: [Point: T]

  init() {
    cells = [Point: T]()
  }

  subscript(point: Point) -> T? {
    get {
      return cells[point]
    }
    set(newValue) {
      cells[point] = newValue
    }
  }

  func neighbors(of point: Point) -> [(Point, T)] {
    point.neighbors().compactMap { neighbor in
      if let value = self[neighbor] {
        return (neighbor, value)
      }
      return nil
    }
  }

  func neighbors(of point: Point, matching predicate: (T) -> Bool) -> [(Point, T)] {
    neighbors(of: point).filter { predicate($0.1) }
  }

  func north(from point: Point) -> (Point, T)? {
    let nextPoint = Point(x: point.x, y: point.y - 1)
    if let nextValue = self[nextPoint] {
      return (nextPoint, nextValue)
    }
    return nil
  }

  func south(from point: Point) -> (Point, T)? {
    let nextPoint = Point(x: point.x, y: point.y + 1)
    if let nextValue = self[nextPoint] {
      return (nextPoint, nextValue)
    }
    return nil
  }

  func east(from point: Point) -> (Point, T)? {
    let nextPoint = Point(x: point.x + 1, y: point.y)
    if let nextValue = self[nextPoint] {
      return (nextPoint, nextValue)
    }
    return nil
  }

  func west(from point: Point) -> (Point, T)? {
    let nextPoint = Point(x: point.x - 1, y: point.y)
    if let nextValue = self[nextPoint] {
      return (nextPoint, nextValue)
    }
    return nil
  }

  func northEast(from point: Point) -> (Point, T)? {
    let nextPoint = Point(x: point.x + 1, y: point.y - 1)
    if let nextValue = self[nextPoint] {
      return (nextPoint, nextValue)
    }
    return nil
  }

  func northWest(from point: Point) -> (Point, T)? {
    let nextPoint = Point(x: point.x - 1, y: point.y - 1)
    if let nextValue = self[nextPoint] {
      return (nextPoint, nextValue)
    }
    return nil
  }

  func southEast(from point: Point) -> (Point, T)? {
    let nextPoint = Point(x: point.x + 1, y: point.y + 1)
    if let nextValue = self[nextPoint] {
      return (nextPoint, nextValue)
    }
    return nil
  }

  func southWest(from point: Point) -> (Point, T)? {
    let nextPoint = Point(x: point.x - 1, y: point.y + 1)
    if let nextValue = self[nextPoint] {
      return (nextPoint, nextValue)
    }
    return nil
  }
}


