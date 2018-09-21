//
//  TransactionsRepositoryTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 08.05.2018.
//

import XCTest
@testable import MoneySaverAppCore

class TransactionsRepositoryTests: XCTestCase {
    
    var coreDataStack: InMemoryCoreDataStack!
    var fakeCaledar: FakeCalendar!
    var sut: CoreDataTransactionsRepository!
    var notificationCenter: FakeTransactionNotificationCenter!
    
    override func setUp() {
        super.setUp()
        
        coreDataStack = InMemoryCoreDataStack()
        fakeCaledar = FakeCalendar()
        notificationCenter = FakeTransactionNotificationCenter()
        sut = CoreDataTransactionsRepository(context: coreDataStack.getViewContext(),
                                             logger: NullLogger(),
                                             calendar: fakeCaledar,
                                             notificationCenter: notificationCenter)
    }
    
    override func tearDown() {
        sut = nil
        fakeCaledar = nil
        coreDataStack = nil
        super.tearDown()
    }
    
    func test_addTransaction_shouldCreateNewEntityInContextWithGivenData() {
        let context = coreDataStack.getViewContext()
        // 28/05/2018 @ 3:30pm (UTC)
        let transactionData = Date(timeIntervalSince1970: 1527521400)
        let data = TransactionData(title: "test", value: Decimal(-20), creationDate: transactionData)
        let category = TransactionCategoryManagedObject.createEntity(inContext: context)
        category.cd_name = "category_name"
        sut.addTransaction(data: data, category: category)
        
        let transaction = context.registeredObjects.compactMap { $0 as? TransactionManagedObject }[0]
        XCTAssertEqual(transaction.title, "test")
        XCTAssertEqual(transaction.value, NSDecimalNumber(value: -20))
        XCTAssertEqual(transaction.date!.timeInterval, transactionData.timeIntervalSince1970, accuracy: 0.1)
        XCTAssertEqual(transaction.category!.name, "category_name")
    }
    
    func test_addTransaction_shouldPostNotification() {
        let category = TransactionCategoryManagedObject(context: coreDataStack.getViewContext())
        let data = TransactionData(title: "test", value: Decimal(-10), creationDate: Date())
        sut.addTransaction(data: data, category: category)
        XCTAssertNotNil(notificationCenter.postedNotification)
        XCTAssertEqual(notificationCenter.postedNotification?.transactions.count, 1)
    }
    
    func test_deleteTransaction_shouldRemoveItFromContext() throws {
        let context = coreDataStack.getViewContext()
        let category = TransactionCategoryManagedObject(context: coreDataStack.getViewContext())
        let data = TransactionData(title: "test", value: Decimal(-10), creationDate: Date())
        sut.addTransaction(data: data, category: category)
        XCTAssertEqual(context.registeredObjects.filter { $0 is TransactionManagedObject }.count, 1)
        let createdTransaction = context.registeredObjects.compactMap { $0 as? TransactionManagedObject }.first!
        sut.remove(transaction: createdTransaction)
        XCTAssertEqual(context.registeredObjects.filter { $0 is TransactionManagedObject }.count, 0)
    }
    
    func test_deleteTransaction_shouldPostNotification() {
        let transaction = TransactionManagedObject(context: coreDataStack.getViewContext())
        sut.remove(transaction: transaction)
        XCTAssertNotNil(notificationCenter.postedNotification)
    }
    
    // MARK: Helpers
    
    private func calendarDate(dayOfEra: Int32 = 0, weekOfEra: Int32 = 0, monthOfEra: Int32 = 0) -> CalendarDateManagedObject {
        let context = coreDataStack.getViewContext()
        let date = CalendarDateManagedObject.createEntity(inContext: context)
        date.cd_dayOfEra = dayOfEra
        date.cd_weekOfEra = weekOfEra
        date.cd_monthOfEra = monthOfEra
        return date
    }
}
