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
            resultsController.delegate = display
        }
    }
    
    internal init(repository: TransactionCategoryRepository) {
        self.repository = repository
        self.resultsController = repository.allCategoriesResultController
    }
    
    private func loadData() {
        do {
            try resultsController.loadData()
            display?.resultsControllerDidChangeContent()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var numberOfCategories: Int {
        return resultsController.objectsIn(section: 0)?.count ?? 0
    }
    
    func categoryViewModel(at indexPath: IndexPath) -> TransactionCategoryCellViewModel {
        let category = resultsController.object(at: indexPath)
        return TransactionCategoryCellViewModelImpl(category: category)
    }
}
