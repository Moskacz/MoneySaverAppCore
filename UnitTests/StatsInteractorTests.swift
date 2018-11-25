//
//  StatsInteractorTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 25/11/2018.
//

import XCTest
@testable import MoneySaverAppCore

class StatsInteractorTests: XCTestCase {

    private var repository: FakeTransactionsRepository!
    private var userPreferences: FakeUserPreferences!
    private var presenter: FakePresenter!
    private var sut: StatsInteractor!
    
    override func setUp() {
        repository = FakeTransactionsRepository()
        userPreferences = FakeUserPreferences()
        presenter = FakePresenter()
        sut = StatsInteractor(repository: repository, userPreferences: userPreferences)
        sut.presenter = presenter
    }

    override func tearDown() {
        sut = nil
        repository = nil
        userPreferences = nil
        presenter = nil
    }

    func test_preferredGrouping_shouldCallUserPreferences() {
        userPreferences.statsGrouping = .weekOfEra
        XCTAssertEqual(sut.preferredGrouping, .weekOfEra)
        sut.preferredGrouping = .dayOfEra
        XCTAssertEqual(userPreferences.statsGrouping, .dayOfEra)
    }

    func test_loadTransactions_whenNoStoredTransactions_thenShouldCallRepository() {
        sut.loadTransactions()
        repository.transactionChangedCallback?([])
        XCTAssertNotNil(presenter.transactions)
    }
    
    func test_loadTransactions_whenTransactionsStored_thenShouldUpdatePresenterImmediately() {
        sut.loadTransactions()
        repository.transactionChangedCallback?([])
        
        presenter.transactions = nil // reset
        repository.transactionChangedCallback = nil
        
        sut.loadTransactions()
        XCTAssertNotNil(presenter.transactions)
    }
}

private class FakePresenter: StatsPresenterProtocol {
    var selectedGroupingIndex: Int = 0
    
    func start() {}
    
    var transactions: [TransactionProtocol]?
    func dataLoaded(transactions: [TransactionProtocol]) {
        self.transactions = transactions
    }
}
