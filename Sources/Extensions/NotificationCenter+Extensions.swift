//
//  NotificationCenter+Extensions.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 21.06.2018.
//

import Foundation
import CoreData

public protocol CoreDataNotifications {
    func observeObjectsDidChange(context: NSManagedObjectContext,
                                 callback: @escaping (Notification) -> Void) -> ObservationToken
}

extension NotificationCenter: CoreDataNotifications {
    
    public func observeObjectsDidChange(context: NSManagedObjectContext,
                                        callback: @escaping (Notification) -> Void) -> ObservationToken {
        let notificationName = Notification.Name.NSManagedObjectContextObjectsDidChange
        let token = addObserver(forName: notificationName, object: context, queue: OperationQueue.main, using: { notification in
            callback(notification)
        })
        return ObservationToken(notificationCenter: self, token: token, notificationName: notificationName)
    }
}

public class TransactionNotification {
    
    public let transactions: [TransactionProtocol]
    
    init(transactions: [TransactionProtocol]) {
        self.transactions = transactions
    }
    
    convenience init?(notification: Notification) {
        guard let data = notification.userInfo?["transactions"] as? [TransactionProtocol] else {
            return nil
        }
        self.init(transactions: data)
    }
    
    var notification: Notification {
        return Notification(name: Notification.Name.transactionsDidChange,
                            object: nil,
                            userInfo: ["transactions": transactions])
    }
}

public protocol TransactionNotifications {
    func postTransactionsDidChange(notification: TransactionNotification)
    func observeTransactionsDidChange(callback: @escaping (TransactionNotification) -> Void) -> ObservationToken
}

extension NotificationCenter: TransactionNotifications {
    
    public func postTransactionsDidChange(notification: TransactionNotification) {
        post(notification.notification)
    }
    
    public func observeTransactionsDidChange(callback: @escaping (TransactionNotification) -> Void) -> ObservationToken {
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
