import RegexBuilder

struct Day08: AdventDay {

  var directions: [Character]
  var nodes: Set<Node> = []

  init(data: String) {
    let nodeRegex = Regex {
      Capture {
        OneOrMore(.word)
      } transform: { match in
        String(match)
      }
      " = ("
      Capture {
        OneOrMore(.word)
      } transform: { match in
        String(match)
      }
      ", "
      Capture {
        OneOrMore(.word)
      } transform: { match in
        String(match)
      }
      ")"
    }

    let tokens = data.split(separator: "\n\n").map { String($0) }
    directions = Array(tokens[0].map { $0 })

    tokens[1].split(separator: "\n").forEach { (token) in
      if let result = try? nodeRegex.firstMatch(in: String(token)) {
        let (_, node) = nodes.insert(Node(name: result.1))
        let (_, left) = nodes.insert(Node(name: result.2))
        let (_, right) = nodes.insert(Node(name: result.3))
        node.left = left
        node.right = right
      }
    }
  }

  func part1() -> Any {
    var crt = nodes.first { $0.name == "AAA" }!
    var index = 0
    repeat {
      let direction = directions[index % directions.count]
      index += 1
      switch direction {
      case "L":
        crt = crt.left!
      case "R":
        crt = crt.right!
      default:
        fatalError("Unknown direction \(direction)")
      }
      if crt.name == "ZZZ" {
        return index
      }
    } while true
  }

  func part2() -> Any {
    var crts = nodes.filter { $0.name.last == "A" }.map { $0 }
    var cycle_len = [Int](repeating: 0, count: crts.count)
    var index = 0
    repeat {
      let direction = directions[index % directions.count]
      index += 1
      switch direction {
      case "L":
        crts = crts.map { $0.left! }
      case "R":
        crts = crts.map { $0.right! }
      default:
        fatalError("Unknown direction \(direction)")
      }
      crts.enumerated().forEach { (i, crt) in
        if crt.name.last == "Z" {
          cycle_len[i] = index
        }
      }

      if cycle_len.allSatisfy({ $0 > 0 }) {
        return cycle_len.reduce(1, lcm)
      }

    } while true
  }
}

class Node: Hashable {

  var name: String
  var left: Node?
  var right: Node?

  init(name: String) {
    self.name = name
  }

  static func == (lhs: Node, rhs: Node) -> Bool {
    lhs.name == rhs.name
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
  }
}
