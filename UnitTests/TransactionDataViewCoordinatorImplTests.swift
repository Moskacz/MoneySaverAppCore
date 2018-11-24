//
//  TransactionDataViewCoordinatorImplTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 11.09.2018.
//

import XCTest
@testable import MoneySaverAppCore

class TransactionDataViewCoordinatorImplTests: XCTestCase {
    
    private var sut: TransactionDataViewCoordinatorImpl!
    private var displayFake: FakeDisplay!
    private var flowFake: FakeFlow!
    private let formatter = DateFormatters.formatter(forType: .dateWithTime)
    private var calendarFake: FakeCalendar!
    
    override func setUp() {
        super.setUp()
        flowFake = FakeFlow()
        calendarFake = FakeCalendar()
        sut = TransactionDataViewCoordinatorImpl(formatter: formatter, flow: flowFake, calendar: calendarFake)
        displayFake = FakeDisplay()
        sut.display = displayFake
    }
    
    override func tearDown() {
        sut = nil
        displayFake = nil
        calendarFake = nil
        super.tearDown()
    }
    
    func test_afterSettingDisplay_itShouldBeUpdatedWithCurrentValue() {
        XCTAssertNotNil(displayFake.date)
    }
    
    func test_afterSettingDisplayForFirstTime_itShouldBeUpdatedWithCurrentDate() {
        XCTAssertEqual(displayFake.date, formatter.string(from: Date()))
    }
    
    func test_whenSetIsCalledWithNilTitle_thenErrorShouldBeThrown() {
        sut.set(title: nil, value: "13", date: Date())
        XCTAssertEqual(displayFake.error, TransactionDataViewError.missingTitle)
    }
    
    func test_whenSetIsCalledWithNilAmount_thenErrorShouldBeThrown() {
        sut.set(title: "title", value: nil, date: Date())
        XCTAssertEqual(displayFake.error, TransactionDataViewError.missingValue)
    }
    
    func test_whenSetIsCalledWithZeroAmount_thenErrorShouldBeThrown() {
        sut.set(title: "title", value: "0", date: Date())
        XCTAssertEqual(displayFake.error, TransactionDataViewError.invalidValue)
    }
    
    func test_whenSetIsCalledWithInvalidAmount_thenErrorShouldBeThrown() {
        sut.set(title: "title", value: "non_number", date: Date())
        XCTAssertEqual(displayFake.error, TransactionDataViewError.invalidValue)
    }
    
    func test_multipleErrors() {
        sut.set(title: "", value: "not_a_number", date: nil)
        XCTAssertTrue(displayFake.error!.contains(.missingTitle))
        XCTAssertTrue(displayFake.error!.contains(.invalidValue))
        XCTAssertTrue(displayFake.error!.contains(.missingDate))
    }
    
    func test_whenValidDataIsSet_thenTransactionDataShouldBeSetOnFlow() {
        sut.set(title: "some_title", value: "1234", date: Date())
        XCTAssertNotNil(flowFake.transactionData)
        XCTAssertEqual(flowFake.transactionData!.title, "some_title")
        XCTAssertEqual(flowFake.transactionData!.value, Decimal(1234))
        XCTAssertNotNil(flowFake.transactionData?.date)
    }
}

private class FakeDisplay: TransactionDataUI {
    
    var amount: String?
    var title: String?
    var date: String?
    var error: TransactionDataViewError?
    
    func set(amount: String?) { self.amount = amount }
    func set(title: String?) { self.title = title }
    func set(date: String?) { self.date = date }
    func display(error: TransactionDataViewError) { self.error = error }
}

private class FakeFlow: TransactionDataFlow {
    
    var transactionData: TransactionData?
}
