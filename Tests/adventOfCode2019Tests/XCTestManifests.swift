import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(adventOfCode2019Tests.allTests),
    ]
}
#endif
