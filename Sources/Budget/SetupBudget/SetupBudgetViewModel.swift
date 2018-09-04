//
//  SetupBudgetViewModel.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 24.07.2018.
//

import Foundation

public protocol SetupBudgetViewModel {
    func saveBudget(amountText: String?) throws
}

public enum SetupBudgetError: Error {
    case incorrectAmount
}
