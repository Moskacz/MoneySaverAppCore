//
//  StatsInteractor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 25/11/2018.
//

import Foundation

internal protocol StatsInteractorProtocol: class {
    var preferredGrouping: TransactionsGrouping? { get set }
    func loadTransactions()
}

internal class StatsInteractor {
    
    weak var presenter: StatsPresenterProtocol?
    
    private let repository: TransactionsRepository
    private let userPreferences: UserPreferences
    
    private var transactions: [TransactionProtocol]?
    private var token: ObservationToken?
    
    internal init(repository: TransactionsRepository,
                  userPreferences: UserPreferences) {
        self.repository = repository
        self.userPreferences = userPreferences
    }
}

extension StatsInteractor: StatsInteractorProtocol {
    
    var preferredGrouping: TransactionsGrouping? {
        get { return userPreferences.statsGrouping }
        set { userPreferences.statsGrouping = newValue }
    }
    
    func loadTransactions() {
        if let fetchedTransactions = transactions {
            presenter?.dataLoaded(transactions: fetchedTransactions)
            return
        }
        
        token = repository.observeTransactionsChanged { transactions in
            self.transactions = transactions
            self.presenter?.dataLoaded(transactions: transactions)
        }
    }
}


