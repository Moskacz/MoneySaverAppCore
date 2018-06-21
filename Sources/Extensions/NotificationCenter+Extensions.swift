//
//  NotificationCenter+Extensions.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 21.06.2018.
//

import Foundation
import CoreData

protocol CoreDataNotifications {
    func observeObjectsDidChange(context: NSManagedObjectContext,
                                 callback: @escaping (Notification) -> Void) -> NSObjectProtocol
}

extension NotificationCenter: CoreDataNotifications {
    
    func observeObjectsDidChange(context: NSManagedObjectContext,
                                 callback: @escaping (Notification) -> Void) -> NSObjectProtocol {
        let notificationName = Notification.Name.NSManagedObjectContextObjectsDidChange
        return addObserver(forName: notificationName, object: context, queue: OperationQueue.main, using: { notification in
            callback(notification)
        })
    }
}
