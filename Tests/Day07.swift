import XCTest

@testable import AdventOfCode

final class Day07Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
"""

  func testWorthWithWildJokers() throws {
    let hand1 = Hand("32T3K 1", true)
    XCTAssertEqual(hand1.worth, 1)
    let hand2 = Hand("JJJJJ 2", true)
    XCTAssertEqual(hand2.toString(), "JJJJJ")
    let hand3 = Hand("KJJJJ 1", true)
    XCTAssertEqual(hand3.toString(), "KKKKK")
    let hand4 = Hand("KQJJJ 2", true)
    XCTAssertEqual(hand4.toString(), "KQKKK")
    let hand5 = Hand("QQJJJ 1", true)
    XCTAssertEqual(hand5.toString(), "QQQQQ")
    let hand6 = Hand("QQQJJ 2", true)
    XCTAssertEqual(hand6.toString(), "QQQQQ")
    let hand7 = Hand("KQQJJ 1", true)
    XCTAssertEqual(hand7.toString(), "KQQQQ")
    let hand8 = Hand("KQTJJ 2", true)
    XCTAssertEqual(hand8.toString(), "KQTKK")
    let hand9 = Hand("KKKKJ 2", true)
    XCTAssertEqual(hand9.toString(), "KKKKK")
    let hand10 = Hand("KKKQJ 2", true)
    XCTAssertEqual(hand10.toString(), "KKKQK")
    let hand11 = Hand("KKQQJ 2", true)
    XCTAssertEqual(hand11.toString(), "KKQQK")
    let hand12 = Hand("KKQTJ 2", true)
    XCTAssertEqual(hand12.toString(), "KKQTK")
    let hand13 = Hand("KQT9J 2", true)
    XCTAssertEqual(hand13.toString(), "KQT9K")
  }
  
  func testPart1() throws {
    let challenge = Day07(data: testData)
    XCTAssertEqual(challenge.part1() as! Int, 6440)
  }

  func testPart2() throws {
    let challenge = Day07(data: testData)
    XCTAssertEqual(challenge.part2() as! Int, 5905)
  }
}