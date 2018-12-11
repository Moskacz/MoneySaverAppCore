//
//  TransactionCategoriesCollectionInteractor.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 25/11/2018.
//

import Foundation
import MMFoundation

internal protocol TransactionCategoriesCollectionInteractorProtocol {
    func loadData()
    func saveTransaction(data: TransactionData, category: TransactionCategoryProtocol)
}

internal class TransactionCategoriesCollectionInteractor {
    
    private let categoriesRepository: TransactionCategoryRepository
    private let transactionsRepository: TransactionsRepository
    private let logger: Logger
    
    weak var presenter: TransactionCategoriesPresenterProtocol?
    
    internal init(categoriesRepository: TransactionCategoryRepository,
                  transactionsRepository: TransactionsRepository,
                  logger: Logger) {
        self.categoriesRepository = categoriesRepository
        self.transactionsRepository = transactionsRepository
        self.logger = logger
    }
}

extension TransactionCategoriesCollectionInteractor: TransactionCategoriesCollectionInteractorProtocol {
    
    func loadData() {
        do {
            let resultsController = categoriesRepository.allCategoriesResultController
            try resultsController.loadData()
            presenter?.categoriesLoaded(resultsController: resultsController)
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
        }
    }
    
    func saveTransaction(data: TransactionData, category: TransactionCategoryProtocol) {
        transactionsRepository.addTransaction(data: data, category: category)
    }
}
