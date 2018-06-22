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
