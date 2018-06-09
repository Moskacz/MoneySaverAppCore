//
//  TransactionManagedObject+CoreDataClass.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 23.04.2018.
//
//

import Foundation
import CoreData

public class TransactionManagedObject: NSManagedObject, TransactionProtocol {
    
    public enum KeyPath: String {
        case value = "value"
        case title = "title"
        case date = "date"
        case dayOfEra = "date.dayOfEra"
        case weekOfEra = "date.weekOfEra"
        case monthOfEra = "date.monthOfEra"
        case year = "date.year"
        case timeInterval = "date.timeInterval"
        case category = "category"
    }
    
    static func groupByKeypathFor(grouping: TransactionsGrouping) -> KeyPath {
        switch grouping {
        case .dayOfEra: return KeyPath.dayOfEra
        case .weekOfEra: return KeyPath.weekOfEra
        case .monthOfEra: return KeyPath.monthOfEra
        case .category: return KeyPath.category
        }
    }
    
    public var transactionCategory: TransactionCategoryProtocol? {
        return category
    }
    
    public var transactionDate: CalendarDateProtocol? {
        return date
    }
}
