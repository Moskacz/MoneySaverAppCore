//
//  StatsViewModelTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 20.06.2018.
//

import XCTest
@testable import MoneySaverAppCore

class StatsViewModelTests: XCTestCase {
    
    var sut: StatsViewModelImpl!
    var repository: FakeTransactionsRepository!
    var chartsDataProcessor: FakeChartsDataProcessor!
    var userPreferences: FakeUserPreferences!
    
    override func setUp() {
        super.setUp()
        repository = FakeTransactionsRepository()
        chartsDataProcessor = FakeChartsDataProcessor()
        userPreferences = FakeUserPreferences()
        userPreferences.statsGrouping = .weekOfEra
        sut = StatsViewModelImpl(repository: repository,
                                 chartsDataProcessor: chartsDataProcessor,
                                 userPreferences: userPreferences)
    }
    
    override func tearDown() {
        sut = nil
        repository = nil
        chartsDataProcessor = nil
        userPreferences = nil
        super.tearDown()
    }
    
    func test_groupingItems() {
        let items = sut.groupingItems
        XCTAssertEqual(items[0], SegmentedControlItem.text(TransactionsGrouping.dayOfEra.description))
        XCTAssertEqual(items[1], SegmentedControlItem.text(TransactionsGrouping.weekOfEra.description))
        XCTAssertEqual(items[2], SegmentedControlItem.text(TransactionsGrouping.monthOfEra.description))
    }
    
    func test_selecedGroupingIndex_get() {
        XCTAssertEqual(sut.selectedGroupingIntex, 1)
    }
    
    func test_selectedGroupingIndex_set_userPreferencesShouldBeUpdated() {
        sut.selectedGroupingIntex = 2
        XCTAssertEqual(userPreferences.statsGrouping, .monthOfEra)
    }
}
