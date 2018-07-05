//
//  FakeChartsDataProcessor.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 18.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

class FakeChartsDataProcessor {
    public init() {}
}

extension FakeChartsDataProcessor: BudgetChartsDataProcessor {
    
    public func spendings(fromMonthlyExpenses expenses: [DatedValue]) -> [PlotValue] {
        fatalError()
    }
    
    public func estimatedSpendings(budgetValue: Double) -> [PlotValue] {
        fatalError()
    }
}

extension FakeChartsDataProcessor: StatsChartsDataProcessor {
    public func expensesGroupedBy(grouping: TransactionsGrouping, transactions: [TransactionProtocol]) -> [PlotValue] {
        return []
    }
    
    public func incomesGroupedBy(grouping: TransactionsGrouping, transactions: [TransactionProtocol]) -> [PlotValue] {
        return []
    }
    
    public func expensesGroupedByCategories(_ transactions: [TransactionProtocol]) -> [CategorySum] {
        return []
    }
}
