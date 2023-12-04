import Algorithms
import Foundation

struct Scratchcard {
  let id: Int
  let winners: Int

  init(_ card: String) {
    var tokens = card.split(separator: ": ")
    self.id = Int(tokens[0].split(separator: " ")[1])!
    tokens = tokens[1].split(separator: " | ")
    let winningNumbers = Set(tokens[0].split(separator: " ").map { Int($0)! })
    let numbers = Set(tokens[1].split(separator: " ").map { Int($0)! })
    self.winners = winningNumbers.intersection(numbers).count
  }

  func score() -> Decimal {
    return winners == 0 ? 0 : pow(2, winners - 1)
  }
}
struct Day04: AdventDay {
  var data: String

  var cards: [Scratchcard] {
    data.trim().split(separator: "\n").map { Scratchcard(String($0)) }
  }

  func part1() -> Any {
    return cards.map { $0.score() }.reduce(0, +)
  }

  func part2() -> Any {
    var cards_count = [Int](repeating: 1, count: cards.count)
    for (i, card) in cards.enumerated() {
      for j in i + 1..<(i + 1 + card.winners) {
        cards_count[j] += cards_count[i]
      }
    }
    return cards_count.reduce(0, +)
  }
}
