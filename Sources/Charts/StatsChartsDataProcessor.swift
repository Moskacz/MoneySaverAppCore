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
    func expensesGroupedByCategories<T:TransactionProtocol>(_ transactions: [T]) -> [CategorySum]
}

public struct CategorySum {
    public let categoryName: String
    public let sum: Decimal
}

extension ChartsDataProcessor: StatsChartsDataProcessor {
    
    func expensesGroupedBy<T: TransactionProtocol>(grouping: TransactionsGrouping, transactions: [T]) -> [PlotValue] {
        let groupedExpenses = group(transactions: transactions.negatives, by: grouping)
        let sortedValues = sortedPlotValues(from: groupedExpenses)
        return insertMissingValues(into: sortedValues)
    }
    
    func incomesGroupedBy<T: TransactionProtocol>(grouping: TransactionsGrouping, transactions: [T]) -> [PlotValue] {
        let groupesIncomes = group(transactions: transactions.positives, by: grouping)
        let sortedValues = sortedPlotValues(from: groupesIncomes)
        return insertMissingValues(into: sortedValues)
    }
    
    func expensesGroupedByCategories<T: TransactionProtocol>(_ transactions: [T]) -> [CategorySum] {
        let groupesExpenses = transactions.negatives.grouped {
            return $0.transactionCategory?.name ?? "Unknown"
        }
        
        let sums = groupesExpenses.map { keyValueTuple -> CategorySum in
            let categoryName = keyValueTuple.key
            let categoryExpenses = keyValueTuple.value.sum.decimalValue
            return CategorySum(categoryName: categoryName, sum: categoryExpenses)
        }
        
        return sums.sorted { $0.categoryName < $1.categoryName }
    }
    
    private func group<T: TransactionProtocol>(transactions: [T], by grouping: TransactionsGrouping) -> [Int32: [T]] {
        let groupingKey: ((T) -> Int32?)
        switch grouping {
        case .dayOfEra: groupingKey = { $0.transactionDate?.dayOfEra }
        case .weekOfEra: groupingKey = { $0.transactionDate?.weekOfEra }
        case .monthOfEra: groupingKey = { $0.transactionDate?.monthOfEra }
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
    
    private func insertMissingValues(into plotValues: [PlotValue]) -> [PlotValue] {
        guard !plotValues.isEmpty else { return [] }
        
        var allValues = [PlotValue]()
        
        let minValue = plotValues.first!.x
        let maxValue = plotValues.last!.x
        
        var index = 0
        for i in minValue...maxValue {
            if plotValues[index].x == i {
                allValues.append(plotValues[index])
                index += 1
            } else {
                allValues.append(PlotValue(x: i, y: 0))
            }
        }
        
        return allValues
    }
}
