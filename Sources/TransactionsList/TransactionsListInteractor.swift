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
    private let userPrefs: UserPreferences
    
    internal weak var presenter: TransactionsListPresenterProtocol?
    
    internal init(repository: TransactionsRepository, logger: Logger, userPrefs: UserPreferences) {
        self.repository = repository
        self.logger = logger
        self.userPrefs = userPrefs
        registerForNotifications()
    }
    
    private func registerForNotifications() {
        userPrefs.observeDateRangeChange { range in
            guard let dateRange = range else { return }
            self.loadData(dataRange: dateRange)
        }
    }
    
    func loadData() {
        loadData(dataRange: userPrefs.dateRange ?? .thisMonth)
    }
    
    private func loadData(dataRange: DateRange) {
        do {
            let resultsController = repository.transactionsResultsController(dateRange: dataRange)
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
