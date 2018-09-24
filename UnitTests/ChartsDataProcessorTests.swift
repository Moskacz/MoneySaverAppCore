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
    
    func test_incrementalDailyExpenses_shouldBeSorted() {
        fakeCalendar.nowToReturn = Date()
        fakeCalendar.daysInMonthRangeToReturn = 1...30
        
        let transaction1 = FakeTransactionBuilder().set(dayOfEra: 10).set(value: Decimal(-10)).build()
        let transaction2 = FakeTransactionBuilder().set(dayOfEra: 1).set(value: Decimal(-30)).build()
        let transaction3 = FakeTransactionBuilder().set(dayOfEra: 5).set(value: Decimal(-100)).build()
        
        let transactions: [TransactionProtocol] = [transaction1, transaction2, transaction3]
        
        let expenses = sut.incrementalDailyExpenses(transactions: transactions)
        XCTAssertEqual(expenses[0].y, -30)
    }
    
    func test_incrementalDailyExpenses_values() {
        fakeCalendar.nowToReturn = Date()
        fakeCalendar.daysInMonthRangeToReturn = 1...30
        
        let transaction1 = FakeTransactionBuilder().set(dayOfEra: 10).set(value: Decimal(-10)).build()
        let transaction2 = FakeTransactionBuilder().set(dayOfEra: 1).set(value: Decimal(-30)).build()
        let transaction3 = FakeTransactionBuilder().set(dayOfEra: 5).set(value: Decimal(-100)).build()
        
        let transactions: [TransactionProtocol] = [transaction1, transaction2, transaction3]
        
        let expenses = sut.incrementalDailyExpenses(transactions: transactions)
        XCTAssertEqual(expenses[0].y, -30)
        XCTAssertEqual(expenses[4].y, -130)
        XCTAssertEqual(expenses[9].y, -140)
    }
    
    func test_incrementalDailyExpenses_spendingsCountShouldEqualDaysOfMonth() {
        let daysCount = 28
        fakeCalendar.nowToReturn = Date()
        fakeCalendar.daysInMonthRangeToReturn = 1...daysCount
        
        XCTAssertEqual(sut.incrementalDailyExpenses(transactions: []).count, daysCount)
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
        let budgetValue = Decimal(5000)
        let lastDaySpending = sut.estimatedSpendings(budgetValue: budgetValue).last!.y
        XCTAssertEqual(lastDaySpending, budgetValue)
    }
    
    func test_estimatedSpending_firstDaySpendingShouldNotBeZero() {
        fakeCalendar.nowToReturn = Date()
        fakeCalendar.daysInMonthRangeToReturn = 1...10
        let budgetValue = Decimal(1000)
        let firstDaySpending = sut.estimatedSpendings(budgetValue: budgetValue).first!.y
        XCTAssertTrue(firstDaySpending != 0)
        XCTAssertEqual(firstDaySpending, 100)
    }
 
    func test_groupedExpenses_byDayOfEra_shouldSumByDayOfEra() {
        let transaction1 = FakeTransactionBuilder().set(dayOfEra: 3).set(value: Decimal(-10)).build()
        let transaction2 = FakeTransactionBuilder().set(dayOfEra: 3).set(value: Decimal(-20)).build()
        let transaction3 = FakeTransactionBuilder().set(dayOfEra: 2).set(value: Decimal(-100)).build()
        
        let transactions = [transaction1, transaction2, transaction3]
        
        let values = sut.expensesGroupedBy(grouping: .dayOfEra, transactions: transactions)
        XCTAssertEqual(values.count, 2)
        XCTAssertEqual(values[0].y, -100)
        XCTAssertEqual(values[1].y, -30) // -10 - 20
    }
    
    func test_groupedIncomes_byWeekOfEra_shouldSumIncomesByWeekOfEra() {
        let transaction1 = FakeTransactionBuilder().set(weekOfEra: 1).set(value: Decimal(50)).build()
        let transaction2 = FakeTransactionBuilder().set(weekOfEra: 1).set(value: Decimal(60)).build()
        let transaction3 = FakeTransactionBuilder().set(weekOfEra: 2).set(value: Decimal(1000)).build()
        
        let transactions = [transaction1, transaction2, transaction3]
        
        let values = sut.incomesGroupedBy(grouping: .weekOfEra, transactions: transactions)
        XCTAssertEqual(values.count, 2)
        XCTAssertEqual(values[0].y, 110) // 50 + 60
        XCTAssertEqual(values[1].y, 1000)
    }

    func test_groupedExpenses_byCategories() {
        let transaction1 = FakeTransactionBuilder().set(categoryName: "categoryA").set(value: Decimal(-100)).build()
        let transaction2 = FakeTransactionBuilder().set(categoryName: "categoryA").set(value: Decimal(-200)).build()
        let transaction3 = FakeTransactionBuilder().set(categoryName: "categoryB").set(value: Decimal(-900)).build()
        
        let transactions = [transaction1, transaction2, transaction3]
        
        let values = sut.expensesGroupedByCategories(transactions)
        XCTAssertEqual(values.count, 2)
        XCTAssertEqual(values[0].categoryName, "categoryA")
        XCTAssertEqual(values[0].sum, -300) // -100 - 200
        XCTAssertEqual(values[1].categoryName, "categoryB")
        XCTAssertEqual(values[1].sum, -900)
    }
    
    func test_grouping_shouldCreateZeroValuesForNotExistingBetweenDates() {
        let transaction1 = FakeTransactionBuilder().set(dayOfEra: 1).set(value: Decimal(-10)).build()
        let transaction2 = FakeTransactionBuilder().set(dayOfEra: 10).set(value: Decimal(-100)).build()
        
        let groupedValues = sut.expensesGroupedBy(grouping: .dayOfEra, transactions: [transaction1, transaction2])
        XCTAssertEqual(groupedValues.count, 10)
        
        XCTAssertEqual(groupedValues[0].x, 1)
        XCTAssertEqual(groupedValues[0].y, -10)
        
        XCTAssertEqual(groupedValues[1].x, 2)
        XCTAssertEqual(groupedValues[1].y, 0)
        
        XCTAssertEqual(groupedValues[2].x, 3)
        XCTAssertEqual(groupedValues[2].y, 0)
        
        XCTAssertEqual(groupedValues[3].x, 4)
        XCTAssertEqual(groupedValues[3].y, 0)
        
        XCTAssertEqual(groupedValues[4].x, 5)
        XCTAssertEqual(groupedValues[4].y, 0)
        
        XCTAssertEqual(groupedValues[5].x, 6)
        XCTAssertEqual(groupedValues[5].y, 0)
        
        XCTAssertEqual(groupedValues[6].x, 7)
        XCTAssertEqual(groupedValues[6].y, 0)
        
        XCTAssertEqual(groupedValues[7].x, 8)
        XCTAssertEqual(groupedValues[7].y, 0)
        
        XCTAssertEqual(groupedValues[8].x, 9)
        XCTAssertEqual(groupedValues[8].y, 0)
        
        XCTAssertEqual(groupedValues[9].x, 10)
        XCTAssertEqual(groupedValues[9].y, -100)
    }
}
