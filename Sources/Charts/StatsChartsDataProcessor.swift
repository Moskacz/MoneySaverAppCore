//
//  StatsChartsDataProcessor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 07.06.2018.
//

import Foundation

protocol StatsChartsDataProcessor {
    func expensesGroupedBy(grouping: TransactionsGrouping, transactions: [TransactionProtocol]) -> [PlotValue]
    func incomesGroupedBy(grouping: TransactionsGrouping, transactions: [TransactionProtocol]) -> [PlotValue]
    func expensesGroupedByCategories(_ transactions: [TransactionProtocol]) -> [PlotValue]
}

extension ChartsDataProcessor: StatsChartsDataProcessor {
    
    func expensesGroupedBy(grouping: TransactionsGrouping, transactions: [TransactionProtocol]) -> [PlotValue] {
        return []
    }
    
    func incomesGroupedBy(grouping: TransactionsGrouping, transactions: [TransactionProtocol]) -> [PlotValue] {
        return []
    }
    
    func expensesGroupedByCategories(_ transactions: [TransactionProtocol]) -> [PlotValue] {
        return []
    }
}
