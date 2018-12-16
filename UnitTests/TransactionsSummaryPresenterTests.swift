//
//  TransactionsSummaryPresenterTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 17/11/2018.
//

import XCTest
@testable import MoneySaverAppCore

class TransactionsSummaryPresenterTests: XCTestCase {

    private var interactor: FakeInteractor!
    private var router: FakeRouter!
    private var sut: TransactionsSummaryPresenter!
    
    override func setUp() {
        super.setUp()
        interactor = FakeInteractor()
        router = FakeRouter()
        sut = TransactionsSummaryPresenter(interactor: interactor,
                                           dateRangesInteractor: FakeDateRangeInteractor(),
                                           router: router)
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        router = nil
        super.tearDown()
    }
    
    func test_dateRange_shouldCallInteractor() {
        XCTAssertEqual(sut.dateRange, .today)
        sut.dateRange = .thisWeek
        XCTAssertEqual(interactor.dateRange, .thisWeek)
    }

    func test_stateComputed_shouldCallUI() {
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
        sut.dateRangeButtonTapped()
        XCTAssertNotNil(router.dateRangePresenter)
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

    var dateRangePresenter: DateRangePickerPresenterProtocol?
    func presentDateRangePicker(presenter: DateRangePickerPresenterProtocol) {
        dateRangePresenter = presenter
    }
}

private class FakeDateRangeInteractor: DateRangePickerInteractorProtocol {
    var items: [DateRangeItem] { return [] }
}
