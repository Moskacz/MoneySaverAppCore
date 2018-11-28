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
}

internal class TransactionCategoriesCollectionInteractor {
    
    private let repository: TransactionCategoryRepository
    private let logger: Logger
    
    weak var presenter: TransactionCategoriesPresenterProtocol?
    
    internal init(repository: TransactionCategoryRepository, logger: Logger) {
        self.repository = repository
        self.logger = logger
    }
}

extension TransactionCategoriesCollectionInteractor: TransactionCategoriesCollectionInteractorProtocol {
    
    func loadData() {
        do {
            let resultsController = repository.allCategoriesResultController
            try resultsController.loadData()
            presenter?.categoriesLoaded(resultsController: resultsController)
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
        }
    }
}
