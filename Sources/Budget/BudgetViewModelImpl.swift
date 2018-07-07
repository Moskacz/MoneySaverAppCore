//
//  BudgetViewModelImpl.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 05.07.2018.
//

import Foundation

internal final class BudgetViewModelImpl: BudgetViewModel {
    
    internal weak var delegate: BudgetViewModelDelegate?
    
    private let budgetRepository: BudgetRepository
    private let transactionsRepository: TransactionsRepository
    private let chartsDataProcessor: BudgetChartsDataProcessor
    private var observationTokens = [ObservationToken]()
    
    public init(budgetRepository: BudgetRepository,
                transactionsRepository: TransactionsRepository,
                chartsDataProcessor: BudgetChartsDataProcessor) {
        self.budgetRepository = budgetRepository
        self.transactionsRepository = transactionsRepository
        self.chartsDataProcessor = chartsDataProcessor
        registerForNotifications()
    }
    
    private func registerForNotifications() {
        let transactionsToken = transactionsRepository.observeTransactionsChanged { transactions in
            
        }
        
        let budgetToken = budgetRepository.observeBudgetChanged { budget in
            
        }
        
        observationTokens = [transactionsToken, budgetToken]
    }
    
    private func updateBudgetData(transactions: [TransactionProtocol], budget: Double) {
        
        
    }
}
