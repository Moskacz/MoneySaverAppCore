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
        let container = NSPersistentContainer(name: "DataModel")
        let storeDescription = NSPersistentStoreDescription()
        storeDescription.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores { (storeDescription, error) in
            print(storeDescription)
            if let loadingError = error {
                print(loadingError.localizedDescription)
            }
        }
        
        self.container = container
    }
    
    public func getViewContext() -> NSManagedObjectContext {
        return container.viewContext
    }
    
    public func save() throws {}
}
