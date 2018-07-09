//
//  BudgetViewModelImplTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 09.07.2018.
//

import XCTest
@testable import MoneySaverAppCore

class BudgetViewModelImplTests: XCTestCase {

    private var budgetRepository: FakeBudgetRepository!
    private var transactionsRepository: TransactionsRepository!
    private var chartsDataProcessor: FakeChartsDataProcessor!
    private var calendar: FakeCalendar!
    private var sut: BudgetViewModelImpl!
    
    override func setUp() {
        super.setUp()
        budgetRepository = FakeBudgetRepository()
        transactionsRepository = FakeTransactionsRepository()
        chartsDataProcessor = FakeChartsDataProcessor()
        calendar = FakeCalendar()
        sut = BudgetViewModelImpl(budgetRepository: budgetRepository,
                                  transactionsRepository: transactionsRepository,
                                  chartsDataProcessor: chartsDataProcessor,
                                  calendar: calendar)
    }
    
    override func tearDown() {
        sut = nil
        calendar = nil
        chartsDataProcessor = nil
        transactionsRepository = nil
        budgetRepository = nil
        super.tearDown()
    }

    
}
