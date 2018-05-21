//
//  UserPreferencesTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 08.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverAppCore

class UserPreferencesTests: XCTestCase {
    
    var sut: UserDefaults!
    var suiteName = "UserPreferencesTests"
    
    override func setUp() {
        super.setUp()
        sut = UserDefaults(suiteName: suiteName)!
    }
    
    override func tearDown() {
        sut.removePersistentDomain(forName: suiteName)
        super.tearDown()
    }
    
    func test_whenUserSavesDateRange_itShouldBeStored() {
        sut.dateRange = DateRange.thisMonth
        XCTAssertEqual(sut.dateRange, DateRange.thisMonth)
    }
    
    func test_whenThereIsNoSavedDateRange_thenAllTimeShouldBeReturned() {
        XCTAssertEqual(sut.dateRange, DateRange.allTime)
    }
    
    func test_whenThereIsNoSavedStatsGrouping_thenMonthShouldBeReturned() {
        XCTAssertEqual(sut.statsGrouping, TransactionsGrouping.month)
    }
    
    func test_whenUserSavedStatsGrouping_itShouldBeStored() {
        sut.statsGrouping = .week
        XCTAssertEqual(sut.statsGrouping, TransactionsGrouping.week)
    }
    
}
