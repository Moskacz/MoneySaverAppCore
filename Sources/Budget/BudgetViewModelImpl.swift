//
//  BudgetViewModelImpl.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 05.07.2018.
//

import Foundation
import Charts
import MMFoundation

internal final class BudgetViewModelImpl: BudgetViewModel {
    
    internal weak var delegate: BudgetViewModelDelegate?
    
    private let budgetRepository: BudgetRepository
    private let transactionsRepository: TransactionsRepository
    private let chartsDataProcessor: BudgetChartsDataProcessor
    private let calendar: CalendarProtocol
    
    private var observationTokens = [ObservationToken]()
    private var budget: BudgetProtocol?
    private var expenses: [TransactionProtocol]?
    
    public init(budgetRepository: BudgetRepository,
                transactionsRepository: TransactionsRepository,
                chartsDataProcessor: BudgetChartsDataProcessor,
                calendar: CalendarProtocol) {
        self.budgetRepository = budgetRepository
        self.transactionsRepository = transactionsRepository
        self.chartsDataProcessor = chartsDataProcessor
        self.calendar = calendar
        registerForNotifications()
    }
    
    private func registerForNotifications() {
        let transactionsToken = transactionsRepository.observeTransactionsChanged { [unowned self] transactions in
            let monthOfEra = self.calendar.nowCalendarDate.monthOfEra
            self.expenses = transactions.with(monthOfEra: monthOfEra).expenses
            self.updateBudgetData()
        }
        
        let budgetToken = budgetRepository.observeBudgetChanged { [unowned self] budget in
            self.budget = budget
            self.updateBudgetData()
        }
        
        observationTokens = [transactionsToken, budgetToken]
    }
    
    private func updateBudgetData() {
        guard let expenses = expenses, let budget = budget else { return }
        
    }
    
    
}
