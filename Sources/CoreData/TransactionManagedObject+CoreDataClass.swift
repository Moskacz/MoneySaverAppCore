//
//  TransactionManagedObject+CoreDataClass.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 23.04.2018.
//
//

import Foundation
import CoreData

public class TransactionManagedObject: NSManagedObject {
    
    public enum KeyPath {
        case dayOfEra
        case weekOfEra
        case monthOfEra
        case timeInterval
        
        var string: String {
            switch self {
            case .dayOfEra: return #keyPath(date.cd_dayOfEra)
            case .weekOfEra: return #keyPath(date.cd_weekOfEra)
            case .monthOfEra: return #keyPath(date.cd_monthOfEra)
            case .timeInterval: return #keyPath(date.cd_timeInterval)
            }
        }
    }
    
    static func groupByKeypathFor(grouping: TransactionsGrouping) -> KeyPath {
        switch grouping {
        case .dayOfEra: return KeyPath.dayOfEra
        case .weekOfEra: return KeyPath.weekOfEra
        case .monthOfEra: return KeyPath.monthOfEra
        }
    }
    
    public var transactionCategory: TransactionCategoryProtocol? {
        return category
    }
    
    public var transactionDate: CalendarDateProtocol? {
        return date
    }
}

extension TransactionManagedObject: TransactionProtocol {
    
    public var title: String { return cd_title! }
    public var value: Decimal { return cd_value!.decimalValue }
    public var identifier: UUID { return cd_identifier! }
}
