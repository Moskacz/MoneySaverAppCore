//
//  BudgetManagedObject+CoreDataProperties.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 21/09/2018.
//
//

import Foundation
import CoreData


extension BudgetManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BudgetManagedObject> {
        return NSFetchRequest<BudgetManagedObject>(entityName: "BudgetManagedObject")
    }

    @NSManaged public var cd_value: NSDecimalNumber?
    @NSManaged public var cd_identifier: UUID?

}
