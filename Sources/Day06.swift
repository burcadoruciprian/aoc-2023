struct Day06: AdventDay {

  var time: [Int]
  var distance: [Int]

  init(data: String) {
    let lines = data.split(separator: "\n")
    time = lines[0].split(separator: " ").compactMap { str in Int(str) }
    distance = lines[1].split(separator: " ").compactMap { str in Int(str) }
  }

  func part1() -> Any {
    var greater = [Int](repeating: 0, count: time.count)
    for (index, duration) in time.enumerated() {
      for holdTime in 0...duration {
        let travelDist = (duration - holdTime) * holdTime
        if travelDist > distance[index] {
          greater[index] += 1
        }
      }
    }
    return greater.reduce(1, *)
  }

  func part2() -> Any {
    let newTime = Int(time.map { String($0) }.joined())!
    let newDistance = Int(distance.map { String($0) }.joined())!
    var greater = 0

    for holdTime in 0...newTime {
      let travelDist = (newTime - holdTime) * holdTime
      if travelDist > newDistance {
        greater += 1
      }

    }
    return greater
  }
}
