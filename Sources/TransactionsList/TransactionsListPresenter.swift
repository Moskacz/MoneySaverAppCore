//
//  TransactionsListPresenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 18/11/2018.
//

import Foundation
import MMFoundation

public protocol TransactionsListPresenterProtocol: class {
    func start()
    func transactionsLoaded(resultsController: ResultsController<TransactionProtocol>)
    var sectionsCount: Int { get }
    func itemsCount(in section: Int) -> Int
    func title(for section: Int) -> String
    func item(at indexPath: IndexPath) -> TransactionCellItemProtocol
    func deleteItem(at path: IndexPath)
}

internal class TransactionsListPresenter: TransactionsListPresenterProtocol {
    
    private unowned let display: TransactionsListUI & ResultsControllerDelegate
    private let interactor: TransactionsListInteractorProtocol
    private var resultsController: ResultsController<TransactionProtocol>?
    
    internal init(display: TransactionsListUI & ResultsControllerDelegate,
                  interactor: TransactionsListInteractorProtocol) {
        self.display = display
        self.interactor = interactor
    }
    
    func start() {
        interactor.loadData()
    }
    
    func transactionsLoaded(resultsController: ResultsController<TransactionProtocol>) {
        self.resultsController = resultsController
        self.resultsController!.delegate = display
    }

    var sectionsCount: Int {
        return resultsController?.sectionsCount ?? 0
    }
    
    func itemsCount(in section: Int) -> Int {
        return resultsController?.objectsIn(section: section)?.count ?? 0
    }
    
    func title(for section: Int) -> String {
        let transactionTimestamp = resultsController!.objectsIn(section: section)!.first!.transactionDate!.timeInterval
        let date = Date(timeIntervalSince1970: transactionTimestamp)
        return DateFormatters.formatter(forType: .dateOnly).string(from: date)
    }
    
    func item(at indexPath: IndexPath) -> TransactionCellItemProtocol {
        let transaction = resultsController!.object(at: indexPath)
        let formatter = DateFormatters.formatter(forType: .dateWithTime)
        return TransactionCellItem(transaction: transaction, formatter: formatter)
    }
    
    func deleteItem(at path: IndexPath) {
        let transaction = resultsController!.object(at: path)
        interactor.delete(transaction: transaction)
    }
}


