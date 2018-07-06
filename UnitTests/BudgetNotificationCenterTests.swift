//
//  BudgetNotificationCenterTests.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 05.07.2018.
//

import XCTest
@testable import MoneySaverAppCore

class BudgetNotificationCenterTests: XCTestCase {

    private var token: ObservationToken?
    
    override func tearDown() {
        token = nil
        super.tearDown()
    }
    
    func test_notificationName() {
        XCTAssertEqual(Notification.Name.budgetDidChange.rawValue, "com.money.saver.app.budgetDidChange")
    }
    
    func test_budgetNotification_notification() {
        let budget = FakeBudget(budgetValue: 100)
        let sut = BudgetNotification(budget: budget)
        let notification = sut.notification
        
        XCTAssertEqual(notification.name, Notification.Name.budgetDidChange)
        let userInfoBudget = (notification.userInfo?["budget"] as? BudgetProtocol)
        XCTAssertEqual(userInfoBudget?.budgetValue, budget.budgetValue)
    }
    
    func test_budgetNotification_initWithNotification() {
        let postedBudget = FakeBudget(budgetValue: 123)
        let userInfo = ["budget": postedBudget]
        let notification = Notification(name: .budgetDidChange,
                                        object: nil,
                                        userInfo: userInfo)
        let sut = BudgetNotification(notification: notification)
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut?.budget?.budgetValue, postedBudget.budgetValue)
    }

    func test_whenNotificationIsPosted_thenObserverShouldReceiveIt() {
        let exp = expectation(description: "notification_received")
        let budget = FakeBudget(budgetValue: 123)
        
        token = NotificationCenter.default.observeBudgetDidChange { budgetNotification in
            if budgetNotification.budget?.budgetValue == budget.budgetValue {
                exp.fulfill()
            }
        }
        
        NotificationCenter.default.postBudgetDidChange(notification: BudgetNotification(budget: budget))
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}
