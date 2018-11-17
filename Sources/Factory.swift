//
//  Factory.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 22.07.2018.
//

import Foundation

public protocol Factory {
    func makeTransactionsListCoordinator() -> TransactionsListCoordinator
    func makeTransactionsSummaryCoordinator() -> TransactionsSummaryPresenterProtocol
    func makeTransactionDataCoordinator() -> TransactionDataViewCoordinator
    func makeBudgetViewModel() -> BudgetViewModel
    func makeStatsViewModel() -> StatsViewModel
}
