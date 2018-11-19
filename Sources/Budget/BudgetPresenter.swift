//
//  BudgetPresenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 19/11/2018.
//

import Foundation

public protocol BudgetPresenter {
    func requestBudgetAmountEdit()
    func saveBudget(amount: Decimal)
    func loadData()
}
