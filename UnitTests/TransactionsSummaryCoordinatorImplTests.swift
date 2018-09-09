//
//  TransactionsSummaryViewModelImplTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 10.07.2018.
//

import XCTest
@testable import MoneySaverAppCore

class TransactionsSummaryCoordinatorImplTests: XCTestCase {

    private var sut: TransactionsSummaryCoordinator!
    private var repository: FakeTransactionsRepository!
    private var calendar: FakeCalendar!
    
    override func setUp() {
        super.setUp()
        repository = FakeTransactionsRepository()
        calendar = FakeCalendar()
        sut = TransactionsSummaryCoordinatorImpl(repository: repository,
                                                 calendar: calendar,
                                                 dateRange: .allTime)
    }
    
    override func tearDown() {
        sut = nil
        repository = nil
        calendar = nil
        super.tearDown()
    }

    func test_afterReceivingValues_shouldUpdateValues() {
        calendar.nowCalendarDateToReturn = FakeCalendarDate()
        
        let transaction1 = FakeTransactionBuilder().set(value: Decimal(100)).build()
        let transaction2 = FakeTransactionBuilder().set(value: Decimal(-200)).build()
        
        let display = FakeDisplay()
        sut.display = display
        repository.transactionChangedCallback?([transaction1, transaction2])
        
        XCTAssertEqual(display.incomesText, "100.0")
        XCTAssertEqual(display.expenseText, "-200.0")
        XCTAssertEqual(display.totalAmountString, "-100.0")
        XCTAssertEqual(display.dateRangeTitle, "All")
    }
    
    func test_afterSetDateRange_shouldUpdateValues() {
        let date = FakeCalendarDate()
        date.dayOfEra = 3
        calendar.nowCalendarDateToReturn = date
        
        let transaction1 = FakeTransactionBuilder().set(value: Decimal(100)).set(dayOfEra: 3).build()
        let transaction2 = FakeTransactionBuilder().set(value: Decimal(-200)).set(dayOfEra: 4).build()
        
        let display = FakeDisplay()
        sut.display = display
        repository.transactionChangedCallback?([transaction1, transaction2])
        sut.dateRange = .today
        
        XCTAssertEqual(display.incomesText, "100.0")
        XCTAssertEqual(display.expenseText, "0.0")
        XCTAssertEqual(display.totalAmountString, "100.0")
        XCTAssertEqual(display.dateRangeTitle, "Today")
    }
}

private class FakeDisplay: TransactionsSummaryDisplaying {
    
    var dateRangeTitle: String?
    var incomesText: String?
    var expenseText: String?
    var totalAmountString: String?
    
    func set(dateRangeTitle: String?) {
        self.dateRangeTitle = dateRangeTitle
    }
    
    func set(incomesText: String?) {
        self.incomesText = incomesText
    }
    
    func set(expenseText: String?) {
        self.expenseText = expenseText
    }
    
    func set(totalAmountString: String?) {
        self.totalAmountString = totalAmountString
    }
    
}
