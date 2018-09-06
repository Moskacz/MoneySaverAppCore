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
        let transaction = resultsController.object(at: index.indexPath)
        return TransactionCellViewModelImpl(transaction: transaction, formatter: dateAndTimeFormatter)
    }
    
    func titleFor(section: Int) -> String? {
        guard
            let transaction = resultsController.objectsIn(section: section)?.first,
            let date = transaction.transactionDate.map({ Date(timeIntervalSince1970: $0.timeInterval) }) else {
            return nil
        }
        
        return dateFormatter.string(from: date)
    }
    
    func markTransactionForDeletion(indexPath: IndexPath) {
        
    }
    
    private var dateAndTimeFormatter: DateFormatter {
        return DateFormatters.formatter(forType: .dateWithTime)
    }
    
    private var dateFormatter: DateFormatter {
        return DateFormatters.formatter(forType: .dateOnly)
    }
}

private extension ListItemIndex {
    
    var indexPath: IndexPath {
        return IndexPath(item: row, section: section)
    }
}
