//
//  BudgetInteractorTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 22/11/2018.
//

import XCTest
@testable import MoneySaverAppCore

class BudgetInteractorTests: XCTestCase {

    private var budgetRepository: FakeBudgetRepository!
    private var transactionsRepository: FakeTransactionsRepository!
    private var chartsDataProcessor: FakeChartsDataProcessor!
    private var calendar: FakeCalendar!
    private var sut: BudgetInteractor!
    
    override func setUp() {
        super.setUp()
        budgetRepository = FakeBudgetRepository()
        transactionsRepository = FakeTransactionsRepository()
        chartsDataProcessor = FakeChartsDataProcessor()
        calendar = FakeCalendar()
        sut = BudgetInteractor(budgetRepository: budgetRepository,
                               transactionsRepository: transactionsRepository,
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
    
    func test_whenTransactionsAndBudgetProvided_thenPresenterShouldBeUpdated() {
        let transaction = FakeTransactionBuilder().set(value: 10).build()
        let budget = FakeBudget(budgetValue: 100)
        calendar.nowCalendarDateToReturn = FakeCalendarDate()
        
        let presenter = FakePresenter()
        sut.presenter = presenter
        
        sut.loadData()
        transactionsRepository.transactionChangedCallback?([transaction])
        budgetRepository.passedBudgetChangedBlock?(budget)
        
        XCTAssertNotNil(presenter.passedBudget)
        XCTAssertNotNil(presenter.passedExpenses)
    }
    
    func test_whenTransactionsAndBudgetProvided_andNewBudgetNotified_thenPresenterShouldBeUpdated() {
        calendar.nowCalendarDateToReturn = FakeCalendarDate()
        
        let presenter = FakePresenter()
        sut.presenter = presenter
        
        sut.loadData()
        transactionsRepository.transactionChangedCallback?([FakeTransactionBuilder().set(value: 10).build()])
        budgetRepository.passedBudgetChangedBlock?(FakeBudget(budgetValue: 100))
        
        presenter.passedBudget = nil
        presenter.passedExpenses = nil
        
        budgetRepository.passedBudgetChangedBlock?(FakeBudget(budgetValue: 200))
        XCTAssertNotNil(presenter.passedBudget)
        XCTAssertNotNil(presenter.passedExpenses)
    }
    
    func test_whenTransactionAndBudgetProvided_andNewTransactionsNotified_thenPresenterShouldBeUpdated() {
        calendar.nowCalendarDateToReturn = FakeCalendarDate()
        
        let presenter = FakePresenter()
        sut.presenter = presenter
        
        sut.loadData()
        transactionsRepository.transactionChangedCallback?([FakeTransactionBuilder().set(value: 10).build()])
        budgetRepository.passedBudgetChangedBlock?(FakeBudget(budgetValue: 100))
        
        presenter.passedBudget = nil
        presenter.passedExpenses = nil
        
        transactionsRepository.transactionChangedCallback?([])
        XCTAssertNotNil(presenter.passedBudget)
        XCTAssertNotNil(presenter.passedExpenses)
    }
    
    func test_whenComputingCharts_thenCorrectDataShouldBePassedToProcessor() {
        let currentDate = FakeCalendarDate()
        currentDate.monthOfEra = 6
        calendar.nowCalendarDateToReturn = currentDate
        
        let transaction1 = FakeTransactionBuilder().set(value: Decimal(-10)).set(monthOfEra: 6).build()
        let transaction2 = FakeTransactionBuilder().set(value: Decimal(10)).set(monthOfEra: 6).build()
        let transaction3 = FakeTransactionBuilder().set(value: Decimal(-20)).set(monthOfEra: 5).build()
        
        let transactions = [transaction1, transaction2, transaction3]
        
        let presenter = FakePresenter()
        sut.presenter = presenter
        
        sut.loadData()
        transactionsRepository.transactionChangedCallback?(transactions)
        budgetRepository.passedBudgetChangedBlock?(FakeBudget(budgetValue: 300))
        
        // there should be only one transactionPassed - with correct month (6), and value < 0
        XCTAssertEqual(presenter.passedExpenses?.count, 1)
        XCTAssertEqual(presenter.passedExpenses?.first?.value.doubleValue, -10)
        XCTAssertEqual(presenter.passedBudget?.budgetValue, 300)
    }

}

private class FakePresenter: BudgetPresenterProtocol {
    
    var passedBudget: BudgetProtocol?
    var passedExpenses: [TransactionProtocol]?
    
    func dataUpdated(budget: BudgetProtocol, expenses: [TransactionProtocol]) {
        self.passedBudget = budget
        self.passedExpenses = expenses
    }
    
    func requestBudgetAmountEdit() { fatalError() }
    func saveBudget(amount: Decimal) { fatalError() }
    func loadData() { fatalError() }
}
