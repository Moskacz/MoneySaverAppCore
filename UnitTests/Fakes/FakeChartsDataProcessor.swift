//
//  FakeChartsDataProcessor.swift
//  MoneySaverApp-iOSTests
//
//  Created by Michal Moskala on 18.04.2018.
//  Copyright © 2018 Michal Moskala. All rights reserved.
//

import Foundation
@testable import MoneySaverAppCore

class FakeChartsDataProcessor {
    public init() {}
}

extension FakeChartsDataProcessor: BudgetChartsDataProcessor {
    
    func incrementalDailyExpenses(transactions: [TransactionProtocol]) -> [PlotValue] {
        fatalError()
    }
    
    func estimatedSpendings(budgetValue: Double) -> [PlotValue] {
        fatalError()
    }
}

extension FakeChartsDataProcessor: StatsChartsDataProcessor {
    func expensesGroupedBy(grouping: TransactionsGrouping, transactions: [TransactionProtocol]) -> [PlotValue] {
        return []
    }
    
    func incomesGroupedBy(grouping: TransactionsGrouping, transactions: [TransactionProtocol]) -> [PlotValue] {
        return []
    }
    
    func expensesGroupedByCategories(_ transactions: [TransactionProtocol]) -> [CategorySum] {
        return []
    }
}
