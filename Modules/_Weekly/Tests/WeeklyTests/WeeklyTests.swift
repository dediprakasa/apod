import XCTest
@testable import Weekly

final class WeeklyTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Weekly().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
