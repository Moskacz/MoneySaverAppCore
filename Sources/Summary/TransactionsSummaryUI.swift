//
//  TransactionsSummaryDisplaying.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 06.09.2018.
//

import Foundation

public protocol TransactionsSummaryUI: class {
    var presenter: TransactionsSummaryPresenterProtocol? { get set }
    func set(incomesText: String?)
    func set(expenseText: String?)
    func set(totalAmountString: String?)
    func set(dateRangeTitle: String?)
}


