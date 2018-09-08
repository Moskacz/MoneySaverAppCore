//
//  TransactionsSummaryCoordinator.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 06.09.2018.
//

import Foundation

public protocol TransactionsSummaryCoordinator {
    var display: TransactionsSummaryDisplaying? { get set }
    var dateRange: DateRange { get set }
}

