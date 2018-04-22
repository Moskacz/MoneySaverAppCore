//
//  TestClassUnitTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 22.04.2018.
//

import XCTest
@testable import MoneySaverAppCore

class TestClassUnitTests: XCTestCase {
    
    func test_method() {
        let sut = TestClass()
        XCTAssertEqual(sut.testMethod(), 1)
    }
    
}
