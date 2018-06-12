//
//  ChartsDataProcessorTests.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 12.01.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import XCTest
@testable import MoneySaverAppCore

class ChartsDataProcessorTests: XCTestCase {
    
    var fakeCalendar: FakeCalendar!
    var sut: ChartsDataProcessor!
    
    
    override func setUp() {
        super.setUp()
        fakeCalendar = FakeCalendar()
        sut = ChartsDataProcessor(calendar: fakeCalendar)
    }
    
    override func tearDown() {
        sut = nil
        fakeCalendar = nil
        super.tearDown()
    }
    
    func test_spendingFromMonthlyExpenses_shouldSortPassedData() {
        fakeCalendar.nowToReturn = Date()
        fakeCalendar.daysInMonthRangeToReturn = 1...30
        
        let firstDayExpense = DatedValue(date: 1, value: Decimal(floatLiteral: 50))
        let secondDayExpense = DatedValue(date: 2, value: Decimal(floatLiteral: 10))
        let spendings = sut.spendings(fromMonthlyExpenses: [secondDayExpense, firstDayExpense])
        XCTAssertEqual(spendings[0].y, -50)
    }
    
    func test_monthlySpendings_dailyExpensesShouldBeSumOfEarlierDays() {
        fakeCalendar.nowToReturn = Date()
        fakeCalendar.daysInMonthRangeToReturn = 1...30
        
        let firstDayExpense = DatedValue(date: 1, value: Decimal(floatLiteral: 50))
        let secondDayExpense = DatedValue(date: 2, value: Decimal(floatLiteral: 10))
        let spendings = sut.spendings(fromMonthlyExpenses: [firstDayExpense, secondDayExpense])
        XCTAssertEqual(spendings[1].y, -60)
    }
    
    func test_monthlySpendings_spendingsCountShouldEqualDaysOfMonth() {
        let daysCount = 28
        fakeCalendar.nowToReturn = Date()
        fakeCalendar.daysInMonthRangeToReturn = 1...daysCount
        
        let spendings = sut.spendings(fromMonthlyExpenses: [])
        XCTAssertEqual(spendings.count, daysCount)
    }
    
    func test_estimatedSpending_spendingCountShouldEqualDaysOfMonth() {
        let daysCount = 28
        fakeCalendar.nowToReturn = Date()
        fakeCalendar.daysInMonthRangeToReturn = 1...daysCount
        
        let spendings = sut.estimatedSpendings(budgetValue: 0)
        XCTAssertEqual(spendings.count, daysCount)
    }
    
    func test_estimatedSpending_lastDaySpendingShouldEqualToBudgetValue() {
        fakeCalendar.nowToReturn = Date()
        fakeCalendar.daysInMonthRangeToReturn = 1...10
        let budgetValue = Double(5000)
        let lastDaySpending = sut.estimatedSpendings(budgetValue: budgetValue).last!.y
        XCTAssertEqual(lastDaySpending, Decimal(budgetValue))
    }
    
    func test_estimatedSpending_firstDaySpendingShouldNotBeZero() {
        fakeCalendar.nowToReturn = Date()
        fakeCalendar.daysInMonthRangeToReturn = 1...10
        let budgetValue = Double(1000)
        let firstDaySpending = sut.estimatedSpendings(budgetValue: budgetValue).first!.y
        XCTAssertTrue(firstDaySpending != 0)
        XCTAssertEqual(firstDaySpending, Decimal(100))
    }
 
    func test_groupedExpenses_byDayOfEra_shouldSumByDayOfEra() {
        let transaction1 = FakeTransaction()
        transaction1.transactionDate = calendarDate(dayOfEra: 3)
        transaction1.value = NSDecimalNumber(value: -10)
        
        let transaction2 = FakeTransaction()
        transaction2.transactionDate = calendarDate(dayOfEra: 3)
        transaction2.value = NSDecimalNumber(value: -20)
        
        let transaction3 = FakeTransaction()
        transaction3.transactionDate = calendarDate(dayOfEra: 2)
        transaction3.value = NSDecimalNumber(value: -100)
        
        let transactions = [transaction1, transaction2, transaction3]
        
        let values = sut.expensesGroupedBy(grouping: .dayOfEra, transactions: transactions)
        XCTAssertEqual(values.count, 2)
        XCTAssertEqual(values[0].y, Decimal(-100))
        XCTAssertEqual(values[1].y, Decimal(-30)) // -10 - 20
    }
    
    func test_groupedIncomes_byWeekOfEra_shouldSumIncomesByWeekOfEra() {
        let transaction1 = FakeTransaction()
        transaction1.transactionDate = calendarDate(weekOfEra: 1)
        transaction1.value = NSDecimalNumber(value: 50)
        
        let transaction2 = FakeTransaction()
        transaction2.transactionDate = calendarDate(weekOfEra: 1)
        transaction2.value = NSDecimalNumber(value: 60)
        
        let transaction3 = FakeTransaction()
        transaction3.transactionDate = calendarDate(weekOfEra: 2)
        transaction3.value = NSDecimalNumber(value: 1000)
        
        let transactions = [transaction1, transaction2, transaction3]
        
        let values = sut.incomesGroupedBy(grouping: .weekOfEra, transactions: transactions)
        XCTAssertEqual(values.count, 2)
        XCTAssertEqual(values[0].y, Decimal(110)) // 50 + 60
        XCTAssertEqual(values[1].y, Decimal(1000))
    }
    
    // MARK: Helpers
    
    private func calendarDate(dayOfEra: Int32 = 0,
                              weekOfEra: Int32 = 0,
                              monthOfEra: Int32 = 0) -> CalendarDateProtocol {
        let date = FakeCalendarDate()
        date.dayOfEra = dayOfEra
        date.weekOfEra = weekOfEra
        return date
    }
}
