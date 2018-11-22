//
//  Factory.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 22.07.2018.
//

import Foundation

public protocol Factory {
    func makeTransactionsSummaryCoordinator() -> TransactionsSummaryPresenterProtocol
    func makeTransactionDataCoordinator() -> TransactionDataViewCoordinator
    func makeStatsViewModel() -> StatsViewModel
}
