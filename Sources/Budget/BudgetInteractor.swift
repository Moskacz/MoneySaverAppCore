//
//  BudgetInteractor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 19/11/2018.
//

import Foundation

public protocol BudgetInteractorProtocol {
    func loadData()
}

internal class BudgetInteractor: BudgetInteractorProtocol {
    private let budgetRepository: BudgetRepository
    private let transactionsRepository: TransactionsRepository
    private let calendar: CalendarProtocol
    
    private var observationTokens = [ObservationToken]()
    private var budget: BudgetProtocol?
    private var expenses: [TransactionProtocol]?
    
    weak var presenter: BudgetPresenterProtocol?
    
    internal init(budgetRepository: BudgetRepository,
                  transactionsRepository: TransactionsRepository,
                  calendar: CalendarProtocol) {
        self.budgetRepository = budgetRepository
        self.transactionsRepository = transactionsRepository
        self.calendar = calendar
    }
    
    func loadData() {
        let transactionsToken = transactionsRepository.observeTransactionsChanged { [unowned self] transactions in
            let monthOfEra = self.calendar.nowCalendarDate.monthOfEra
            self.expenses = transactions.with(monthOfEra: monthOfEra).expenses
            self.notifyPresenter()
        }
        
        let budgetToken = budgetRepository.observeBudgetChanged { [unowned self] budget in
            self.budget = budget
            self.notifyPresenter()
        }
        
        observationTokens = [transactionsToken, budgetToken]
    }
    
    private func notifyPresenter() {
        guard let expenses = expenses, let budget = budget else { return }
        presenter?.dataUpdated(budget: budget, expenses: expenses)
    }
}
