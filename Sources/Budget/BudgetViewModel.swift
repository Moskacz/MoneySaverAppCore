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
    var delegate: BudgetViewModelDelegate? { get set }
}

public final class BudgetViewModelImpl: BudgetViewModel {
    
    weak var delegate: BudgetViewModelDelegate?
    
    private let budgetRepository: BudgetRepository
    private let transactionsRepository: TransactionsRepository
    private let chartsDataProcessor: BudgetChartsDataProcessor
    private var observationToken: ObservationToken?
    
    public init(budgetRepository: BudgetRepository,
                transactionsRepository: TransactionsRepository,
                chartsDataProcessor: BudgetChartsDataProcessor) {
        self.budgetRepository = budgetRepository
        self.transactionsRepository = transactionsRepository
        self.chartsDataProcessor = chartsDataProcessor
        registerForNotifications()
    }
    
    private func registerForNotifications() {
        observationToken = transactionsRepository.observeTransactionsChanged(callback: { (transactions) in
            
        })
    }
    
    private func updateBudgetData(transactions: [TransactionProtocol], budget: Decimal) {
        
    }
}
