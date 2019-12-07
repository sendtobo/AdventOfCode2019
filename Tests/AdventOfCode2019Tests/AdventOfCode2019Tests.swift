import XCTest
import AdventOfCode2019

final class AdventOfCode2019Tests: XCTestCase {
    func testDay1() throws {
        XCTAssertEqual(Day1Solution().run1(), "3282386")
        XCTAssertEqual(Day1Solution().run2(), "4920708")
    }
    
    func testDay2() throws {
        XCTAssertEqual(Day2Solution().run1(), "12490719")
        XCTAssertEqual(Day2Solution().run2(), "2003")
    }
    
    func testDay3() throws {
        XCTAssertEqual(Day3Solution().run1(), "731")
        XCTAssertEqual(Day3Solution().run2(), "5672")
    }
    
    func testDay4() throws {
        XCTAssertEqual(Day4Solution().run1(), "1154")
        XCTAssertEqual(Day4Solution().run2(), "750")
    }
    
    func testDay5() throws {
        XCTAssertEqual(Day5Solution().run1(), "6069343")
        XCTAssertEqual(Day5Solution().run2(), "3188550")
    }
    
    func testDay6() throws {
        XCTAssertEqual(Day6Solution().run1(), "223251")
        XCTAssertEqual(Day6Solution().run2(), "430")
    }

    static var allTests = [
        ("testDay1", testDay1),
        ("testDay2", testDay2),
        ("testDay3", testDay3),
        ("testDay3", testDay4),
        ("testDay3", testDay5),
        ("testDay3", testDay6),
    ]
}
