//
//  StatsViewModelTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 20.06.2018.
//

import XCTest
import Charts
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
    
    func test_whenNewTransactionsAreAvailable_thenDelegateShouldBeCalledWithNewData() {
        let delegate = FakeStatsViewModelDelegate()
        sut.delegate = delegate
        repository.transactionChangedCallback?([])
        XCTAssertNotNil(delegate.expensesData)
        XCTAssertNotNil(delegate.incomesData)
        XCTAssertNotNil(delegate.categoryExpensesData)
    }
    
    func test_whenGroupingIsChanged_thenDelegateShouldBeCalledWithNewData() {
        let delegate = FakeStatsViewModelDelegate()
        sut.delegate = delegate
        sut.selectedGroupingIntex = 2
        XCTAssertNotNil(delegate.expensesData)
        XCTAssertNotNil(delegate.incomesData)
        XCTAssertNil(delegate.categoryExpensesData)
    }
}

class FakeStatsViewModelDelegate: StatsViewModelDelegate {
    
    private(set) var expensesData: BarChartData?
    private(set) var incomesData: BarChartData?
    private(set) var categoryExpensesData: PieChartData?

    
    func stats(viewModel: StatsViewModel, didUpdateExpenses data: BarChartData) {
        expensesData = data
    }
    
    func stats(viewModel: StatsViewModel, didUpdateIncomes data: BarChartData) {
        incomesData = data
    }
    
    func stats(viewModel: StatsViewModel, didUpdateCategoryExpenses data: PieChartData) {
        categoryExpensesData = data
    }
}
