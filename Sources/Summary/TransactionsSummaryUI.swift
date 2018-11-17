//
//  TransactionsSummaryDisplaying.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 06.09.2018.
//

import Foundation

public protocol TransactionsSummaryUI {
    func set(incomesText: String?)
    func set(expenseText: String?)
    func set(totalAmountString: String?)
    func set(dateRangeTitle: String?)
}


