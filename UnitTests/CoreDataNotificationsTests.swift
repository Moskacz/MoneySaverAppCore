//
//  CoreDataNotificationsTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 21.06.2018.
//

import XCTest
@testable import MoneySaverAppCore

class CoreDataNotificationsTests: XCTestCase {
    
    func test_whenObjectInContextIsChanged_thenNotificationShouldBePosted() {
        let stack = InMemoryCoreDataStack()
        let exp = expectation(description: "notification_received")
        
        let transaction = TransactionManagedObject(context: stack.getViewContext())
        transaction.value = NSDecimalNumber(value: 30)
        
        NotificationCenter.default.observeObjectsDidChange(context: stack.getViewContext()) { (note) in
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
}
