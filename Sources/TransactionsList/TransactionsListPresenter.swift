//
//  TransactionsListPresenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 18/11/2018.
//

import Foundation
import MMFoundation

public protocol TransactionsListPresenterProtocol: class {
    func loadData()
    func dataLoaded(adapter: ListAdapter<TransactionCellItemProtocol>)
    func deleteItem(at path: IndexPath)
}

internal class TransactionsListPresenter: TransactionsListPresenterProtocol {
    
    private unowned let display: TransactionsListUI & ResultsControllerDelegate
    private let interactor: TransactionsListInteractorProtocol
    
    internal init(display: TransactionsListUI & ResultsControllerDelegate,
                  interactor: TransactionsListInteractorProtocol) {
        self.display = display
        self.interactor = interactor
    }
    
    func loadData() {
        interactor.loadData()
    }
    
    func dataLoaded(adapter: ListAdapter<TransactionCellItemProtocol>) {
        display.displayList(with: adapter)
        adapter.delegate = display
    }
    
    func deleteItem(at path: IndexPath) {
        interactor.deleteItem(at: path)
    }
}


