//
//  NotificationCenter+Extensions.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 21.06.2018.
//

import Foundation

internal struct TransactionNotification {
    
    internal let transactions: [TransactionProtocol]
    
    internal init(transactions: [TransactionProtocol]) {
        self.transactions = transactions
    }
    
    internal init?(notification: Notification) {
        guard notification.name == .transactionsDidChange else { return nil }
        guard let data = notification.userInfo?["transactions"] as? [TransactionProtocol] else { return nil }
        self.init(transactions: data)
    }
    
    internal var notification: Notification {
        return Notification(name: Notification.Name.transactionsDidChange,
                            object: nil,
                            userInfo: ["transactions": transactions])
    }
}

internal protocol TransactionNotificationCenter {
    func postTransactionsDidChange(notification: TransactionNotification)
    func observeTransactionsDidChange(callback: @escaping (TransactionNotification) -> Void) -> ObservationToken
}

extension NotificationCenter: TransactionNotificationCenter {
    
    internal func postTransactionsDidChange(notification: TransactionNotification) {
        post(notification.notification)
    }
    
    internal func observeTransactionsDidChange(callback: @escaping (TransactionNotification) -> Void) -> ObservationToken {
        let notificationName = Notification.Name.transactionsDidChange
        let token = addObserver(forName: notificationName, object: nil, queue: nil) { (note) in
            guard let transactionNotification = TransactionNotification(notification: note) else { return }
            callback(transactionNotification)
        }
        return ObservationToken(notificationCenter: self, token: token, notificationName: notificationName)
    }
}

extension Notification.Name {
    static var transactionsDidChange: Notification.Name {
        return Notification.Name("com.money.saver.app.transactionsDidChange")
    }
}
