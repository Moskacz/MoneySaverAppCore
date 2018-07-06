//
//  NotificationCenter+BudgetNotificationCenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 04.07.2018.
//

import Foundation

internal protocol BudgetNotificationCenter {
    func postBudgetDidChange(notification: BudgetNotification)
    func observeBudgetDidChange(callback: @escaping (BudgetNotification) -> Void) -> ObservationToken
}

internal struct BudgetNotification {
    internal let budget: BudgetProtocol?
    
    private static let budgetStorageKey = "budget"
    
    internal init(budget: BudgetProtocol?) {
        self.budget = budget
    }
    
    internal init?(notification: Notification) {
        guard notification.name == .budgetDidChange else { return nil }
        guard let budget = notification.userInfo?[BudgetNotification.budgetStorageKey] as? BudgetProtocol else { return nil }
        self.init(budget: budget)
    }
    
    internal var notification: Notification {
        var userInfo = [String: Any]()
        if let existingBudget = budget {
            userInfo[BudgetNotification.budgetStorageKey] = existingBudget
        }
        
        return Notification(name: .budgetDidChange,
                            object: nil,
                            userInfo: userInfo)
    }
}

extension Notification.Name {
    static var budgetDidChange: Notification.Name {
        return Notification.Name("com.money.saver.app.budgetDidChange")
    }
}

extension NotificationCenter: BudgetNotificationCenter {
    internal func postBudgetDidChange(notification: BudgetNotification) {
        post(notification.notification)
    }
    
    internal func observeBudgetDidChange(callback: @escaping (BudgetNotification) -> Void) -> ObservationToken {
        let notificationName = Notification.Name.budgetDidChange
        let token = addObserver(forName: notificationName, object: nil, queue: nil, using: { notification in
            guard let budgetNotification = BudgetNotification(notification: notification) else { return }
            callback(budgetNotification)
        })
        
        return ObservationToken(notificationCenter: self, token: token, notificationName: notificationName)
    }
}
