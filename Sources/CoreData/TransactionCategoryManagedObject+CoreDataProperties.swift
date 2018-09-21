//
//  TransactionCategoryManagedObject+CoreDataProperties.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 21/09/2018.
//
//

import Foundation
import CoreData
import MMFoundation

extension TransactionCategoryManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionCategoryManagedObject> {
        return NSFetchRequest<TransactionCategoryManagedObject>(entityName: "TransactionCategoryManagedObject")
    }

    @NSManaged public var cd_icon: NSData?
    @NSManaged public var cd_name: String?
    @NSManaged public var cd_identifier: UUID?
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for transactions
extension TransactionCategoryManagedObject {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: TransactionManagedObject)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: TransactionManagedObject)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}
