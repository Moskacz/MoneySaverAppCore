//
//  StatsChartsDataProcessor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 07.06.2018.
//

import Foundation

internal protocol StatsChartsDataProcessor {
    func expensesGroupedBy(grouping: TransactionsGrouping, transactions: [TransactionProtocol]) -> [PlotValue]
    func incomesGroupedBy(grouping: TransactionsGrouping, transactions: [TransactionProtocol]) -> [PlotValue]
    func expensesGroupedByCategories(_ transactions: [TransactionProtocol]) -> [CategorySum]
}

internal struct CategorySum {
    public let categoryName: String
    public let sum: Double
}

extension ChartsDataProcessor: StatsChartsDataProcessor {
    
    internal func expensesGroupedBy(grouping: TransactionsGrouping, transactions: [TransactionProtocol]) -> [PlotValue] {
        let groupedExpenses = group(transactions: transactions.expenses, by: grouping)
        
        let sortedValues = sortedPlotValues(from: groupedExpenses)
        return insertMissingValues(into: sortedValues)
    }
    
    internal func incomesGroupedBy(grouping: TransactionsGrouping, transactions: [TransactionProtocol]) -> [PlotValue] {
        let groupesIncomes = group(transactions: transactions.incomes, by: grouping)
        let sortedValues = sortedPlotValues(from: groupesIncomes)
        return insertMissingValues(into: sortedValues)
    }
    
    internal func expensesGroupedByCategories(_ transactions: [TransactionProtocol]) -> [CategorySum] {
        let groupesExpenses = transactions.expenses.grouped {
            return $0.transactionCategory?.name ?? "Unknown"
        }

        let sums = groupesExpenses.map { keyValueTuple -> CategorySum in
            let categoryName = keyValueTuple.key
            let categoryExpenses = keyValueTuple.value.sum
            return CategorySum(categoryName: categoryName, sum: categoryExpenses)
        }

        return sums.sorted { $0.categoryName < $1.categoryName }
    }
    
    private func group(transactions: [TransactionProtocol], by grouping: TransactionsGrouping) -> [Int32: [TransactionProtocol]] {
        let groupingKey: ((TransactionProtocol) -> Int32?)
        switch grouping {
        case .dayOfEra: groupingKey = { $0.transactionDate?.dayOfEra }
        case .weekOfEra: groupingKey = { $0.transactionDate?.weekOfEra }
        case .monthOfEra: groupingKey = { $0.transactionDate?.monthOfEra }
        }
        return transactions.grouped(by: groupingKey)
    }
    
    private func sortedPlotValues(from groupedTransactions: [Int32: [TransactionProtocol]]) -> [PlotValue] {
        let values = groupedTransactions.map { keyValueTuple -> PlotValue in
            let date = Int(keyValueTuple.key)
            let value = keyValueTuple.value.sum
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
