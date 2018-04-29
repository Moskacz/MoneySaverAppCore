//
//  File.swift
//  MoneySaverApp-iOS
//
//  Created by Michał Moskała on 29.03.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

public protocol CoreDataStack: class {
    func getViewContext() -> NSManagedObjectContext
    func save() throws
}

public class CoreDataStackImplementation: CoreDataStack {
    
    private let persistentContainer: NSPersistentContainer
    
    public init() {
        self.persistentContainer = NSPersistentContainer(name: "DataModel")
        self.persistentContainer.loadPersistentStores(completionHandler: { (_, _) in })
    }
    
    public func getViewContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    public func save() throws {
        let context = persistentContainer.viewContext
        guard context.hasChanges else { return }
        try context.save()
    }
}
