//
//  SetupBudgetInteractor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 05/12/2018.
//

import Foundation

public protocol SetupBudgetInteractorProtocol {
    func save(budget: Decimal)
}

internal class SetupBudgetInteractor {
    
    private let repository: BudgetRepository
    
    internal init(repository: BudgetRepository) {
        self.repository = repository
    }
}

extension SetupBudgetInteractor: SetupBudgetInteractorProtocol {
    
    func save(budget: Decimal) {
        repository.saveBudget(withValue: budget)
    }
}
