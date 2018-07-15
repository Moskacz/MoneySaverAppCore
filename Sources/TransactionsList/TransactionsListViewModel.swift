//
//  TransactionsListViewModel.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 14.07.2018.
//

import Foundation
import MMFoundation

public protocol TransactionsListViewModel {
    func resultsController() -> ResultsController<TransactionProtocol>
}
