import XCTest

import FileTypeTests

var tests = [XCTestCaseEntry]()
tests += FileTypeTests.allTests()
XCTMain(tests)
