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
    
    private unowned let presenter: TransactionsListPresenterProtocol
    private let repository: TransactionsRepository
    private let logger: Logger
    
    internal init(presenter: TransactionsListPresenterProtocol, repository: TransactionsRepository, logger: Logger) {
        self.presenter = presenter
        self.repository = repository
        self.logger = logger
    }
    
    func loadData() {
        do {
            let resultsController = repository.allTransactionsResultController
            try resultsController.loadData()
            presenter.transactionsLoaded(resultsController: resultsController)
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
        }
    }
    
    func delete(transaction: TransactionProtocol) {
        repository.remove(transaction: transaction)
    }
}
