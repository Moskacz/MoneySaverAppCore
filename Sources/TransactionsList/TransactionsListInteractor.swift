//
//  TransactionsListInteractor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 18/11/2018.
//

import Foundation
import MMFoundation

public protocol TransactionsListInteractorProtocol {
    func loadData()
    func delete(transaction: TransactionProtocol)
}

internal class TransactionsListInteractor: TransactionsListInteractorProtocol {
    
    private let repository: TransactionsRepository
    private let logger: Logger
    
    internal weak var presenter: TransactionsListPresenterProtocol?
    
    internal init(repository: TransactionsRepository, logger: Logger) {
        self.repository = repository
        self.logger = logger
    }
    
    func loadData() {
        do {
            let resultsController = repository.allTransactionsResultController
            try resultsController.loadData()
            presenter?.transactionsLoaded(resultsController: resultsController)
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
        }
    }
    
    func delete(transaction: TransactionProtocol) {
        repository.remove(transaction: transaction)
    }
}
