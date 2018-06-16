//
//  FakeChartsDataProcessor.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 18.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation

public class FakeChartsDataProcessor {
    
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
    
    public func expensesGroupedBy<T>(grouping: TransactionsGrouping, transactions: [T]) -> [PlotValue] where T : TransactionProtocol {
        fatalError()
    }
    
    public func incomesGroupedBy<T>(grouping: TransactionsGrouping, transactions: [T]) -> [PlotValue] where T : TransactionProtocol {
        fatalError()
    }
    
    public func expensesGroupedByCategories<T>(_ transactions: [T]) -> [CategorySum] where T : TransactionProtocol {
        fatalError()
    }
}
