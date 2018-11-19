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
    func deleteItem(at path: IndexPath)
}

internal class TransactionsListInteractor: TransactionsListInteractorProtocol {
    
    private unowned let presenter: TransactionsListPresenterProtocol
    private let repository: TransactionsRepository
    private var resultsController: ResultsController<TransactionProtocol>?
    
    internal init(presenter: TransactionsListPresenterProtocol, repository: TransactionsRepository) {
        self.presenter = presenter
        self.repository = repository
    }
    
    func loadData() {
        let resultsController = self.repository.allTransactionsResultController
        let adapter = TransactionsListAdapter(resultsController: resultsController)
        presenter.dataLoaded(adapter: adapter)
        self.resultsController = resultsController
    }
    
    func deleteItem(at path: IndexPath) {
        let transaction = resultsController!.object(at: path)
        repository.remove(transaction: transaction)
    }
    
    private class TransactionsListAdapter: ListAdapter<TransactionCellItemProtocol> {
        
        private let resultsController: ResultsController<TransactionProtocol>
        
        override weak var delegate: ResultsControllerDelegate? {
            set { resultsController.delegate = newValue }
            get { return resultsController.delegate }
        }
        
        internal init(resultsController: ResultsController<TransactionProtocol>) {
            self.resultsController = resultsController
            super.init()
        }
        
        override var numberOfSections: Int {
            return resultsController.sectionsCount
        }
        
        override func numberOfRows(in section: Int) -> Int {
            return resultsController.objectsIn(section: section)?.count ?? 0
        }
        
        override func item(at indexPath: IndexPath) -> TransactionCellItemProtocol {
            let item = resultsController.object(at: indexPath)
            return TransactionCellItem(transaction: item, formatter: DateFormatters.formatter(forType: .dateWithTime))
        }
        
        override func title(for section: Int) -> String? {
            guard let transactionTimestamp = resultsController.objectsIn(section: section)?.first?.transactionDate?.timeInterval else {
                return nil
            }
            let date = Date(timeIntervalSince1970: transactionTimestamp)
            return DateFormatters.formatter(forType: .dateOnly).string(from: date)
        }
    }
}
