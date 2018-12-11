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
        let dayKeypath = TransactionManagedObject.groupByKeypathFor(grouping: .dayOfEra)
        XCTAssertEqual(dayKeypath.string, "date.cd_dayOfEra")
        
        let weekKeypath = TransactionManagedObject.groupByKeypathFor(grouping: .weekOfEra)
        XCTAssertEqual(weekKeypath.string, "date.cd_weekOfEra")
        
        let monthKeypath = TransactionManagedObject.groupByKeypathFor(grouping: .monthOfEra)
        XCTAssertEqual(monthKeypath.string, "date.cd_monthOfEra")
    }
    
}
