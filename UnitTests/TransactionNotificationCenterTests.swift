//
//  TransactionNotificationCenterTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 06.07.2018.
//

import XCTest
@testable import MoneySaverAppCore

class TransactionNotificationCenterTests: XCTestCase {

    private var observationToken: ObservationToken?
    
    override func tearDown() {
        observationToken = nil
        super.tearDown()
    }
    
    func test_transactionDidChange_name() {
        XCTAssertEqual(Notification.Name.transactionsDidChange.rawValue, "com.money.saver.app.transactionsDidChange")
    }
    
    func test_transactionNotification_initWithNotification() {
        let transactions = [FakeTransactionBuilder().set(value: 13).build(),
                            FakeTransactionBuilder().set(value: 31).build()]
        let userInfo: [String: Any] = ["transactions": transactions]
        let notification = Notification(name: .transactionsDidChange,
                                        object: nil,
                                        userInfo: userInfo)
        let sut = TransactionNotification(notification: notification)
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut?.transactions[0].value, NSDecimalNumber(value: 13))
        XCTAssertEqual(sut?.transactions[1].value, NSDecimalNumber(value: 31))
    }

    func test_transactionNotification_notification() {
        let transactions = [FakeTransactionBuilder().set(value: 13).build(),
                            FakeTransactionBuilder().set(value: 31).build()]
        let sut = TransactionNotification(transactions: transactions)
        let notification = sut.notification
        XCTAssertEqual(notification.name, Notification.Name.transactionsDidChange)
        let notificationTransactions = notification.userInfo?["transactions"] as? [TransactionProtocol]
        XCTAssertEqual(notificationTransactions?[0].value, NSDecimalNumber(value: 13))
        XCTAssertEqual(notificationTransactions?[1].value, NSDecimalNumber(value: 31))
    }
    
    func test_whenNotificationIsPosted_thenObserverShouldReceiveIt() {
        let exp = expectation(description: "notification_received")
        let transaction = FakeTransactionBuilder().set(value: 111).build()
        observationToken = NotificationCenter.default.observeTransactionsDidChange { transactionNotification in
            if transactionNotification.transactions.first?.value == NSDecimalNumber(value: 111) {
                exp.fulfill()
            }
        }
        
        let notification = TransactionNotification(transactions: [transaction])
        NotificationCenter.default.postTransactionsDidChange(notification: notification)
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}
