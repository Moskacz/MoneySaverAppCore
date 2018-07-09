//
//  FakeBudgetViewModelDelegate.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 09.07.2018.
//

import Foundation
import Charts
import MoneySaverAppCore

class FakeBudgetViewModelDelegate: BudgetViewModelDelegate {
    
    var budgetData: PieChartData?
    var spendingsData: CombinedChartData?
    
    func budget(viewModel: BudgetViewModel, didUpdateBudget data: PieChartData) {
        budgetData = data
    }
    
    func budget(viewModel: BudgetViewModel, didUpdateSpendings data: CombinedChartData) {
        spendingsData = data
    }
}
