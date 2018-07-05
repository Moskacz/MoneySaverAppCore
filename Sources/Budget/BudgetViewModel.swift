//
//  BudgetViewModel.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 27.06.2018.
//

import Foundation
import Charts

public protocol BudgetViewModelDelegate: class {
    func budget(viewModel: BudgetViewModel, didUpdateBudget data: PieChartData)
    func budget(viewModel: BudgetViewModel, didUpdateSpendings data: CombinedChartData)
}

public protocol BudgetViewModel {
    var delegate: BudgetViewModelDelegate? { get set }
}


