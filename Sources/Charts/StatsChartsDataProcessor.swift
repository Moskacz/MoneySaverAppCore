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
        let groupedExpenses = group(transactions: transactions.negatives, by: grouping)
        return sortedPlotValues(from: groupedExpenses)
    }
    
    func incomesGroupedBy<T: TransactionProtocol>(grouping: TransactionsGrouping, transactions: [T]) -> [PlotValue] {
        let groupesIncomes = group(transactions: transactions.positives, by: grouping)
        return sortedPlotValues(from: groupesIncomes)
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
    
    private func sortedPlotValues<T: TransactionProtocol>(from groupedTransactions: [Int32: [T]]) -> [PlotValue] {
        let values = groupedTransactions.map { keyValueTuple -> PlotValue in
            let date = Int(keyValueTuple.key)
            let value = keyValueTuple.value.sum.decimalValue
            return PlotValue(x: date, y: value)
        }
        return values.sorted { $0.x < $1.x }
    }
}
