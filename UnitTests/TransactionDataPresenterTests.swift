//
//  TransactionDataPresenterTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 24/11/2018.
//

import XCTest
@testable import MoneySaverAppCore

class TransactionDataPresenterTests: XCTestCase {

    private var view: FakeUI!
    private var routing: FakeRouting!
    private var sut: TransactionDataPresenter!
    
    override func setUp() {
        view = FakeUI()
        routing = FakeRouting()
        sut = TransactionDataPresenter(interactor: FakeInteractor(), routing: routing)
        sut.view = view
    }

    override func tearDown() {
        sut = nil
        view = nil
        routing = nil
    }
    
    func test_nextTapped_whenTitleIsMissing_thenViewShouldShowError() {
        sut.transactionTitle = nil
        sut.transactionAmount = "13"
        sut.transactionDate = Date()
        sut.nextTapped()
        XCTAssertEqual(view.error, TransactionDataViewError.missingTitle)
    }
    
    func test_nextTapped_whenAmountIsMissing_thenViewShouldShowError() {
        sut.transactionTitle = "title"
        sut.transactionAmount = nil
        sut.transactionDate = Date()
        sut.nextTapped()
        XCTAssertEqual(view.error, TransactionDataViewError.missingValue)
    }
    
    func test_nextTapped_whenAmountIsEqualTo0_thenViewShouldShowError() {
        sut.transactionTitle = "title"
        sut.transactionAmount = "0"
        sut.transactionDate = Date()
        sut.nextTapped()
        XCTAssertEqual(view.error, TransactionDataViewError.invalidValue)
    }
    
    func test_nextTapped_whenAmountIsNAN_thenViewShouldShowError() {
        sut.transactionTitle = "title"
        sut.transactionAmount = "not_a_number"
        sut.transactionDate = Date()
        sut.nextTapped()
        XCTAssertEqual(view.error, TransactionDataViewError.invalidValue)
    }
    
    func test_nextTapped_whenTitleAndDateAreMissing_andAmountIsNAN_thenViewShoulShowMultipleErrors() {
        sut.transactionTitle = ""
        sut.transactionAmount = "not_a_number"
        sut.transactionDate = nil
        sut.nextTapped()
        XCTAssertTrue(view.error!.contains(.missingTitle))
        XCTAssertTrue(view.error!.contains(.invalidValue))
        XCTAssertTrue(view.error!.contains(.missingDate))
    }
    
    func test_whenValidDataIsSet_thenTransactionDataShouldBeSetOnFlow() {
        sut.transactionTitle = "a"
        sut.transactionAmount = "1"
        sut.transactionDate = Date()
        sut.nextTapped()
        XCTAssertNotNil(routing.transactionData)
    }
    
    func test_whenValidDataIsSet_thenCategoriesListShouldBeRequested() {
        sut.transactionTitle = "a"
        sut.transactionAmount = "1"
        sut.transactionDate = Date()
        sut.nextTapped()
        XCTAssertNotNil(routing.transactionData)
    }
}

private class FakeRouting: TransactionDataRouting {
    var transactionData: TransactionData?
    func showTransactionCategoriesPicker(transactionData: TransactionData) {
        self.transactionData = transactionData
    }
    
    func closeView() {}
}

private class FakeInteractor: TransactionDataInteractorProtocol {
    func transactionData(with title: String, amount: Decimal, date: Date) -> TransactionData {
        return TransactionData(title: title, value: amount, date: FakeCalendarDate())
    }
}

private class FakeUI: TransactionDataUI {
    
    var error: TransactionDataViewError?
    
    func display(error: TransactionDataViewError) { self.error = error }
    func set(title: String?) { fatalError() }
    func set(amount: String?) { fatalError() }
    func set(date: String?) { fatalError() }
    func pick(date: Date) { fatalError() }
}
