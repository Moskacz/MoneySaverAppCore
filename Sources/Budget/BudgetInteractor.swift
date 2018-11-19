//
//  BudgetInteractor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 19/11/2018.
//

import Foundation

public protocol BudgetInteractor {
    func loadData()
    func saveBudget(amount: Decimal)
}
