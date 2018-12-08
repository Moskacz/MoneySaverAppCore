//
//  TransactionsSummaryPresenterTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 17/11/2018.
//

import XCTest
@testable import MoneySaverAppCore

class TransactionsSummaryPresenterTests: XCTestCase {

    func test_dateRange_shouldCallInteractor() {
        let interactor = FakeInteractor()
        let sut = TransactionsSummaryPresenter(interactor: interactor, router: FakeRouter())
        XCTAssertEqual(sut.dateRange, .today)
        sut.dateRange = .thisWeek
        XCTAssertEqual(interactor.dateRange, .thisWeek)
    }

    func test_stateComputed_shouldCallUI() {
        let interactor = FakeInteractor()
        let sut = TransactionsSummaryPresenter(interactor: interactor, router: FakeRouter())
        let ui = FakeUI()
        sut.display = ui
        sut.stateComputed(TransactionsSummaryUIState(totalAmountText: "1",
                                                     expensesAmountText: "2",
                                                     incomesAmountText: "3",
                                                     dateRangeButtonText: "test"))
        
        XCTAssertEqual(ui.incomesText, "3")
        XCTAssertEqual(ui.expenseText, "2")
        XCTAssertEqual(ui.totalAmountString, "1")
        XCTAssertEqual(ui.dateRangeTitle, "test")
    }
    
    func test_whenDataRangeButtonIsTapped_thenPickerShouldBePresented() {
        let router = FakeRouter()
        let sut = TransactionsSummaryPresenter(interactor: FakeInteractor(), router: router)
        sut.dateRangeButtonTapped()
        XCTAssertTrue(router.presentDatePickerCalled)
    }
}

private class FakeInteractor: TransactionsSummaryInteractorProtocol {
    var presenter: TransactionsSummaryPresenterProtocol?
    var dateRange: DateRange = .today
    func computeSummary() {}
}

private class FakeUI: TransactionsSummaryUI {
    var presenter: TransactionsSummaryPresenterProtocol?
    
    var incomesText: String?
    var expenseText: String?
    var totalAmountString: String?
    var dateRangeTitle: String?
    
    func set(incomesText: String?) {
        self.incomesText = incomesText
    }
    
    func set(expenseText: String?) {
        self.expenseText = expenseText
    }
    
    func set(totalAmountString: String?) {
        self.totalAmountString = totalAmountString
    }
    
    func set(dateRangeTitle: String?) {
        self.dateRangeTitle = dateRangeTitle
    }
}

private class FakeRouter: TransactionsSummaryRoutingProtocol {
    var presentDatePickerCalled = false
    func presentDateRangePicker() {
        presentDatePickerCalled = true
    }
}
