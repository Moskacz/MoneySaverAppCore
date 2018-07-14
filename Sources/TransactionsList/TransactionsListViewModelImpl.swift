//
//  TransactionsListViewModelImpl.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 14.07.2018.
//

import Foundation
import MMFoundation

internal class TransactionsListViewModelImpl: TransactionsListViewModel {
    
    private let repository: TransactionsRepository
    
    internal init(repository: TransactionsRepository) {
        self.repository = repository
    }
    
    func resultsController() -> ResultsController<TransactionCellViewModel> {
        fatalError()
    }
}
