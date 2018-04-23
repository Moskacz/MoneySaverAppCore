//
//  File.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 29.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataStack: class {
    func getViewContext() -> NSManagedObjectContext
}

class CoreDataStackImplementation: CoreDataStack {
    
    private let persistentContainer: NSPersistentContainer
    private let notificationCenter: NotificationCenter
    private var didEnterBackgroundToken: NSObjectProtocol?
    private var willTerminateToken: NSObjectProtocol?
    
    init(notificationCenter: NotificationCenter) {
        self.notificationCenter = notificationCenter
        self.persistentContainer = NSPersistentContainer(name: "DataModel")
        self.persistentContainer.loadPersistentStores(completionHandler: { (_, _) in })
        registerForNotifications()
    }
    
    private func registerForNotifications() {
//        didEnterBackgroundToken = notificationCenter.addObserver(forName: .UIApplicationDidEnterBackground,
//                                                                 object: nil,
//                                                                 queue: .main, using: { [weak self] _ in
//            self?.save()
//        })
//        
//        willTerminateToken = notificationCenter.addObserver(forName: .UIApplicationWillTerminate,
//                                                            object: nil,
//                                                            queue: .main,
//                                                            using: { [weak self] _ in
//            self?.save()
//        })
    }
    
    func getViewContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private func save() {
        do {
            try getViewContext().save()
        } catch {

        }
    }
    
    deinit {
        if let token = didEnterBackgroundToken {
            notificationCenter.removeObserver(token)
        }
        if let token = willTerminateToken {
            notificationCenter.removeObserver(token)
        }
    }
}
