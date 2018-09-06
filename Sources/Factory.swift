//
//  Factory.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 22.07.2018.
//

import Foundation

public protocol Factory {
    func makeTransactionsListViewModel() -> TransactionsListCoordinator
    func makeTransactionsSummaryViewModel() -> TransactionsSummaryViewModel
    func makeBudgetViewModel() -> BudgetViewModel
    func makeStatsViewModel() -> StatsViewModel
}
