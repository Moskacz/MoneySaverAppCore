//
//  BudgetViewModel.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 27.06.2018.
//

import Foundation
import Charts

protocol BudgetViewModelDelegate: class {
    func budget(viewModel: BudgetViewModel, didUpdateBudget data: PieChartData)
    func budget(viewModel: BudgetViewModel, didUpdateSpendings data: CombinedChartData)
}

protocol BudgetViewModel {
    var delegate: BudgetViewModelDelegate { get set }
}
