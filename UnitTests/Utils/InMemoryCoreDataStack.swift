//
//  InMemoryCoreDataStack.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 08.05.2018.
//

import Foundation
import CoreData

public class InMemoryCoreDataStack: CoreDataStack {
    
    private let container: NSPersistentContainer
    
    public init() {
        let container = NSPersistentContainer(name: NSManagedObjectModel.defaultName,
                                                         managedObjectModel: NSManagedObjectModel.makeDefault())
        let storeDescription = NSPersistentStoreDescription()
        storeDescription.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores { (_, _) in }
        self.container = container
    }
    
    public func getViewContext() -> NSManagedObjectContext {
        return container.viewContext
    }
    
    public func save() throws {}
}
