//
//  BudgetRouting.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 19/11/2018.
//

import Foundation

public protocol BudgetRouting {
    func presentBudgetAmountEditor(presenter: BudgetPresenter)
}
