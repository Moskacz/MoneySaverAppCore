//
//  BudgetManagedObject+CoreDataClass.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 23.04.2018.
//
//

import Foundation
import CoreData

public class BudgetManagedObject: NSManagedObject {

    public enum AttributesNames: String {
        case value
    }
    
    public enum SortDescriptors {
        case value
        
        public var descriptor: NSSortDescriptor {
            return NSSortDescriptor(key: AttributesNames.value.rawValue, ascending: true)
        }
    }
}
