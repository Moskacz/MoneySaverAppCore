//
//  StatsChartsDataProcessor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 07.06.2018.
//

import Foundation

protocol StatsChartsDataProcessor {
    func expensesGroupedBy<T:TransactionProtocol>(grouping: TransactionsGrouping, transactions: [T]) -> [PlotValue]
    func incomesGroupedBy<T:TransactionProtocol>(grouping: TransactionsGrouping, transactions: [T]) -> [PlotValue]
    func expensesGroupedByCategories<T:TransactionProtocol>(_ transactions: [T]) -> [PlotValue]
}

extension ChartsDataProcessor: StatsChartsDataProcessor {
    
    func expensesGroupedBy<T: TransactionProtocol>(grouping: TransactionsGrouping, transactions: [T]) -> [PlotValue] {
        return []
    }
    
    func incomesGroupedBy<T: TransactionProtocol>(grouping: TransactionsGrouping, transactions: [T]) -> [PlotValue] {
        return []
    }
    
    func expensesGroupedByCategories<T: TransactionProtocol>(_ transactions: [T]) -> [PlotValue] {
        return []
    }
    
    private func group<T: TransactionProtocol>(transactions: [T], by grouping: TransactionsGrouping) -> [Int32: [T]] {
        let groupingKey: ((T) -> Int32?)
        switch grouping {
        case .day: groupingKey = { $0.transactionDate?.dayOfEra }
        case .week: groupingKey = { $0.transactionDate?.weekOfEra }
        case .month: groupingKey = { $0.transactionDate?.monthOfEra }
        }
        return transactions.grouped(by: groupingKey)
    }
}
