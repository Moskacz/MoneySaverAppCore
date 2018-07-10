//
//  TransactionsSummaryViewModel.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 10.07.2018.
//

import Foundation

public protocol TransactionsSummaryViewModelDelegate: class {
    func transactionsSummaryDidUpdateValues(viewModel: TransactionsSummaryViewModel)
}

public protocol TransactionsSummaryViewModel {
    var delegate: TransactionsSummaryViewModelDelegate? { get set }
    var totalAmountText: String { get }
    var expensesAmountText: String { get }
    var incomesAmountText: String { get }
    var dateRangeButtonText: String { get }
    var dateRange: DateRange { set get }
}
