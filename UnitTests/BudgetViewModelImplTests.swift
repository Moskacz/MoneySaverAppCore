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
    private var transactionsRepository: FakeTransactionsRepository!
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

    func test_whenTransactionsAndBudgetProvided_thenShouldUpdateDelegate() {
        let transaction = FakeTransactionBuilder().set(value: 10).build()
        let budget = FakeBudget(budgetValue: 100)
        calendar.nowCalendarDateToReturn = FakeCalendarDate()
        
        let delegate = FakeBudgetViewModelDelegate()
        sut.delegate = delegate
        
        transactionsRepository.transactionChangedCallback?([transaction])
        budgetRepository.passedBudgetChangedBlock?(budget)
        
        XCTAssertNotNil(delegate.budgetData)
        XCTAssertNotNil(delegate.spendingsData)
    }
    
    func test_whenTransactionsAndBudgetProvided_andNewBudgetNotified_thenShouldCallDelegate() {
        calendar.nowCalendarDateToReturn = FakeCalendarDate()
        
        let delegate = FakeBudgetViewModelDelegate()
        sut.delegate = delegate
        
        transactionsRepository.transactionChangedCallback?([FakeTransactionBuilder().set(value: 10).build()])
        budgetRepository.passedBudgetChangedBlock?(FakeBudget(budgetValue: 100))
        
        delegate.spendingsData = nil
        delegate.budgetData = nil
        
        budgetRepository.passedBudgetChangedBlock?(FakeBudget(budgetValue: 200))
        XCTAssertNotNil(delegate.budgetData)
        XCTAssertNotNil(delegate.spendingsData)
    }
    
    func test_whenTransactionAndBudgetProvided_andNewTransactionsNotified_thenShouldCallDelegate() {
        calendar.nowCalendarDateToReturn = FakeCalendarDate()
        
        let delegate = FakeBudgetViewModelDelegate()
        sut.delegate = delegate
        
        transactionsRepository.transactionChangedCallback?([FakeTransactionBuilder().set(value: 10).build()])
        budgetRepository.passedBudgetChangedBlock?(FakeBudget(budgetValue: 100))
        
        delegate.spendingsData = nil
        delegate.budgetData = nil
        
        transactionsRepository.transactionChangedCallback?([])
        XCTAssertNotNil(delegate.budgetData)
        XCTAssertNotNil(delegate.spendingsData)
    }
    
    func test_whenComputingCharts_thenCorrectDataShouldBePassedToProcessor() {
        let currentDate = FakeCalendarDate()
        currentDate.monthOfEra = 6
        calendar.nowCalendarDateToReturn = currentDate
        
        let transaction1 = FakeTransactionBuilder().set(value: Decimal(-10)).set(monthOfEra: 6).build()
        let transaction2 = FakeTransactionBuilder().set(value: Decimal(10)).set(monthOfEra: 6).build()
        let transaction3 = FakeTransactionBuilder().set(value: Decimal(-20)).set(monthOfEra: 5).build()
        
        let transactions = [transaction1, transaction2, transaction3]
        
        transactionsRepository.transactionChangedCallback?(transactions)
        budgetRepository.passedBudgetChangedBlock?(FakeBudget(budgetValue: 300))
        
        let passedTransaction = chartsDataProcessor.passedTransactions!
        // there should be only one transactionPassed - with correct month (6), and value < 0
        XCTAssertEqual(passedTransaction.count, 1)
        XCTAssertEqual(passedTransaction.first?.value.doubleValue, -10)
        
        XCTAssertEqual(chartsDataProcessor.passedBudget, 300)
    }
}
