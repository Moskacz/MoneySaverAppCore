//
//  TransactionManagedObject+CoreDataProperties.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 21/09/2018.
//
//

import Foundation
import CoreData


extension TransactionManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionManagedObject> {
        return NSFetchRequest<TransactionManagedObject>(entityName: "TransactionManagedObject")
    }

    @NSManaged public var cd_title: String?
    @NSManaged public var cd_value: NSDecimalNumber?
    @NSManaged public var cd_identifier: UUID?
    @NSManaged public var category: TransactionCategoryManagedObject?
    @NSManaged public var date: CalendarDateManagedObject?

}
