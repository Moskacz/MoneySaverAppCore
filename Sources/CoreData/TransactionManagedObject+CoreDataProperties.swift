//
//  TransactionManagedObject+CoreDataProperties.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 23.04.2018.
//
//

import Foundation
import CoreData


extension TransactionManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionManagedObject> {
        return NSFetchRequest<TransactionManagedObject>(entityName: "TransactionManagedObject")
    }

    @NSManaged public var title: String?
    @NSManaged public var value: NSDecimalNumber?
    @NSManaged public var category: TransactionCategoryManagedObject?
    @NSManaged public var date: CalendarDateManagedObject?

}
