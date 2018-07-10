//
//  TransactionsSummaryViewModelImplTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 10.07.2018.
//

import XCTest
@testable import MoneySaverAppCore

class TransactionsSummaryViewModelImplTests: XCTestCase {

    private var sut: TransactionsSummaryViewModel!
    private var repository: FakeTransactionsRepository!
    private var calendar: FakeCalendar!
    
    override func setUp() {
        super.setUp()
        repository = FakeTransactionsRepository()
        calendar = FakeCalendar()
        sut = TransactionsSummaryViewModelImpl(repository: repository,
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
        
        let delegate = FakeDelegate()
        sut.delegate = delegate
        repository.transactionChangedCallback?([transaction1, transaction2])
        
        XCTAssertEqual(sut.incomesAmountText, "100.0")
        XCTAssertEqual(sut.expensesAmountText, "-200.0")
        XCTAssertEqual(sut.totalAmountText, "-100.0")
        XCTAssertEqual(sut.dateRangeButtonText, "All")
        XCTAssertTrue(delegate.delegateCalled)
    }
    
    func test_afterSetDateRange_shouldUpdateValues() {
        let date = FakeCalendarDate()
        date.dayOfEra = 3
        calendar.nowCalendarDateToReturn = date
        
        let transaction1 = FakeTransactionBuilder().set(value: Decimal(100)).set(dayOfEra: 3).build()
        let transaction2 = FakeTransactionBuilder().set(value: Decimal(-200)).set(dayOfEra: 4).build()
        
        let delegate = FakeDelegate()
        sut.delegate = delegate
        repository.transactionChangedCallback?([transaction1, transaction2])
        delegate.delegateCalled = false
        sut.dateRange = .today
        
        XCTAssertEqual(sut.incomesAmountText, "100.0")
        XCTAssertEqual(sut.expensesAmountText, "0.0")
        XCTAssertEqual(sut.totalAmountText, "100.0")
        XCTAssertEqual(sut.dateRangeButtonText, "Today")
        XCTAssertTrue(delegate.delegateCalled)
    }
}

private class FakeDelegate: TransactionsSummaryViewModelDelegate {
    var delegateCalled = false
    
    func transactionsSummaryDidUpdateValues(viewModel: TransactionsSummaryViewModel) {
        delegateCalled = true
    }
}
