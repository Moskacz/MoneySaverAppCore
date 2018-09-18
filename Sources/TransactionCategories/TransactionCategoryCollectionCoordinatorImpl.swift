//
//  TransactionCategoriesCollectionCoordinatorImpl.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 18.09.2018.
//

import Foundation
import MMFoundation

internal class TransactionCategoryCollectionCoordinatorImpl: TransactionCategoryCollectionCoordinator {
    
    private let repository: TransactionCategoryRepository
    private let resultsController: ResultsController<TransactionCategoryProtocol>
    
    var display: TransactionCategoryCollectionDisplaying? {
         didSet {
            loadData()
        }
    }
    
    internal init(repository: TransactionCategoryRepository) {
        self.repository = repository
        self.resultsController = repository.allCategoriesResultController
    }
    
    private func loadData() {
        do {
            try resultsController.loadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
}
