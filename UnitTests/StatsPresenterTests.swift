//
//  StatsPresenterTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 25/11/2018.
//

import XCTest
import Charts
import MMFoundation
@testable import MoneySaverAppCore

class StatsPresenterTests: XCTestCase {

    private var view: FakeView!
    private var interactor: FakeInteractor!
    private var chartsDataProcessor: FakeChartsDataProcessor!
    private var sut: StatsPresenter!
    
    override func setUp() {
        view = FakeView()
        interactor = FakeInteractor()
        chartsDataProcessor = FakeChartsDataProcessor()
        sut = StatsPresenter(interactor: interactor, chartsDataProcessor: chartsDataProcessor)
        sut.view = view
    }

    override func tearDown() {
        sut = nil
        interactor = nil
        chartsDataProcessor = nil
        view = nil
    }

    func test_setGroupingItems() {
        sut.start()
        XCTAssertEqual(view.groupingItems, [SegmentedControlItem.text("Day"),
                                            SegmentedControlItem.text("Week"),
                                            SegmentedControlItem.text("Month")])
    }
    
    func test_selectedIndex_whenThereIsNoPreferredGrouping_thenMonthShouldBeSelected() {
        interactor.preferredGrouping = nil
        sut.start()
        XCTAssertEqual(view.selectedGrouping, 2)
    }
    
    func test_selectedIndex_whenThereIsPrefferedGrouping_thenMatchingIndexShouldBeSelected() {
        interactor.preferredGrouping = .weekOfEra
        sut = StatsPresenter(interactor: interactor, chartsDataProcessor: chartsDataProcessor)
        sut.view = view
        sut.start()
        XCTAssertEqual(view.selectedGrouping, 1)
    }
    
    func test_selectedIndex_whenSet_thenPrefferedGroupingShouldBeUpdated() {
        sut.selectedGroupingIndex = 1
        XCTAssertEqual(interactor.preferredGrouping, .weekOfEra)
    }
    
    func test_selectedIndex_whenSet_dataShouldBeLoaded() {
        sut.selectedGroupingIndex = 1
        XCTAssertTrue(interactor.loadTransactionsCalled)
    }

    func test_dataLoaded_viewShouldBeUpdated() {
        sut.dataLoaded(transactions: [])
        XCTAssertNotNil(view.categoryExpenses)
        XCTAssertNotNil(view.incomes)
        XCTAssertNotNil(view.expenses)
    }
}

private class FakeInteractor: StatsInteractorProtocol {
    
    var preferredGrouping: TransactionsGrouping?
    
    var loadTransactionsCalled = false
    func loadTransactions() {
        loadTransactionsCalled = true
    }
}

private class FakeView: StatsUIProtocol {
    
    var groupingItems: [SegmentedControlItem]?
    func setGrouping(items: [SegmentedControlItem]) {
        groupingItems = items
    }
    
    var selectedGrouping: Int?
    func selectGrouping(index: Int) {
        selectedGrouping = index
    }
    
    var expenses: BarChartData?
    func showExpenses(data: BarChartData) {
        expenses = data
    }
    
    var incomes: BarChartData?
    func showIncomes(data: BarChartData) {
        incomes = data
    }
    
    var categoryExpenses: PieChartData?
    func showCategoryExpenses(data: PieChartData) {
        categoryExpenses = data
    }
}
