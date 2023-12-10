import XCTest

@testable import AdventOfCode

final class Day06Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
Time:      7  15   30
Distance:  9  40  200
"""

  func testPart1() throws {
    let challenge = Day06(data: testData)
    XCTAssertEqual(challenge.part1() as! Int, 288)
  }

  func testPart2() throws {
    let challenge = Day06(data: testData)
    XCTAssertEqual(challenge.part2() as! Int, 71503)
  }
}