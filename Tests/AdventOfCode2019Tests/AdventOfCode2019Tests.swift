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
    
    func testDay7() throws {
        XCTAssertEqual(Day7Solution().run1(), "225056")
        XCTAssertEqual(Day7Solution().run2(), "14260332")
    }
    
    func testDay8() throws {
        XCTAssertEqual(Day8Solution().run1(), "1548")
        XCTAssertEqual(Day8Solution().run2(), "011001111010010100100110010010100001010010010100101000011100110001001010010100001000010100100101111010010100001010010010100100110011110100100110010010")
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
