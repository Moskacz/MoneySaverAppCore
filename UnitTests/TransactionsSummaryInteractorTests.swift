//
//  TransactionsSummaryInteractorTests
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 10.07.2018.
//

import XCTest
@testable import MoneySaverAppCore

class TransactionsSummaryInteractorTests: XCTestCase {

    private var sut: TransactionsSummaryInteractor!
    private var repository: FakeTransactionsRepository!
    private var calendar: FakeCalendar!
    
    override func setUp() {
        super.setUp()
        repository = FakeTransactionsRepository()
        calendar = FakeCalendar()
        sut = TransactionsSummaryInteractor(repository: repository,
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
        
        let presenter = FakePresenter()
        sut.presenter = presenter
        sut.computeSummary()
        repository.transactionChangedCallback?([transaction1, transaction2])
        
        XCTAssertEqual(presenter.computedState.incomesAmountText, "100")
        XCTAssertEqual(presenter.computedState.expensesAmountText, "-200")
        XCTAssertEqual(presenter.computedState.totalAmountText, "-100")
        XCTAssertEqual(presenter.computedState.dateRangeButtonText, "All")
    }
    
    func test_afterSetDateRange_shouldUpdateValues() {
        let date = FakeCalendarDate()
        date.dayOfEra = 3
        calendar.nowCalendarDateToReturn = date
        
        let transaction1 = FakeTransactionBuilder().set(value: Decimal(100)).set(dayOfEra: 3).build()
        let transaction2 = FakeTransactionBuilder().set(value: Decimal(-200)).set(dayOfEra: 4).build()
        
        let presenter = FakePresenter()
        sut.presenter = presenter
        
        sut.computeSummary()
        repository.transactionChangedCallback?([transaction1, transaction2])
        sut.dateRange = .today
        
        XCTAssertEqual(presenter.computedState.incomesAmountText, "100")
        XCTAssertEqual(presenter.computedState.expensesAmountText, "0")
        XCTAssertEqual(presenter.computedState.totalAmountText, "100")
        XCTAssertEqual(presenter.computedState.dateRangeButtonText, "Today")
    }
}

// MARK: Fakes

private class FakePresenter: FakeTransactionsSummaryPresenterProtocol {
    var computedState: TransactionsSummaryUIState!
    
    func stateComputed(_ state: TransactionsSummaryUIState) {
        computedState = state
    }
}

private protocol FakeTransactionsSummaryPresenterProtocol: TransactionsSummaryPresenterProtocol {}
extension FakeTransactionsSummaryPresenterProtocol {
    var dateRange: DateRange {
        set { fatalError() }
        get { fatalError() }
    }
    
    var display: TransactionsSummaryUI? {
        set {}
        get { return nil }
    }
}
