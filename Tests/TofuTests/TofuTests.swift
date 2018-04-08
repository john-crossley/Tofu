import XCTest
@testable import Tofu

final class TofuTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Tofu().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
