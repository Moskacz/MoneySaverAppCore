//
//  StringTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 08.05.2018.
//

import XCTest
@testable import MoneySaverAppCore

class StringTests: XCTestCase {
    
    func test_firstUppercased() {
        XCTAssertEqual("".firstUppercased, "")
        XCTAssertEqual("aa".firstUppercased, "Aa")
        XCTAssertEqual("AAA".firstUppercased, "Aaa")
    }
    
}
