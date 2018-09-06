//
//  TransactionsListViewModelImpl.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 14.07.2018.
//

import Foundation
import MMFoundation

internal class TransactionsListCoordinatorImpl: TransactionsListCoordinator {
    
    private let repository: TransactionsRepository
    private let resultsController: ResultsController<TransactionProtocol>
    
    internal init(repository: TransactionsRepository) {
        self.repository = repository
        self.resultsController = repository.allTransactionsResultController
    }
    
    func set(delegate: ResultsControllerDelegate) {
        resultsController.delegate = delegate
    }
    
    var numberOfSections: Int {
        return resultsController.sectionsCount
    }
    
    func numberOfRowsIn(section: Int) -> Int {
        return resultsController.objectsIn(section: section)?.count ?? 0
    }
    
    func cellViewModelAt(index: ListItemIndex) -> TransactionCellViewModel {
        fatalError()
    }
    
    func titleFor(section: Int) -> String {
        fatalError()
    }
    
    func commitDeletionOfTransactionAt(indexPath: IndexPath) {
        
    }
}
