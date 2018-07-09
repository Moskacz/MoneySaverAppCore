//
//  FakeBudgetRepository.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 19.05.2018.
//

import Foundation
import CoreData
@testable import MoneySaverAppCore

class FakeBudgetRepository: BudgetRepository {
    
    var saveBudgetPassedValue: Decimal?
    var passedBudgetChangedBlock: ((BudgetProtocol) -> Void)?
    
    func saveBudget(withValue value: Decimal) {
        saveBudgetPassedValue = value
    }
    
    func observeBudgetChanged(completion: @escaping ((BudgetProtocol) -> Void)) -> ObservationToken {
        passedBudgetChangedBlock = completion
        return ObservationToken(notificationCenter: .default,
                                token: NSObject(),
                                notificationName: .budgetDidChange)
    }
}
