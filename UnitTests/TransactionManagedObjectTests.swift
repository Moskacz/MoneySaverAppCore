//
//  TransactionManagedObjectTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 08.05.2018.
//

import XCTest
@testable import MoneySaverAppCore

class TransactionManagedObjectTests: XCTestCase {
    
    func test_groupByKeypath() {
        let dayKeypath = TransactionManagedObject.groupByKeypathFor(grouping: .day)
        XCTAssertEqual(dayKeypath.rawValue, "date.dayOfEra")
        
        let weekKeypath = TransactionManagedObject.groupByKeypathFor(grouping: .week)
        XCTAssertEqual(weekKeypath.rawValue, "date.weekOfEra")
        
        let monthKeypath = TransactionManagedObject.groupByKeypathFor(grouping: .month)
        XCTAssertEqual(monthKeypath.rawValue, "date.monthOfEra")
    }
    
}
