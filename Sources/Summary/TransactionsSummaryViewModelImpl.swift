//
//  TransactionsSummaryViewModelImpl.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 10.07.2018.
//

import Foundation

internal class TransactionsSummaryViewModelImpl: TransactionsSummaryViewModel {
    
    internal weak var delegate: TransactionsSummaryViewModelDelegate?
    private let repository: TransactionsRepository
    private let calendar: CalendarProtocol
    
    private(set) var totalAmountText: String = "--"
    private(set) var expensesAmountText: String = "--"
    private(set) var incomesAmountText: String = "--"
    private(set) var dateRangeButtonText: String = "--"
    
    internal var dateRange: DateRange {
        didSet {
            updateValues()
        }
    }
    
    private var token: ObservationToken?
    private var sum: TransactionsCompoundSum? {
        didSet {
            updateValues()
        }
    }
    
    internal init(repository: TransactionsRepository, calendar: CalendarProtocol, dateRange: DateRange) {
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
    
    private func updateValues() {
        updateAmountTexts(sum: sum?.sum(for: dateRange))
        updateDateRangeButtonText()
        delegate?.transactionsSummaryDidUpdateValues(viewModel: self)
    }
    
    private func updateAmountTexts(sum: TransactionsSum?) {
        guard let sum = sum else {
            incomesAmountText = "--"
            expensesAmountText = "--"
            totalAmountText = "--"
            return
        }
        
        incomesAmountText = String(sum.incomes)
        expensesAmountText = String(sum.expenses)
        totalAmountText = String(sum.incomes + sum.expenses)
    }
    
    private func updateDateRangeButtonText() {
        dateRangeButtonText = dateRange.description
    }
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
