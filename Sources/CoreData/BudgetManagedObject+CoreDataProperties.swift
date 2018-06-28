//
//  BudgetManagedObject+CoreDataProperties.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 23.04.2018.
//
//

import Foundation
import CoreData

extension BudgetManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BudgetManagedObject> {
        return NSFetchRequest<BudgetManagedObject>(entityName: "BudgetManagedObject")
    }

    @NSManaged public var value: NSDecimalNumber?

}

extension BudgetManagedObject: BudgetProtocol {
    public var budgetValue: Double {
        return value?.doubleValue ?? 0
    }
}
