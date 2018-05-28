//
//  TransactionsRepositoryTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 08.05.2018.
//

import XCTest
@testable import MoneySaverAppCore

class TransactionsRepositoryTests: XCTestCase {
    
    var coreDataStack: TemporaryCoreDataStack!
    var fakeCaledar: FakeCalendar!
    var sut: TransactionsRepositoryImplementation!
    
    override func setUp() {
        super.setUp()
        
        coreDataStack = TemporaryCoreDataStack()
        fakeCaledar = FakeCalendar()
        sut = TransactionsRepositoryImplementation(context: coreDataStack.getViewContext(),
                                                   logger: NullLogger(),
                                                   calendar: fakeCaledar)
    }
    
    override func tearDown() {
        sut = nil
        fakeCaledar = nil
        coreDataStack = nil
        super.tearDown()
    }
    
    func test_predicateForDateRange_ifRangeIsAllTime_thenShouldReturnNil() {
        fakeCaledar.nowToReturn = Date()
        let predicate = sut.predicate(forDateRange: .allTime)
        XCTAssertNil(predicate)
    }
    
    func test_predicateForDateRange_todayRange() {
        fakeCaledar.nowToReturn = Date()
        fakeCaledar.dayOfEraOfDateToReturn = 5
        
        let predicate = sut.predicate(forDateRange: .today)
        XCTAssertEqual(predicate?.predicateFormat, "date.dayOfEra == 5")
    }
    
    func test_predicateForDateRange_thisWeekRange() {
        fakeCaledar.nowToReturn = Date()
        fakeCaledar.weekOfEraOfDateToReturn = 5
        
        let predicate = sut.predicate(forDateRange: .thisWeek)
        XCTAssertEqual(predicate?.predicateFormat, "date.weekOfEra == 5")
    }
    
    func test_predicateForDateRange_thisMonth() {
        fakeCaledar.nowToReturn = Date()
        fakeCaledar.monthOfEraOfDateToReturn = 5
        
        let predicate = sut.predicate(forDateRange: .thisMonth)
        XCTAssertEqual(predicate?.predicateFormat, "date.monthOfEra == 5")
    }
    
    func test_predicateForDateRange_thisYear() {
        fakeCaledar.nowToReturn = Date()
        fakeCaledar.yearOfDateToReturn = 2018
        
        let predicate = sut.predicate(forDateRange: .thisYear)
        XCTAssertEqual(predicate?.predicateFormat, "date.year == 2018")
    }
    
    func test_groupedTransactions_dayGrouping() {
        let context = coreDataStack.getViewContext()
        
        let day1Transaction1 = TransactionManagedObject.createEntity(inContext: context)
        day1Transaction1.value = NSDecimalNumber(value: 20)
        day1Transaction1.date = calendarDate(dayOfEra: 1)
        
        let day1Transaction2 = TransactionManagedObject.createEntity(inContext: context)
        day1Transaction2.value = NSDecimalNumber(value: 10)
        day1Transaction2.date = calendarDate(dayOfEra: 1)
        
        let day2Transaction = TransactionManagedObject.createEntity(inContext: context)
        day2Transaction.value = NSDecimalNumber(value: 123)
        day2Transaction.date = calendarDate(dayOfEra: 2)
        
        let grouped = try! sut.groupedTransactions(grouping: .day)
//        XCTAssertEqual(grouped[0], DatedValue(date: 1, value: 30)) // 20 + 10
//        XCTAssertEqual(grouped[1], DatedValue(date: 2, value: 123))
    }
    
    func test_addTransaction_shouldCreateNewEntityInContextWithGivenData() {
        let context = coreDataStack.getViewContext()
        // 28/05/2018 @ 3:30pm (UTC)
        let transactionData = Date(timeIntervalSince1970: 1527521400)
        let data = TransactionData(title: "test", value: Decimal(-20), creationDate: transactionData)
        let category = TransactionCategoryManagedObject.createEntity(inContext: context)
        category.name = "category_name"
        sut.addTransaction(data: data, category: category)
        
        let transaction = context.registeredObjects.compactMap { $0 as? TransactionManagedObject }[0]
        XCTAssertEqual(transaction.title, "test")
        XCTAssertEqual(transaction.value, NSDecimalNumber(value: -20))
        XCTAssertEqual(transaction.date!.timeInterval, transactionData.timeIntervalSince1970, accuracy: 0.1)
        XCTAssertEqual(transaction.category!.name, "category_name")
    }
    
    func test_deleteTransaction_shouldRemoveItFromContext() {
        let context = coreDataStack.getViewContext()
        let transaction = TransactionManagedObject.createEntity(inContext: context)
        XCTAssertTrue(context.deletedObjects.isEmpty)
        sut.remove(transaction: transaction)
        XCTAssertEqual(context.deletedObjects.count, 1)
    }
    
    // MARK: Helpers
    
    private func calendarDate(dayOfEra: Int32 = 0, weekOfEra: Int32 = 0, monthOfEra: Int32 = 0) -> CalendarDateManagedObject {
        let context = coreDataStack.getViewContext()
        let date = CalendarDateManagedObject.createEntity(inContext: context)
        date.dayOfEra = dayOfEra
        date.weekOfEra = weekOfEra
        date.monthOfEra = monthOfEra
        return date
    }
}
