//
//  TransactionDataInteractorTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 24/11/2018.
//

import XCTest
@testable import MoneySaverAppCore

class TransactionDataInteractorTests: XCTestCase {

    private var calendar: FakeCalendar!
    private var sut: TransactionDataInteractor!
    
    override func setUp() {
        calendar = FakeCalendar()
        sut = TransactionDataInteractor(calendar: calendar)
    }

    override func tearDown() {
        sut = nil
        calendar = nil
    }

    func test_createTransactionData_shouldUsePassedValues() {
        let data = sut.transactionData(with: "x", amount: Decimal(123), date: Date())
        XCTAssertEqual(data.title, "x")
        XCTAssertEqual(data.value, Decimal(123))
    }

}
