//
//  NSManagedObject+Extensions.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 24.04.2018.
//

import Foundation
import CoreData

public extension NSManagedObject {
    
    public class var entityName: String {
        return String(describing: self)
    }
    
    public class func createEntity(inContext context: NSManagedObjectContext) -> Self {
        return createEntityHelper(inContext: context)
    }
    
    private class func createEntityHelper<T>(inContext context: NSManagedObjectContext) -> T {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! T
    }
}
