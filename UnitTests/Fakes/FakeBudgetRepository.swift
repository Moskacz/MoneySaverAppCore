//
//  FakeBudgetRepository.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 19.05.2018.
//

import Foundation
import CoreData

public class FakeBudgetRepository: BudgetRepository {
    
    var saveBudgetPassedValue: Decimal?
    
    public init() {}
    
    public func makeEntitiesFRC() -> NSFetchedResultsController<BudgetManagedObject> {
        fatalError()
    }
    
    public func saveBudget(withValue value: Decimal) {
        saveBudgetPassedValue = value
    }
}
