struct Day07: AdventDay {

  var data: String

  func part1() -> Any {
    let hands = data.split(separator: "\n").map { Hand(String($0)) }
    return hands.sorted().enumerated().map { (index, hand) in
      hand.bid * (index + 1)
    }.reduce(0, +)
  }

  func part2() -> Any {
    let hands = data.split(separator: "\n").map { Hand(String($0), true) }
    return hands.sorted().enumerated().map { (index, hand) in
      hand.bid * (index + 1)
    }.reduce(0, +)
  }
}

struct Hand: Comparable {
  var cards: [Card]
  var bid: Int = 0
  var worth: Int = 0

  init(_ line: String, _ jokersAreWild: Bool = false) {
    let tokens = line.split(separator: " ").map { String($0) }
    cards = Array(tokens[0]).map({ Card($0, jokersAreWild) })
    bid = Int(tokens[1])!
    worth = jokersAreWild ? switchJokersAndCalcWorth() : calcWorth()
  }

  public func toString() -> String {
    return cards.map { String($0.suit) }.joined(separator: "")
  }

  private func switchJokersAndCalcWorth() -> Int {

    var hand = self.cards

    let pivot = hand.partition { $0.value == 1 }
    if pivot == hand.count || pivot == 0 {
      // No jokers or only jokers
      return calcWorth()
    }

    let noJokers = hand[0..<pivot]
    let mostCommon = DictCounter(noJokers).mostCommon()

    switch noJokers.count {
    case 4:
      let mc = mostCommon[0]
      switch mc.1 {
      case 4:
        return 6  // Five of a kind
      case 3:
        return 5  // Four of a kind
      case 2:
        let sm = mostCommon[1]
        if sm.1 == 2 {
          return 4  // Full house
        } else {
          return 3  // Three of a kind
        }
      default:
        return 1  // One pair
      }
    case 3:
      let mc = mostCommon[0]
      switch mc.1 {
      case 3:
        return 6  // Five of a kind
      case 2:
        return 5  // Four of a kind
      default:
        return 3  // Three of a kind
      }
    case 2:
      let mc = mostCommon[0]
      switch mc.1 {
      case 2:
        return 6  // Five of a kind
      default:
        return 5  // Four of a kind
      }
    case 1:
      return 6  // Five of a kind
    default:
      return 0
    }
  }

  private func calcWorth() -> Int {
    let counter = DictCounter(cards)
    if counter.size() == 1 {
      // Five of a kind
      return 6
    } else if counter.size() == 2 {
      // Four of a kind or full house
      return counter.values().contains(4) ? 5 : 4
    } else if counter.size() == 3 {
      // Three of a kind or two pairs
      return counter.values().contains(3) ? 3 : 2
    } else if counter.size() == 4 {
      // One pair
      return 1
    } else {
      // High card
      return 0
    }
  }

  static func < (lhs: Hand, rhs: Hand) -> Bool {

    if lhs.worth == rhs.worth {
      if let (l, r) = lhs.cards.firstDifferentValue(from: rhs.cards) {
        return l < r
      }
      return false
    }
    return lhs.worth < rhs.worth
  }

  static func == (lhs: Hand, rhs: Hand) -> Bool {
    return lhs.worth == rhs.worth && lhs.cards[0] == rhs.cards[0] && lhs.cards[1] == rhs.cards[1]
      && lhs.cards[2] == rhs.cards[2] && lhs.cards[3] == rhs.cards[3]
      && lhs.cards[4] == rhs.cards[4]

  }

}

struct Card: Comparable, Hashable {
  var value: Int
  var suit: Character

  init(_ suit: Character, _ jokersAreWild: Bool = false) {
    self.suit = suit
    switch suit {
    case "A":
      self.value = 14
    case "K":
      self.value = 13
    case "Q":
      self.value = 12
    case "J":
      self.value = jokersAreWild ? 1 : 11
    case "T":
      self.value = 10
    default:
      self.value = Int(String(suit))!
    }

  }

  static func < (lhs: Card, rhs: Card) -> Bool {
    return lhs.value < rhs.value
  }

  static func == (lhs: Card, rhs: Card) -> Bool {
    return lhs.value == rhs.value
  }
}
