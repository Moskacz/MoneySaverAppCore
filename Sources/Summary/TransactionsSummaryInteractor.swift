//
//  TransactionsSummaryInteractor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 17/11/2018.
//

import Foundation

internal protocol TransactionsSummaryInteractorProtocol: class {
    
    var presenter: TransactionsSummaryPresenterProtocol? { get set }
    var dateRange: DateRange { get set }
    func computeSummary()
}

internal class TransactionsSummaryInteractor: TransactionsSummaryInteractorProtocol {
    
    internal weak var presenter: TransactionsSummaryPresenterProtocol?
    
    private let repository: TransactionsRepository
    private let calendar: CalendarProtocol
    private let userPrefs: UserPreferences
    private var token: ObservationToken?
    
    internal var dateRange: DateRange {
        set {
            userPrefs.dateRange = newValue
            computeUIState()
        }
        get { return userPrefs.dateRange }
    }
    
    private var sum: TransactionsCompoundSum? {
        didSet {
            computeUIState()
        }
    }
    
    internal init(repository: TransactionsRepository,
                  calendar: CalendarProtocol,
                  userPrefs: UserPreferences) {
        self.repository = repository
        self.calendar = calendar
        self.userPrefs = userPrefs
    }
    
    internal func computeSummary() {
        token = repository.observeTransactionsChanged { [unowned self] transactions in
            self.sum = transactions.compoundSum(date: self.calendar.nowCalendarDate)
            self.computeUIState()
        }
    }
    
    private func computeUIState() {
        guard let sum = sum else { return }
        computeUIState(sum: sum.sum(for: dateRange))
    }
    
    private func computeUIState(sum: TransactionsSum) {
        let state = TransactionsSummaryUIState(totalAmountText: (sum.expenses + sum.incomes).description,
                                               expensesAmountText: sum.expenses.description,
                                               incomesAmountText: sum.incomes.description,
                                               dateRangeButtonText: dateRange.description)
        presenter?.stateComputed(state)
    }
}

extension Sequence where Element == TransactionProtocol {
    
    internal func compoundSum(date: CalendarDateProtocol) -> TransactionsCompoundSum {
        var day = [Element]()
        var week = [Element]()
        var month = [Element]()
        var year = [Element]()
        
        for element in self {
            if element.transactionDate?.dayOfEra == date.dayOfEra {
                day.append(element)
            }
            if element.transactionDate?.weekOfEra == date.weekOfEra {
                week.append(element)
            }
            if element.transactionDate?.monthOfEra == date.monthOfEra {
                month.append(element)
            }
            if element.transactionDate?.year == date.year {
                year.append(element)
            }
        }
        
        return TransactionsCompoundSum(daily: day.transactionsSum,
                                       weekly: week.transactionsSum,
                                       monthly: month.transactionsSum,
                                       yearly: year.transactionsSum,
                                       era: self.transactionsSum)
    }
    
    internal var transactionsSum: TransactionsSum {
        return TransactionsSum(incomes: incomes.sum, expenses: expenses.sum)
    }
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

internal struct TransactionsSum {
    internal let incomes: Decimal
    internal let expenses: Decimal
}


