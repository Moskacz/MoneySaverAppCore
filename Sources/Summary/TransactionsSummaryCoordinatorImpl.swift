//
//  TransactionsSummaryCoordinatorImpl.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 06.09.2018.
//

import Foundation

internal class TransactionsSummaryCoordinatorImpl: TransactionsSummaryCoordinator {
    
    private let repository: TransactionsRepository
    private let calendar: CalendarProtocol
    private var token: ObservationToken?
    private var sum: TransactionsCompoundSum? {
        didSet {
            updateDisplay()
        }
    }
    
    var display: TransactionsSummaryDisplaying? {
        didSet {
            updateDisplay()
        }
    }
    
    var dateRange: DateRange {
        didSet {
            updateDisplay()
        }
    }
    
    internal init(repository: TransactionsRepository,
                  calendar: CalendarProtocol,
                  dateRange: DateRange) {
        self.repository = repository
        self.calendar = calendar
        self.dateRange = dateRange
        
        registerForNotifications()
    }
    
    private func registerForNotifications() {
        token = repository.observeTransactionsChanged { [unowned self] transactions in
            self.sum = transactions.compoundSum(date: self.calendar.nowCalendarDate)
        }
    }
    
    private func updateDisplay() {
        display?.updateWith(viewModel: makeViewModel())
    }
    
    private func makeViewModel() -> TransactionsSummaryViewModel {
        let currentSum = sum?.sum(for: dateRange)
        
        let incomes = currentSum.map { String($0.incomes) } ?? ""
        let expenses = currentSum.map { String($0.expenses) } ?? ""
        let total = currentSum.map { String($0.expenses + $0.incomes) } ?? ""
        
        return TransactionsSummaryViewModel(totalAmountText: total,
                                            expensesAmountText: expenses,
                                            incomesAmountText: incomes,
                                            dateRangeButtonText: dateRange.description)
    }
}

private extension TransactionsSummaryDisplaying {
    func updateWith(viewModel: TransactionsSummaryViewModel) {
        set(incomesText: viewModel.incomesAmountText)
        set(expenseText: viewModel.expensesAmountText)
        set(totalAmountString: viewModel.totalAmountText)
        set(dateRangeTitle: viewModel.dateRangeButtonText)
    }
}

public struct TransactionsSummaryViewModel {
    let totalAmountText: String
    let expensesAmountText: String
    let incomesAmountText: String
    let dateRangeButtonText: String
}

internal struct TransactionsSum {
    internal let incomes: Double
    internal let expenses: Double
}

internal struct TransactionsCompoundSum {
    internal let daily: TransactionsSum
    internal let weekly: TransactionsSum
    internal let monthly: TransactionsSum
    internal let yearly: TransactionsSum
    internal let era: TransactionsSum
    
    internal func sum(for dateRange: DateRange) -> TransactionsSum {
        switch dateRange {
        case .today: return daily
        case .thisWeek: return weekly
        case .thisMonth: return monthly
        case .thisYear: return yearly
        case .allTime: return era
        }
    }
}
