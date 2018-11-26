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
    func transactionCategory(at path: IndexPath) -> TransactionCategoryProtocol
}

internal class TransactionCategoriesCollectionInteractor {
    
    private let repository: TransactionCategoryRepository
    private let logger: Logger
    private var resultsController: ResultsController<TransactionCategoryProtocol>?
    
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
            let listAdapter = CategoriesListAdapter(resultsController: resultsController)
            presenter?.itemsLoaded(adapter: listAdapter)
            self.resultsController = resultsController
        } catch {
            logger.log(withLevel: .error, message: error.localizedDescription)
        }
    }
    
    func transactionCategory(at path: IndexPath) -> TransactionCategoryProtocol {
        return resultsController!.object(at: path)
    }
    
    private class CategoriesListAdapter: ListAdapter<TransactionCategoryItemProtocol> {
        
        private let resultsController: ResultsController<TransactionCategoryProtocol>
        
        override var delegate: ResultsControllerDelegate? {
            get { return resultsController.delegate }
            set { resultsController.delegate = newValue }
        }
        
        init(resultsController: ResultsController<TransactionCategoryProtocol>) {
            self.resultsController = resultsController
        }
        
        override var numberOfSections: Int { return 1 }
        
        override func numberOfRows(in section: Int) -> Int {
            return resultsController.objectsIn(section: section)?.count ?? 0
        }
        
        override func item(at indexPath: IndexPath) -> TransactionCategoryItemProtocol {
            let category = resultsController.object(at: indexPath)
            return TransactionCategoryItem(category: category)
        }
        
    }
}
