//
//  SequenceIntExtensions.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 13.06.2018.
//

import XCTest
import MoneySaverAppCore

class SequenceIntExtensions: XCTestCase {
    
    func test_rangeOfMissingValues() {
        let values = [0, 9]
        let expectedMissingRange = 1...8
        let computedRanges = values.rangesOfMissingValues
        XCTAssertEqual(computedRanges.count, 1)
        XCTAssertEqual(computedRanges[0], expectedMissingRange)
    }
    
    func test_rangeOfMissingValues_multipleGaps() {
        let values = [0, 9, 13]
        let expectedRanges = [1...8, 10...12]
        XCTAssertEqual(values.rangesOfMissingValues, expectedRanges)
    }
    
}
