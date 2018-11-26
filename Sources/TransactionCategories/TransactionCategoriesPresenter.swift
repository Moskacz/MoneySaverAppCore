//
//  TransactionCategoriesPresenter.swift
//  MoneySaverAppCore
//
//  Created by Michal Moskala on 25/11/2018.
//

import Foundation
import MMFoundation

public protocol TransactionCategoriesPresenterProtocol: class {
    func start()
    func itemsLoaded(adapter: ListAdapter<TransactionCategoryItemProtocol>)
    func selectItem(at path: IndexPath)
}

internal class TransactionCategoriesPresenter {
    
    private let interactor: TransactionCategoriesCollectionInteractorProtocol
    
    weak var router: TransactionCategoriesListRouting?
    weak var view: TransactionCategoriesCollectionUIProtocol?
    
    internal init(interactor: TransactionCategoriesCollectionInteractorProtocol) {
        self.interactor = interactor
    }
}

extension TransactionCategoriesPresenter: TransactionCategoriesPresenterProtocol {
    
    func start() {
        interactor.loadData()
    }
    
    func itemsLoaded(adapter: ListAdapter<TransactionCategoryItemProtocol>) {
        view?.displayList(with: adapter)
    }
    
    func selectItem(at path: IndexPath) {
        let category = interactor.transactionCategory(at: path)
        router?.categorySelected(category)
    }
}
