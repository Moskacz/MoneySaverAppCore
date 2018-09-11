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
    private let formatter = DateFormatters.formatter(forType: .dateWithTime)
    
    override func setUp() {
        super.setUp()
        sut = TransactionDataViewCoordinatorImpl(formatter: formatter)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_afterSettingDisplay_itShouldBeUpdatedWithCurrentValue() {
        let display = FakeDisplay()
        sut.display = display
        XCTAssertNotNil(display.date)
    }
    
    func test_afterSettingDisplayForFirstTime_itShouldBeUpdatedWithCurrentDate() {
        let display = FakeDisplay()
        sut.display = display
        XCTAssertEqual(display.date, formatter.string(from: Date()))
    }
    
}

private class FakeDisplay: TransactionDataDisplaying {
    
    var amount: String?
    var title: String?
    var date: String?
    var error: TransactionDataViewError?
    
    func set(amount: String?) { self.amount = amount }
    func set(title: String?) { self.title = title }
    func set(date: String?) { self.date = date }
    func display(error: TransactionDataViewError) { self.error = error }
}
